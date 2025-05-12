import 'package:get/get.dart';

import '../controllers/onbording_screen_controller.dart';

class OnbordingScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OnbordingScreenController>(
      () => OnbordingScreenController(),
    );
  }
}
