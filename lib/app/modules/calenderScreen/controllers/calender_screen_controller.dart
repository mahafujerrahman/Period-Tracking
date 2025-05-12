import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:period_tracking/common/helpers/db_helper.dart';
import 'package:period_tracking/common/helpers/log_helper.dart';
import 'package:sqflite/sqflite.dart';

class CalenderScreenController extends GetxController {
  final RxMap<DateTime, List<String>> events = <DateTime, List<String>>{}.obs;

  final RxMap<DateTime, Map<String, dynamic>> dailyData =
      <DateTime, Map<String, dynamic>>{}.obs;

  final RxMap<DateTime, List<String>> ovulationEvents =
      <DateTime, List<String>>{}.obs;

  var weekFirstDay = ''.obs;

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
  Rx<DateTime> nextOvulationUtc = DateTime.now().obs;

  getAllData() async {
    LoggerHelper.warn("Call from homepage");
    final dbHelper = DatabaseHelper(dbName: 'period_database.db');

    try {
      final data = await dbHelper.query('user_log_symptoms');
      LoggerHelper.debug("===========>>>");
      LoggerHelper.debug("<<<===========");

      // Clear previous events
      events.clear();

      // Process the data to populate events
      for (var record in data) {
        // Parse the date and normalize it to UTC midnight
        DateTime fullDate = DateTime.parse(record['date']);
        // Create a clean date with just year, month, day in UTC
        DateTime date = DateTime.utc(
          fullDate.year,
          fullDate.month,
          fullDate.day,
        );
        String menstrualFlow = record['menstrualFlow'] ?? '';
        String sex = record['sex'] ?? '';
        String symptoms = record['symptoms'] ?? '';

        // Create event list for this date if it doesn't exist
        if (!events.containsKey(date)) {
          events[date] = [];
        }

        // Add events based on data
        if (menstrualFlow.isNotEmpty && !events[date]!.contains('drop')) {
          events[date]!.add('drop');
        }
        if (sex.isNotEmpty && !events[date]!.contains('heart')) {
          events[date]!.add('heart');
        }

        //  {20-12-20 00000z:['drop','heart']}
        // New symptoms processing logic
        if (symptoms.isNotEmpty) {
          // Remove brackets and split symptoms
          List<String> symptomList =
              symptoms
                  .replaceAll('{', '')
                  .replaceAll('}', '')
                  .split(',')
                  .map((s) => s.trim())
                  .toList();

          // Track added categories to prevent duplicates
          Set<String> addedCategories = {};

          // Check for pain symptoms
          List<String> painSymptoms = [
            'Headache',
            'Breast Tenderness',
            'Backache',
            'Cramps',
          ];

          if (symptomList.any((symptom) => painSymptoms.contains(symptom)) &&
              !addedCategories.contains('pain')) {
            events[date]!.add('pain');
            addedCategories.add('pain');
          }

          // Check for other discharge
          if (symptomList.contains('Other Discharge') &&
              !addedCategories.contains('other')) {
            events[date]!.add('other');
            addedCategories.add('other');
          }

          // Add dot for Other Symptoms if not already added
          if (symptomList.contains('Other Symptoms') &&
              !events[date]!.contains('dot')) {
            events[date]!.add('dot');
          }
        }

        // Store data for this date
        dailyData[date] = {
          'menstrualFlow': record['menstrualFlow'] ?? '',
          'note': record['note'] ?? '',
          'mood': record['moood'] ?? '',
          'energy': record['energy'] ?? '',
          'symptoms': record['symptoms'] ?? '',
        };
      }
      update();
      LoggerHelper.info(events);
    } catch (e) {
      LoggerHelper.error('Error is: $e');
      if (e is DatabaseException) {
        /*if(!Get.isSnackbarOpen){

        }*/
      }
    }
  }

  Future<void> checkFirstDayTable(DatabaseHelper dbHelper) async {
    try {
      final tableExists = await dbHelper.tableExists('first_day');
      if (tableExists) {
        final data = await dbHelper.query('first_day');
        if (data.isNotEmpty) {
          weekFirstDay.value = data.first['weekFirstDay'].toString();
        }
      }
    } catch (e) {
      LoggerHelper.error("Error checking first_day table: $e");
    }
  }

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

