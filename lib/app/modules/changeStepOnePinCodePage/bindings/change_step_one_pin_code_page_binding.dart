import 'package:get/get.dart';

import '../controllers/change_step_one_pin_code_page_controller.dart';

class ChangeStepOnePinCodePageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChangeStepOnePinCodePageController>(
      () => ChangeStepOnePinCodePageController(),
    );
  }
}
