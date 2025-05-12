import 'package:get/get.dart';
import 'package:period_tracking/common/helpers/db_helper.dart';

class SetPeriodDatePageController extends GetxController {
  List<String> items = ["3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15"];

  var periodLength = ''.obs;
  final dbHelper = DatabaseHelper(dbName: 'period_database.db');

  updatePeriodLength() async {
    final db = await dbHelper.database;

    // Check if the table has data
    final rows = await db.rawQuery('SELECT rowid, * FROM user_info LIMIT 1');
    if (rows.isNotEmpty) {
      final updateData = {'howLongWaslastPeriod': periodLength.value};
      await db.update(
        'user_info',
        updateData,
        where: 'rowid = ?',
        whereArgs: [rows[0]['rowid']],
      );
    } else {
      final insertData = {'howLongWaslastPeriod': periodLength.value};
      await dbHelper.insert('user_info', insertData);
    }
  }
}
