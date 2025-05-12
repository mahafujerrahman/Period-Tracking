import 'package:get/get.dart';

import '../controllers/usual_period_selection_screen_controller.dart';

class UsualPeriodSelectionScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UsualPeriodSelectionScreenController>(
      () => UsualPeriodSelectionScreenController(),
    );
  }
}
