import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:period_tracking/app/routes/app_pages.dart';
import 'package:period_tracking/common/helpers/db_helper.dart';

class PinCodePageController extends GetxController {
  var pinCode = ''.obs;
  var confirmPinCode = ''.obs;
  final dbHelper = DatabaseHelper(dbName: 'period_database.db');

  setPinCode() async {
    if (confirmPinCode.value == pinCode.value) {
      var userPIN = {'pinCode': pinCode.value};
      await dbHelper.insert('user_pin', userPIN).then((_) {
        pinCode.value = '';
        confirmPinCode.value = '';
        Get.offAndToNamed(Routes.INFO_PAGE);
      });
    } else {
      Get.snackbar(
        "Not matched",
        "Both pin code should be same",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      confirmPinCode.value = '';
    }


  }
}
