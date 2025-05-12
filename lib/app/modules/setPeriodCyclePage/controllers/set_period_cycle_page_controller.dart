import 'package:get/get.dart';
import 'package:period_tracking/common/helpers/db_helper.dart';

class SetPeriodCyclePageController extends GetxController {
  var menstrualCycle = ''.obs;
  final dbHelper = DatabaseHelper(dbName: 'period_database.db');

  // update the data

  updateMenstrualCycle() async {
    final db = await dbHelper.database;

    // Check if the table has data
    final rows = await db.rawQuery('SELECT rowid, * FROM user_info LIMIT 1');
    if (rows.isNotEmpty) {
      // Update the first row using rowid
      final updateData = {'menstrualCycle': menstrualCycle.value};
      await db.update('user_info', updateData, where: 'rowid = ?', whereArgs: [rows[0]['rowid']]);
    } else {
      // Insert new data if no rows exist
      final insertData = {'menstrualCycle': menstrualCycle.value};
      await dbHelper.insert('user_info', insertData);
    }
  }

}
