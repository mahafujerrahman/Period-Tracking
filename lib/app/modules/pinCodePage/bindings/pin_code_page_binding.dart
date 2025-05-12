import 'package:get/get.dart';

import '../controllers/pin_code_page_controller.dart';

class PinCodePageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PinCodePageController>(
      () => PinCodePageController(),
    );
  }
}
