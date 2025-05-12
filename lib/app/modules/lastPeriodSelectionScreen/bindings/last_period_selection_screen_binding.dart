import 'package:get/get.dart';

import '../controllers/last_period_selection_screen_controller.dart';

class LastPeriodSelectionScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LastPeriodSelectionScreenController>(
      () => LastPeriodSelectionScreenController(),
    );
  }
}
