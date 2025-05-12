import 'package:get/get.dart';

import '../../../../common/helpers/db_helper.dart' show DatabaseHelper;

class ChangePinCodePageController extends GetxController {
  var updatedPinCode = ''.obs;
  var updatedConfirmPinCode = ''.obs;
  var currentPinCode = ''.obs;
  var pinInDB = ''.obs;
  var wrongPass = false.obs;
  final dbHelper = DatabaseHelper(dbName: 'period_database.db');

  //write code for get current pin,
  @override
  void onInit() {
    super.onInit();
    getCurrentPin();
  }

  Future<void> getCurrentPin() async {
    final userPins = await dbHelper.query('user_pin');

    if (userPins.isNotEmpty) {
      // Get the PIN code from the first record in the table
      pinInDB.value = userPins.first['pinCode'] ?? '';
    } else {
      // No PIN code found in the database
      pinInDB.value = '';
    }
  }

  updatePinCode() async {
    var userPIN = {'pinCode': updatedPinCode.value};

    if (currentPinCode.value == pinInDB.value) {
      if (updatedConfirmPinCode.value == updatedPinCode.value) {
        final existingPins = await dbHelper.query('user_pin');
        if (existingPins.isEmpty) {
          // If no existing PIN, insert a new one
          await dbHelper.insert('user_pin', userPIN);
        } else {
          // If PIN exists, update it
          await dbHelper.update('user_pin', userPIN);
        }
      } else {
        if (!Get.isSnackbarOpen) {
          Get.snackbar(
            "PIN Does Not Match",
            "Confirm PIN and PIN must be same",
            snackPosition: SnackPosition.BOTTOM,
          );
        }
      }
    } else {
      wrongPass(true);
      update();
    }
  }
}
