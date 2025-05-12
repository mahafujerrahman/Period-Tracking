import 'package:get/get.dart';

import '../controllers/log_period_calender_controller.dart';

class LogPeriodCalenderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LogPeriodCalenderController>(
      () => LogPeriodCalenderController(),
    );
  }
}
