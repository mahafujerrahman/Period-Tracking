import 'package:get/get.dart';

import '../controllers/calender_screen_controller.dart';

class CalenderScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CalenderScreenController>(
      () => CalenderScreenController(),
    );
  }
}
