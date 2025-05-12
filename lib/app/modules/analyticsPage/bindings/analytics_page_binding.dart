import 'package:get/get.dart';

import '../controllers/analytics_page_controller.dart';

class AnalyticsPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AnalyticsPageController>(
      () => AnalyticsPageController(),
    );
  }
}
