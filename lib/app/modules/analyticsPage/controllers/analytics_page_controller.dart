import 'package:get/get.dart';
import 'package:period_tracking/common/helpers/db_helper.dart';
import 'package:period_tracking/common/helpers/log_helper.dart';

class AnalyticsPageController extends GetxController {
  RxList<Map<String, dynamic>> symptomsData = <Map<String, dynamic>>[].obs;
  var noDataFound = false.obs;
  var weekFirstDay = ''.obs;
  // For weekly view
  var selectedWeekStart = DateTime.now().subtract(Duration(days: DateTime.now().weekday - 1)).obs;
  // For monthly view
  var isMonthlyView = false.obs;
  var selectedMonth = DateTime.now().month.obs;
  var selectedYear = DateTime.now().year.obs;

  Future<void> fetchAllDataFromTable(DatabaseHelper dbHelper) async {
    try {
      String tableName = 'user_log_symptoms';

      List<Map<String, dynamic>> rows = await dbHelper.query(tableName);

      // Ensure each row has a proper date field
      for (var row in rows) {
        if (!row.containsKey('date') && row.containsKey('dayName') &&
            row.containsKey('month') && row.containsKey('year')) {
          // If date is not present but we have day, month, year, construct it
          int day = int.parse(row['dayName'].toString());
          int month = int.parse(row['month'].toString());
          int year = int.parse(row['year'].toString());
          row['date'] = DateTime(year, month, day).toIso8601String();
        }
      }

      symptomsData.assignAll(rows);
      LoggerHelper.info(
        "==========>>Data Retrieved from Table $tableName<<==========",
      );
      LoggerHelper.debug(rows);
    } catch (e) {
      noDataFound(true);
      update();
      LoggerHelper.error("Error fetching data: $e");
    }
  }

  // Get data for the current week only
  List<double> getMenstrualFlowData() {
    List<double> flowData = List.generate(7, (index) => 0);

    // Calculate start and end of the selected week
    final weekStart = selectedWeekStart.value;
    final weekEnd = weekStart.add(Duration(days: 6));

    for (var entry in symptomsData) {
      try {
        // Parse date from entry
        DateTime entryDate;
        if (entry.containsKey('date') && entry['date'] != null) {
          entryDate = DateTime.parse(entry['date']);
        } else {
          int day = int.parse(entry['dayName'].toString());
          int month = int.tryParse(entry['month']?.toString() ?? '') ?? DateTime.now().month;
          int year = int.tryParse(entry['year']?.toString() ?? '') ?? DateTime.now().year;
          entryDate = DateTime(year, month, day);
        }

        // Check if the entry falls within the current week
        if (entryDate.isAfter(weekStart.subtract(Duration(days: 1))) &&
            entryDate.isBefore(weekEnd.add(Duration(days: 1)))) {
          // Calculate day index (0 for first day of week, 6 for last)
          final dayIndex = entryDate.difference(weekStart).inDays;
          if (dayIndex >= 0 && dayIndex < 7) {
            final flowValue = _mapFlowToValue(entry['menstrualFlow'].toString());
            flowData[dayIndex] = flowValue.toDouble();
          }
        }
      } catch (e) {
        LoggerHelper.error("Error processing entry for weekly flow: $e");
      }
    }
    return flowData;
  }

  // Get data for the current month only
  List<double> getMonthlyMenstrualFlowData() {
    int daysInMonth = DateTime(selectedYear.value, selectedMonth.value + 1, 0).day;
    List<double> flowData = List.generate(daysInMonth, (index) => 0);

    for (var entry in symptomsData) {
      try {
        // Parse date from entry
        DateTime entryDate;
        if (entry.containsKey('date') && entry['date'] != null) {
          entryDate = DateTime.parse(entry['date']);
        } else {
          int day = int.parse(entry['dayName'].toString());
          int month = int.tryParse(entry['month']?.toString() ?? '') ?? DateTime.now().month;
          int year = int.tryParse(entry['year']?.toString() ?? '') ?? DateTime.now().year;
          entryDate = DateTime(year, month, day);
        }

        // Check if the entry falls within the selected month and year
        if (entryDate.month == selectedMonth.value && entryDate.year == selectedYear.value) {
          final day = entryDate.day;
          final flowValue = _mapFlowToValue(entry['menstrualFlow'].toString());
          if (day <= daysInMonth) {
            flowData[day - 1] = flowValue.toDouble();
          }
        }
      } catch (e) {
        LoggerHelper.error("Error processing entry for monthly flow: $e");
      }
    }
    return flowData;
  }

  // Get mood and energy data for the selected month
  List<List<double>> getMonthlyMoodEnergyData() {
    int daysInMonth = DateTime(selectedYear.value, selectedMonth.value + 1, 0).day;
    List<List<double>> moodEnergyData = List.generate(daysInMonth, (index) => [0, 0]);

    for (var entry in symptomsData) {
      try {
        // Parse date from entry
        DateTime entryDate;
        if (entry.containsKey('date') && entry['date'] != null) {
          entryDate = DateTime.parse(entry['date']);
        } else {
          int day = int.parse(entry['dayName'].toString());
          int month = int.tryParse(entry['month']?.toString() ?? '') ?? DateTime.now().month;
          int year = int.tryParse(entry['year']?.toString() ?? '') ?? DateTime.now().year;
          entryDate = DateTime(year, month, day);
        }

        // Check if the entry falls within the selected month and year
        if (entryDate.month == selectedMonth.value && entryDate.year == selectedYear.value) {
          final day = entryDate.day;
          final mood = entry['moood'];
          final energy = entry['energy'];
          if (day <= daysInMonth) {
            moodEnergyData[day - 1] = [double.parse(mood ?? '0'), double.parse(energy ?? '0')];
          }
        }
      } catch (e) {
        LoggerHelper.error("Error processing entry for monthly mood/energy: $e");
      }
    }
    return moodEnergyData;
  }

