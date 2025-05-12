import 'package:get/get.dart';

import '../controllers/confirm_pin_code_page_controller.dart';

class ConfirmPinCodePageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ConfirmPinCodePageController>(
      () => ConfirmPinCodePageController(),
    );
  }
}
