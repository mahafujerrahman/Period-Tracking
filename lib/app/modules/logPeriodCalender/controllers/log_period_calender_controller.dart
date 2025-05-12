import 'package:get/get.dart';
import 'package:period_tracking/common/helpers/db_helper.dart';
import 'package:period_tracking/common/helpers/log_helper.dart';

class LogPeriodCalenderController extends GetxController {
  var menstrualCycle = ''.obs;
  var howLongWaslastPeriod = ''.obs;
  var lastPeriodStartDate = ''.obs;
  RxString predictedNextPeriodDate = ''.obs;
  Set<DateTime> selectedDays = {};

  Future<void> fetchAllDataFromTable(DatabaseHelper dbHelper) async {
    try {
      String tableName = 'user_info';
      List<Map<String, dynamic>> rows = await dbHelper.query(tableName);

      for (var row in rows) {
        LoggerHelper.debug(row.toString());
        menstrualCycle.value = row['menstrualCycle'];
        howLongWaslastPeriod.value = row['howLongWaslastPeriod'];
        lastPeriodStartDate.value = row['lastPeriodStartDate'];

        // Generate dates after loading data
        generateSelectedDays();
      }
    } catch (e) {
      LoggerHelper.error("Error fetching data: $e");
    }
  }

  void generateSelectedDays() {
    try {
      // Clear existing dates
      selectedDays.clear();

      // Parse input data
      final startDate = DateTime.parse(lastPeriodStartDate.value);
      final duration = int.parse(howLongWaslastPeriod.value);

      // Generate dates for the period duration
      for (int i = 0; i < duration; i++) {
        selectedDays.add(startDate.add(Duration(days: i)));
      }

      LoggerHelper.debug('Generated dates: ${selectedDays.join(', ')}');
    } catch (e) {
      LoggerHelper.error("Error generating dates: $e");
    }
  }

  Set<DateTime> getSelectedDates() {
    return selectedDays;
  }

  //save updated data to db

  var periodLength = ''.obs;
  var updatedStartDate = ''.obs;

  final dbHelper = DatabaseHelper(dbName: 'period_database.db');

  updatePeriodLength({required Set<DateTime> selectedDdays}) async {
    if (selectedDdays.isEmpty) {
      periodLength.value = '0';
      updatedStartDate.value = '';
      return;
    }

    final startDate = selectedDdays.reduce((a, b) => a.isBefore(b) ? a : b);

    updatedStartDate.value =
        "${startDate.year}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}";

    periodLength.value = selectedDdays.length.toString();

    if (selectedDdays.length >= 4) {
      final db = await dbHelper.database;
      final rows = await db.rawQuery('SELECT rowid, * FROM user_info LIMIT 1');
      if (rows.isNotEmpty) {
        final updateData = {
          'howLongWaslastPeriod': periodLength.value,
          'lastPeriodStartDate': updatedStartDate.value,
        };
        await db.update(
          'user_info',
          updateData,
          where: 'rowid = ?',
          whereArgs: [rows[0]['rowid']],
        );
      } else {
        final insertData = {
          'howLongWaslastPeriod': periodLength.value,
          'lastPeriodStartDate': updatedStartDate.value,
        };
        await dbHelper.insert('user_info', insertData);
      }
    }
  }
}