  // Get mood and energy data for the current week
  List<List<double>> getMoodEnergyData() {
    List<List<double>> moodEnergyData = List.generate(7, (index) => [0, 0]);

    // Calculate start and end of the selected week
    final weekStart = selectedWeekStart.value;
    final weekEnd = weekStart.add(Duration(days: 6));

    for (var entry in symptomsData) {
      try {
        // Parse date from entry
        DateTime entryDate;
        if (entry.containsKey('date') && entry['date'] != null) {
          entryDate = DateTime.parse(entry['date']);
        } else {
          int day = int.parse(entry['dayName'].toString());
          int month = int.tryParse(entry['month']?.toString() ?? '') ?? DateTime.now().month;
          int year = int.tryParse(entry['year']?.toString() ?? '') ?? DateTime.now().year;
          entryDate = DateTime(year, month, day);
        }

        // Check if the entry falls within the current week
        if (entryDate.isAfter(weekStart.subtract(Duration(days: 1))) &&
            entryDate.isBefore(weekEnd.add(Duration(days: 1)))) {
          // Calculate day index (0 for first day of week, 6 for last)
          final dayIndex = entryDate.difference(weekStart).inDays;
          if (dayIndex >= 0 && dayIndex < 7) {
            final mood = entry['moood'];
            final energy = entry['energy'];
            moodEnergyData[dayIndex] = [double.parse(mood ?? '0'), double.parse(energy ?? '0')];
          }
        }
      } catch (e) {
        LoggerHelper.error("Error processing entry for weekly mood/energy: $e");
      }
    }
    return moodEnergyData;
  }

  // Get days for the month view
  List<int> getMonthDays() {
    int daysInMonth = DateTime(selectedYear.value, selectedMonth.value + 1, 0).day;
    return List.generate(daysInMonth, (index) => index + 1);
  }

  // Get day names for the current week
  List<String> getCurrentWeekDays() {
    List<String> dayNames = [];
    final weekStart = selectedWeekStart.value;

    for (int i = 0; i < 7; i++) {
      final day = weekStart.add(Duration(days: i));
      dayNames.add(_getShortDayName(day.weekday));
    }

    return dayNames;
  }

  // Helper to get short day name
  String _getShortDayName(int weekday) {
    switch (weekday) {
      case 1: return 'Mon';
      case 2: return 'Tue';
      case 3: return 'Wed';
      case 4: return 'Thu';
      case 5: return 'Fri';
      case 6: return 'Sat';
      case 7: return 'Sun';
      default: return '';
    }
  }

  // Navigate to previous week
  void previousWeek() {
    selectedWeekStart.value = selectedWeekStart.value.subtract(Duration(days: 7));
    update();
  }

  // Navigate to next week
  void nextWeek() {
    selectedWeekStart.value = selectedWeekStart.value.add(Duration(days: 7));
    update();
  }

  // Navigate to previous month
  void previousMonth() {
    if (selectedMonth.value > 1) {
      selectedMonth.value--;
    } else {
      selectedMonth.value = 12;
      selectedYear.value--;
    }
    update();
  }

  // Navigate to next month
  void nextMonth() {
    if (selectedMonth.value < 12) {
      selectedMonth.value++;
    } else {
      selectedMonth.value = 1;
      selectedYear.value++;
    }
    update();
  }

  double _mapFlowToValue(String flow) {
    switch (flow) {
      case 'Light':
        return 1.0;
      case 'Medium':
        return 2.0;
      case 'Heavy':
        return 3.0;
      default:
        return 0.0;
    }
  }

  // period_database
  final DatabaseHelper _dbHelper = DatabaseHelper(dbName: 'period_database.db');

  Future<void> initialize() async {
    await checkFirstDayTable(_dbHelper);
    await fetchAllDataFromTable(_dbHelper);
  }

  // Check week first day
  Future<void> checkFirstDayTable(DatabaseHelper dbHelper) async {
    try {
      final tableExists = await dbHelper.tableExists('first_day');
      if (tableExists) {
        final data = await dbHelper.query('first_day');
        if (data.isNotEmpty) {
          weekFirstDay.value = data.first['weekFirstDay'].toString();

          // Set the selected week start based on first day preference
          _adjustSelectedWeekStart();
        }
      }
    } catch (e) {
      LoggerHelper.error("Error checking first_day table: $e");
    }
  }

  // Adjust selected week start based on first day preference
  void _adjustSelectedWeekStart() {
    DateTime now = DateTime.now();
    int currentWeekday = now.weekday; // 1 for Monday, 7 for Sunday

    int firstDayOffset = 1; // Default: Monday as first day (offset 1)

    switch (weekFirstDay.value.toLowerCase()) {
      case 'sat':
        firstDayOffset = 6;
        break;
      case 'sun':
        firstDayOffset = 7;
        break;
      case 'mon':
      default:
        firstDayOffset = 1;
        break;
    }

    // Calculate days to subtract to get to the first day of the week
    int daysToSubtract = (currentWeekday - firstDayOffset) % 7;
    if (daysToSubtract < 0) daysToSubtract += 7;

    selectedWeekStart.value = now.subtract(Duration(days: daysToSubtract));
  }
}