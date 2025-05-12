import 'package:get/get.dart';
import 'package:period_tracking/common/helpers/db_helper.dart';

class SetWeekFirstDayPageController extends GetxController {
  var dayName = ''.obs;
  final _dbHelper = DatabaseHelper(dbName: 'period_database.db');

  setFirstDay() async {
    final tableExists = await _dbHelper.tableExists('first_day');

    var day = {'weekFirstDay': dayName.value};

    if (!tableExists) {
      await _dbHelper.insert('first_day', day);
    } else {
      await _dbHelper.update('first_day', day);
    }
  }
}
