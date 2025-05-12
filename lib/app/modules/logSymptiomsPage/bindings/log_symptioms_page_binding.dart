import 'package:get/get.dart';

import '../controllers/log_symptioms_page_controller.dart';

class LogSymptiomsPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LogSymptiomsPageController>(
      () => LogSymptiomsPageController(),
    );
  }
}
