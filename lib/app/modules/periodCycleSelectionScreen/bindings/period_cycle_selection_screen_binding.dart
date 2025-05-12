import 'package:get/get.dart';

import '../controllers/period_cycle_selection_screen_controller.dart';

class PeriodCycleSelectionScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PeriodCycleSelectionScreenController>(
      () => PeriodCycleSelectionScreenController(),
    );
  }
}
