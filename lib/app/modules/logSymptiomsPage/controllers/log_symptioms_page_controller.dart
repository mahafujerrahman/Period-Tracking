import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:period_tracking/app/routes/app_pages.dart';
import 'package:period_tracking/common/helpers/db_helper.dart';
import 'package:period_tracking/common/helpers/log_helper.dart';

class LogSymptiomsPageController extends GetxController {
  final TextEditingController noteController = TextEditingController();
  final dbHelper = DatabaseHelper(dbName: 'period_database.db');
  RxDouble moodValue = 5.0.obs;
  RxDouble energyValue = 5.0.obs;
  RxString? selectedMenstrualFlow = ''.obs;
  RxSet<String> selectedSymptoms = <String>{}.obs;
  RxString? selectedSex = ''.obs;

  RxString? selectedDate = ''.obs;


  saveLogSymptomps() async {
    if (selectedDate?.value != '' || selectedDate!.value.isNotEmpty) {

      DateTime parsedDate = DateTime.parse(selectedDate!.value);
      int weekday = parsedDate.weekday;

      Map<String, dynamic> symptopms = {
        "moood": moodValue.value.toInt().toString(),
        "energy": energyValue.value.toInt().toString(),
        "menstrualFlow": selectedMenstrualFlow?.value,
        "symptoms": selectedSymptoms.toString(),
        "sex": selectedSex?.value,
        "note": noteController.text,
        // "date": DateTime.now().toUtc().toString().split(" ")[0],
        "date": selectedDate?.value,
        "dayName": weekday,
        // "insertTime":DateTime.now().toString()
      };

      await dbHelper.insert('user_log_symptoms', symptopms);

      moodValue.value = 5;
      energyValue.value = 5;
      selectedMenstrualFlow?.value = '';
      selectedDate?.value = '';
      selectedSymptoms.clear();
      selectedSex?.value = '';
      noteController.text = '';

      LoggerHelper.warn("cleared data: ===========>");
      LoggerHelper.warn("cleared date: ===========> ${selectedDate?.value}");
      Get.toNamed(Routes.HOME);
    } else {
      if (!Get.isSnackbarOpen) {
        Get.snackbar(
          "Please select a date!",
          "You must have to select Date",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );

        moodValue.value = 5;
        energyValue.value = 5;
        selectedMenstrualFlow?.value = '';
        selectedDate?.value = '';
        selectedSymptoms.clear();
        selectedSex?.value = '';
        noteController.text = '';
      }
    }
  }
}
