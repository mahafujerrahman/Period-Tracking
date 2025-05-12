import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:period_tracking/common/helpers/db_helper.dart';
import 'package:period_tracking/common/helpers/log_helper.dart';

import '../../calenderScreen/controllers/calender_screen_controller.dart';

class HomeController extends GetxController {
  final CalenderScreenController calenderController = Get.put(CalenderScreenController(),);

  var menstrualCycle = ''.obs;
  var howLongWaslastPeriod = ''.obs;
  var lastPeriodStartDate = ''.obs;
  RxString predictedNextPeriodDate = ''.obs;
  RxString remainingDay = ''.obs;
  var cycleDay = 0.obs;
  var nextOvulationDay = ''.obs;
  var nextOvulationIN = ''.obs;
  var noSymptoms = false.obs;
  var noOverview = false.obs;
  var noPredictions = false.obs;
  Rx<DateTime> nextOvulationUtc = DateTime.now().obs;

  Future<void> fetchUserInfo(DatabaseHelper dbHelper) async {
    try {
      String tableName = 'user_info';
      List<Map<String, dynamic>> rows = await dbHelper.query(tableName);

      for (var row in rows) {
        LoggerHelper.debug(row.toString());
        menstrualCycle.value = row['menstrualCycle'];
        howLongWaslastPeriod.value = row['howLongWaslastPeriod'];
        lastPeriodStartDate.value = row['lastPeriodStartDate'];
      }
    } catch (e) {
      noOverview(true);
      update();
      LoggerHelper.error("Error user_info: $e");
    }

    // Parse the lastPeriodStartDate
    DateTime lastPeriodDate = DateFormat(
      'yyyy-MM-dd',
    ).parse(lastPeriodStartDate.value);

    // Calculate total days to add
    int totalDaysToAdd =
        int.parse(menstrualCycle.value) + int.parse(howLongWaslastPeriod.value);

    // Calculate the next period date
    DateTime nextPeriodDate = lastPeriodDate.add(
      Duration(days: totalDaysToAdd),
    );
    // Calculate remaining days between now and next period date
    int daysRemaining = nextPeriodDate.difference(DateTime.now()).inDays;

    // Format the remaining days string
    remainingDay.value = 'in $daysRemaining days';

    // Format the predicted next period date as "MMM d"
    predictedNextPeriodDate.value = DateFormat('MMM d').format(nextPeriodDate);

    // Calculate ovulation day (typically 14 days before next period)
    DateTime nextOvulationDate = nextPeriodDate.subtract(Duration(days: 14));
    nextOvulationDay.value = DateFormat('MMM d').format(nextOvulationDate);

    // Calculate days until ovulation
    int daysUntilOvulation =
        nextOvulationDate.difference(DateTime.now()).inDays;

    // Handle cases where ovulation day is in the past for the current cycle
    if (daysUntilOvulation < 0) {
      // Calculate the next cycle's ovulation date
      DateTime nextCycleOvulationDate = nextOvulationDate.add(
        Duration(days: int.parse(menstrualCycle.value)),
      );
      daysUntilOvulation =
          nextCycleOvulationDate.difference(DateTime.now()).inDays;
      nextOvulationIN.value = 'in $daysUntilOvulation days';
      //need a datetime for next ovulation in utc format that date I can use later.
      nextOvulationUtc.value = nextCycleOvulationDate.toUtc();

      LoggerHelper.warn(nextOvulationUtc);
    } else {
      // Add the "in x days" format to the ovulation day
      nextOvulationIN.value = 'in ${daysUntilOvulation + 1} days';
      nextOvulationUtc.value = nextOvulationDate.toUtc();
    }

    // Get today's date
    DateTime today = DateTime.now();

    // Calculate the difference in days between today and the last period start date
    int daysSinceLastPeriod = today.difference(lastPeriodDate).inDays;

    // Calculate the cycle day (modulo the menstrual cycle length to handle multiple cycles)
    // Adding 1 because day counting typically starts at 1, not 0
    cycleDay.value =
        (daysSinceLastPeriod % int.parse(menstrualCycle.value)) + 1;

    LoggerHelper.debug("Current cycle day: ${cycleDay.value}");
    LoggerHelper.debug("Next ovulation day: ${nextOvulationDay.value}");

    LoggerHelper.debug("========>> menstrual${predictedNextPeriodDate.value}");
  }

  //fetch sysptomps
  RxList<String> uniqueSymptomsList = <String>[].obs;

  Future<void> fetchUserLogSymptoms(DatabaseHelper dbHelper) async {
    calenderController.getAllData();
    calenderController.generateNextSixOvulationDates(dbHelper);

    String today = DateTime.now().toIso8601String().split('T')[0];
    Set<String> symptomsSet = {};

    try {
      String tableName = 'user_log_symptoms';
      List<Map<String, dynamic>> rows = await dbHelper.query(tableName);

      for (var row in rows) {
        if (row['date'] == today) {
          String symptomsStr = row['symptoms'].toString();

          // Remove curly braces and split by comma
          List<String> symptomsList =
              symptomsStr
                  .replaceAll(RegExp(r'^\{|\}$'), '')
                  .split(', ')
                  .map((e) => e.trim())
                  .toList();

          symptomsSet.addAll(symptomsList);
        }
        LoggerHelper.debug(row.toString());
      }
    } catch (e) {
      noSymptoms(true);
      update();
      LoggerHelper.error("Error fetching data: $e");
    }

    uniqueSymptomsList.value = symptomsSet.toList();
    LoggerHelper.debug("converted list ${uniqueSymptomsList.length}");
  }
}
