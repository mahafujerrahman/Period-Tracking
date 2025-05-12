import 'package:get/get.dart';

import '../controllers/change_step_two_pin_code_page_controller.dart';

class ChangeStepTwoPinCodePageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChangeStepTwoPinCodePageController>(
      () => ChangeStepTwoPinCodePageController(),
    );
  }
}