  Future<void> generateNextSixOvulationDates(DatabaseHelper dbHelper) async {
    try {
      // 1. Fetch and validate data
      await fetchUserInfo(dbHelper);
      if (ovulationEvents.isNotEmpty) ovulationEvents.clear();

      final lastPeriodDate = DateFormat(
        'yyyy-MM-dd',
      ).parse(lastPeriodStartDate.value);
      final cycleLength =
          int.tryParse(menstrualCycle.value) ?? 28; // Fallback to 28 if invalid

      if (cycleLength <= 0)
        throw ArgumentError("Invalid menstrual cycle length");

      // 2. Calculate ovulation windows (6 windows of 6 days each)
      DateTime ovulationStart = lastPeriodDate.add(
        Duration(days: cycleLength - 14),
      ); // First ovulation day

      for (int window = 0; window < 13; window++) {
        for (int day = 0; day < 2; day++) {
          final date = DateTime.utc(
            ovulationStart.year,
            ovulationStart.month,
            ovulationStart.day + day,
          );
          ovulationEvents[date] = ["ovulation"];
        }
        ovulationStart = ovulationStart.add(
          Duration(days: cycleLength),
        ); // Next window
      }

      // 3. Debug output (formatted for readability)
      // LoggerHelper.debug(
      //     "Generated ${ovulationEvents.length} ovulation days:\n"
      //         "${ovulationEvents.keys.map((d) => DateFormat('yyyy-MM-dd').format(d)).join('\n')}"
      // );

      LoggerHelper.debug(ovulationEvents);
    } catch (e) {
      LoggerHelper.error("Failed to generate dates: $e");
      rethrow; // Optional: Propagate error to caller
    }
  }

  void mergeOvulationEvents() {
    final DatabaseHelper _dbHelper = DatabaseHelper(
      dbName: 'period_database.db',
    );
    generateNextSixOvulationDates(_dbHelper);
    ovulationEvents.forEach((DateTime date, List<String> ovulationTags) {
      events.update(date, (existingTags) {
        final combinedTags =
            [...existingTags, ...ovulationTags].toSet().toList();
        return combinedTags;
      }, ifAbsent: () => ovulationTags);
    });
  }
  //
  // Future<RxList<DateTime>> getPredictedPeriodDatesForNextYear() async {
  //   await addPredictedPeriodsToEvents();
  //
  // }



  Future<void> addPredictedPeriodsToEvents() async {
    final dbHelper = DatabaseHelper(dbName: 'period_database.db');

    try {
      // 1. Fetch user data with null checks
      final userInfo = await dbHelper.query('user_info');
      if (userInfo.isEmpty || userInfo.first.isEmpty) {
        LoggerHelper.warn('No user info available for predictions');
        return;
      }

      // 2. Parse with validation and fallbacks
      final lastPeriodDate = DateTime.tryParse(userInfo.first['lastPeriodStartDate']?.toString() ?? '');
      final cycleDays = int.tryParse(userInfo.first['menstrualCycle']?.toString() ?? '') ?? 28;
      final periodLength = int.tryParse(userInfo.first['howLongWaslastPeriod']?.toString() ?? '') ?? 5;

      if (lastPeriodDate == null) {
        LoggerHelper.error('Invalid last period date format');
        return;
      }

      // 3. Calculate prediction parameters
      final firstPredictionStart = lastPeriodDate.add(Duration(days: cycleDays));
      final predictionEndDate = DateTime.now().add(const Duration(days: 365)); // 1 year ahead

      // 4. Generate and add predicted periods
      DateTime currentStart = firstPredictionStart;
      while (currentStart.isBefore(predictionEndDate)) {
        for (int day = 0; day < periodLength; day++) {
          final currentDate = DateTime.utc(
            currentStart.year,
            currentStart.month,
            currentStart.day + day,
          );

          // Handle existing entries without duplicates
          events.update(
            currentDate,
                (existing) => existing.contains('predicted_drop') ? existing : [...existing, 'predicted_drop'],
            ifAbsent: () => ['predicted_drop'],
          );
        }

        // Move to next cycle
        currentStart = currentStart.add(Duration(days: cycleDays));
      }

      LoggerHelper.info(
          'Added predicted periods from ${DateFormat('yyyy-MM-dd').format(firstPredictionStart)} '
              'to ${DateFormat('yyyy-MM-dd').format(predictionEndDate)}'
      );
      update();

    } catch (e, stackTrace) {
      LoggerHelper.error(
        'Failed to add predicted periods',
        // error: e,
        // stackTrace: stackTrace,
      );
      // Optional: Re-throw if caller needs to handle
      // throw Exception('Prediction failed: $e');
    }
  }

}
