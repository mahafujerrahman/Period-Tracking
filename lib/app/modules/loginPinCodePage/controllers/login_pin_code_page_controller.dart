import 'dart:ui';

import 'package:get/get.dart';
import 'package:period_tracking/app/routes/app_pages.dart';
import 'package:period_tracking/common/helpers/db_helper.dart';
import 'package:period_tracking/common/helpers/log_helper.dart';

class LoginPinCodePageController extends GetxController {
  var pinCode = ''.obs;
  final dbHelper = DatabaseHelper(dbName: 'period_database.db');
  var isWrongPass = false.obs;

  //match pin code `pinCode` in `user_pin` table using the helper class.
  matchPinCodeAndNavigate({VoidCallback? onSuccess}) async {
    try {
     // final userPIN = {'pinCode': pinCode.value};

      // Query the database to check if the pin code exists
      final results = await dbHelper.query(
        'user_pin',
        where: 'pinCode = ?',
        whereArgs: [pinCode.value],
      );

      if (results.isNotEmpty) {
        // Pin code matches, navigate to the next page
        onSuccess?.call();
        Get.offAllNamed(Routes.HOME);

        LoggerHelper.info('Pin code matches');
        // Add navigation logic here
      } else {
        // Pin code does not match
        isWrongPass(true);
        update();
        LoggerHelper.info('Pin code does not match');
        pinCode.value='';
      }
    } catch (e) {
      LoggerHelper.error('Error matching pin code: $e');
    }
  }
}
