import 'package:get/get.dart';

import '../controllers/change_pin_code_page_controller.dart';

class ChangePinCodePageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChangePinCodePageController>(
      () => ChangePinCodePageController(),
    );
  }
}
