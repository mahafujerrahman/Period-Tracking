import 'package:get/get.dart';

import '../controllers/set_pin_change_pin_page_controller.dart';

class SetPinChangePinPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SetPinChangePinPageController>(
      () => SetPinChangePinPageController(),
    );
  }
}
