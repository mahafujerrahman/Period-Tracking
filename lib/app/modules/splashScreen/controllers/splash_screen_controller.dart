import 'package:get/get.dart';
import 'package:period_tracking/app/data/app_constants.dart';
import 'package:period_tracking/app/routes/app_pages.dart';
import 'package:period_tracking/common/helpers/log_helper.dart';
import 'package:period_tracking/common/helpers/share_pref_helper.dart';

import '../../../../common/helpers/db_helper.dart';

class SplashScreenController extends GetxController {
  final dbHelper = DatabaseHelper(dbName: 'period_database.db');

  @override
  void onInit() {
    super.onInit();
    checkTokenAndNavigate();
  }

  Future<bool> checkUserPinTable() async {
    try {
      final db = await dbHelper.database;

      // Query to check if the table exists
      final tables = await db.rawQuery(
        "SELECT name FROM sqlite_master WHERE type='table' AND name='user_pin'",
      );

      // Check if the table was found
      if (tables.isNotEmpty) {
        LoggerHelper.info("==========>>user_pin table found<<==========");
        return true;
      } else {
        LoggerHelper.info("==========>>user_pin table not found<<==========");
        return false;
      }
    } catch (e) {
      LoggerHelper.info("==========>>Error checking user_pin table: $e<<==========");
      return false;
    }
  }

  Future<void> checkTokenAndNavigate() async {
    await Future.delayed(const Duration(seconds: 3));

    //check if user already used the app
    var hasAlreadyUsed = await PrefsHelper.getBool(AppConstants.hasUsed);

    if (hasAlreadyUsed == false) {
      Get.offAllNamed(Routes.ONBORDING_SCREEN);
    } else {
      //check if user_pin table exists
      bool userPinExists = await checkUserPinTable();

      if (userPinExists) {
        // If user_pin table exists, route to PIN code page
        Get.offAllNamed(Routes.LOGIN_PIN_CODE_PAGE);
      } else {
        // If user_pin table doesn't exist, route to home page
        Get.offAllNamed(Routes.HOME);
      }
    }

    // Close database connection after navigation
    // await dbHelper.close();
  }
}