import 'package:get/get.dart';

import '../controllers/period_length_selection_screen_controller.dart';

class PeriodLengthSelectionScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PeriodLengthSelectionScreenController>(
      () => PeriodLengthSelectionScreenController(),
    );
  }
}
