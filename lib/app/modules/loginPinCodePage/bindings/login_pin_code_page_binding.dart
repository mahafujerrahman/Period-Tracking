import 'package:get/get.dart';

import '../controllers/login_pin_code_page_controller.dart';

class LoginPinCodePageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginPinCodePageController>(
      () => LoginPinCodePageController(),
    );
  }
}
