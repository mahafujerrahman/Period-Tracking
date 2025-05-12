import 'package:get/get.dart';

import '../controllers/set_week_first_day_page_controller.dart';

class SetWeekFirstDayPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SetWeekFirstDayPageController>(
      () => SetWeekFirstDayPageController(),
    );
  }
}
