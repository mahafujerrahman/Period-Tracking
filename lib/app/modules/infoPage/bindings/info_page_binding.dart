import 'package:get/get.dart';

import '../controllers/info_page_controller.dart';

class InfoPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InfoPageController>(
      () => InfoPageController(),
    );
  }
}
