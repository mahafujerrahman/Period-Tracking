import 'package:get/get.dart';
import 'package:period_tracking/app/routes/app_pages.dart';
import 'package:period_tracking/common/helpers/db_helper.dart';

class LastPeriodSelectionScreenController extends GetxController {
  final dbHelper = DatabaseHelper(dbName: 'period_database.db');

  var averangeMenstrualCycle = ''.obs;
  var periodLastFor = ''.obs;
  var menstrualCycleDescribByUser = ''.obs;
  var lastMenstrualStartDate = ''.obs;

  // final dbService = DatabaseService();

  saveInfo() async {

    //check for validation and sanitation input
    // if(averangeMenstrualCycle.value.contains("I am not sure")){
    //   averangeMenstrualCycle.value="3";
    // }
    // if()

    var userInfo = {
      'menstrualCycle': averangeMenstrualCycle.value,
      'howLongWaslastPeriod': periodLastFor.value,
      'menstrualCycleDescribByUser': menstrualCycleDescribByUser.value,
      'lastPeriodStartDate': lastMenstrualStartDate.value.toString().split(" ")[0],
    };
    await dbHelper.insert('user_info', userInfo).then((_){
      Get.toNamed(Routes.HOME);
    });

    // await dbHelper.close();
  }
}
