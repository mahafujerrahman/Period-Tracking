import 'package:get/get.dart';

import '../controllers/set_period_date_page_controller.dart';

class SetPeriodDatePageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SetPeriodDatePageController>(
      () => SetPeriodDatePageController(),
    );
  }
}
