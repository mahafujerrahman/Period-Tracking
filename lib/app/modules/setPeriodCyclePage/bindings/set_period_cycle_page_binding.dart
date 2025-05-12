import 'package:get/get.dart';

import '../controllers/set_period_cycle_page_controller.dart';

class SetPeriodCyclePageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SetPeriodCyclePageController>(
      () => SetPeriodCyclePageController(),
    );
  }
}
