import 'package:get/get.dart';

import '../controllers/terms_condition_screen_controller.dart';

class TermsConditionScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TermsConditionScreenController>(
      () => TermsConditionScreenController(),
    );
  }
}
