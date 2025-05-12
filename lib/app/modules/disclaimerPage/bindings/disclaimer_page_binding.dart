import 'package:get/get.dart';

import '../controllers/disclaimer_page_controller.dart';

class DisclaimerPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DisclaimerPageController>(
      () => DisclaimerPageController(),
    );
  }
}
