import 'package:get/get.dart';

import '../controllers/setting_termspage_page_controller.dart';

class SettingTermspagePageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SettingTermspagePageController>(
      () => SettingTermspagePageController(),
    );
  }
}
