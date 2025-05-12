import 'package:get/get.dart';

import '../modules/aboutUsPage/bindings/about_us_page_binding.dart';
import '../modules/aboutUsPage/views/about_us_page_view.dart';
import '../modules/analyticsPage/bindings/analytics_page_binding.dart';
import '../modules/analyticsPage/views/analytics_page_view.dart';
import '../modules/calenderScreen/bindings/calender_screen_binding.dart';
import '../modules/calenderScreen/views/calender_screen_view.dart';
import '../modules/changePinCodePage/bindings/change_pin_code_page_binding.dart';
import '../modules/changePinCodePage/views/change_pin_code_page_view.dart';
import '../modules/changeStepOnePinCodePage/bindings/change_step_one_pin_code_page_binding.dart';
import '../modules/changeStepOnePinCodePage/views/change_step_one_pin_code_page_view.dart';
import '../modules/changeStepTwoPinCodePage/bindings/change_step_two_pin_code_page_binding.dart';
import '../modules/changeStepTwoPinCodePage/views/change_step_two_pin_code_page_view.dart';
import '../modules/confirmPinCodePage/bindings/confirm_pin_code_page_binding.dart';
import '../modules/confirmPinCodePage/views/confirm_pin_code_page_view.dart';
import '../modules/disclaimerPage/bindings/disclaimer_page_binding.dart';
import '../modules/disclaimerPage/views/disclaimer_page_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/infoPage/bindings/info_page_binding.dart';
import '../modules/infoPage/views/info_page_view.dart';
import '../modules/lastPeriodSelectionScreen/bindings/last_period_selection_screen_binding.dart';
import '../modules/lastPeriodSelectionScreen/views/last_period_selection_screen_view.dart';
import '../modules/logPeriodCalender/bindings/log_period_calender_binding.dart';
import '../modules/logPeriodCalender/views/log_period_calender_view.dart';
import '../modules/logSymptiomsPage/bindings/log_symptioms_page_binding.dart';
import '../modules/logSymptiomsPage/views/log_symptioms_page_view.dart';
import '../modules/loginPinCodePage/bindings/login_pin_code_page_binding.dart';
import '../modules/loginPinCodePage/views/login_pin_code_page_view.dart';
import '../modules/onbordingScreen/bindings/onbording_screen_binding.dart';
import '../modules/onbordingScreen/views/onbording_screen_view.dart';
import '../modules/periodCycleSelectionScreen/bindings/period_cycle_selection_screen_binding.dart';
import '../modules/periodCycleSelectionScreen/views/period_cycle_selection_screen_view.dart';
import '../modules/periodLengthSelectionScreen/bindings/period_length_selection_screen_binding.dart';
import '../modules/periodLengthSelectionScreen/views/period_length_selection_screen_view.dart';
import '../modules/pinCodePage/bindings/pin_code_page_binding.dart';
import '../modules/pinCodePage/views/pin_code_page_view.dart';
import '../modules/privacyPolicyPage/bindings/privacy_policy_page_binding.dart';
import '../modules/privacyPolicyPage/views/privacy_policy_page_view.dart';
import '../modules/setPeriodCyclePage/bindings/set_period_cycle_page_binding.dart';
import '../modules/setPeriodCyclePage/views/set_period_cycle_page_view.dart';
import '../modules/setPeriodDatePage/bindings/set_period_date_page_binding.dart';
import '../modules/setPeriodDatePage/views/set_period_date_page_view.dart';
import '../modules/setPinChangePinPage/bindings/set_pin_change_pin_page_binding.dart';
import '../modules/setPinChangePinPage/views/set_pin_change_pin_page_view.dart';
import '../modules/setWeekFirstDayPage/bindings/set_week_first_day_page_binding.dart';
import '../modules/setWeekFirstDayPage/views/set_week_first_day_page_view.dart';
import '../modules/settingTermspagePage/bindings/setting_termspage_page_binding.dart';
import '../modules/settingTermspagePage/views/setting_termspage_page_view.dart';
import '../modules/splashScreen/bindings/splash_screen_binding.dart';
import '../modules/splashScreen/views/splash_screen_view.dart';
import '../modules/termsConditionScreen/bindings/terms_condition_screen_binding.dart';
import '../modules/termsConditionScreen/views/terms_condition_screen_view.dart';
import '../modules/usualPeriodSelectionScreen/bindings/usual_period_selection_screen_binding.dart';
import '../modules/usualPeriodSelectionScreen/views/usual_period_selection_screen_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH_SCREEN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
      transition: Transition.noTransition
    ),
    GetPage(
      name: _Paths.SPLASH_SCREEN,
      page: () => const SplashScreenView(),
      binding: SplashScreenBinding(),
      transition: Transition.noTransition
    ),
    GetPage(
      name: _Paths.ONBORDING_SCREEN,
      page: () => const OnbordingScreenView(),
      binding: OnbordingScreenBinding(),
      transition: Transition.noTransition
    ),
    GetPage(
      name: _Paths.TERMS_CONDITION_SCREEN,
      page: () => const TermsConditionScreenView(),
      binding: TermsConditionScreenBinding(),
      transition: Transition.noTransition
    ),
    GetPage(
      name: _Paths.PERIOD_LENGTH_SELECTION_SCREEN,
      page: () => const PeriodLengthSelectionScreenView(),
      binding: PeriodLengthSelectionScreenBinding(),
      transition: Transition.noTransition
    ),
    GetPage(
      name: _Paths.USUAL_PERIOD_SELECTION_SCREEN,
      page: () => const UsualPeriodSelectionScreenView(),
      binding: UsualPeriodSelectionScreenBinding(),
      transition: Transition.noTransition
    ),
    GetPage(
      name: _Paths.PERIOD_CYCLE_SELECTION_SCREEN,
      page: () => const PeriodCycleSelectionScreenView(),
      binding: PeriodCycleSelectionScreenBinding(),
      transition: Transition.noTransition
    ),
    GetPage(
      name: _Paths.LAST_PERIOD_SELECTION_SCREEN,
      page: () => const LastPeriodSelectionScreenView(),
      binding: LastPeriodSelectionScreenBinding(),
      transition: Transition.noTransition
    ),
    GetPage(
      name: _Paths.CALENDER_SCREEN,
      page: () => const CalenderScreenView(),
      binding: CalenderScreenBinding(),
      transition: Transition.noTransition
    ),
    GetPage(
      name: _Paths.ANALYTICS_PAGE,
      page: () => const AnalyticsPageView(),
      binding: AnalyticsPageBinding(),
      transition: Transition.noTransition
    ),
    GetPage(
      name: _Paths.INFO_PAGE,
      page: () => const InfoPageView(),
      binding: InfoPageBinding(),
      transition: Transition.noTransition
    ),
    GetPage(
      name: _Paths.LOG_PERIOD_CALENDER,
      page: () => const LogPeriodCalenderView(),
      binding: LogPeriodCalenderBinding(),
      transition: Transition.noTransition
    ),
    GetPage(
      name: _Paths.SET_PERIOD_DATE_PAGE,
      page: () => const SetPeriodDatePageView(),
      binding: SetPeriodDatePageBinding(),
      transition: Transition.noTransition
    ),
    GetPage(
      name: _Paths.SET_PERIOD_CYCLE_PAGE,
      page: () => SetPeriodCyclePageView(),
      binding: SetPeriodCyclePageBinding(),
      transition: Transition.noTransition
    ),
    GetPage(
      name: _Paths.SET_WEEK_FIRST_DAY_PAGE,
      page: () => const SetWeekFirstDayPageView(),
      binding: SetWeekFirstDayPageBinding(),
      transition: Transition.noTransition
    ),
    GetPage(
      name: _Paths.ABOUT_US_PAGE,
      page: () => const AboutUsPageView(),
      binding: AboutUsPageBinding(),
      transition: Transition.noTransition
    ),
    GetPage(
      name: _Paths.PRIVACY_POLICY_PAGE,
      page: () => const PrivacyPolicyPageView(),
      binding: PrivacyPolicyPageBinding(),
      transition: Transition.noTransition
    ),
    GetPage(
      name: _Paths.SETTING_TERMSPAGE_PAGE,
      page: () => const SettingTermspagePageView(),
      binding: SettingTermspagePageBinding(),
      transition: Transition.noTransition
    ),
    GetPage(
      name: _Paths.PIN_CODE_PAGE,
      page: () => PinCodePageView(),
      binding: PinCodePageBinding(),
      transition: Transition.noTransition
    ),
    GetPage(
      name: _Paths.SET_PIN_CHANGE_PIN_PAGE,
      page: () => const SetPinChangePinPageView(),
      binding: SetPinChangePinPageBinding(),
      transition: Transition.noTransition
    ),
    GetPage(
      name: _Paths.LOG_SYMPTIOMS_PAGE,
      page: () => LogSymptiomsPageView(),
      binding: LogSymptiomsPageBinding(),
      transition: Transition.noTransition
    ),
    GetPage(
      name: _Paths.DISCLAIMER_PAGE,
      page: () => const DisclaimerPageView(),
      binding: DisclaimerPageBinding(),
      transition: Transition.noTransition
    ),
    GetPage(
      name: _Paths.LOGIN_PIN_CODE_PAGE,
      page: () => LoginPinCodePageView(),
      binding: LoginPinCodePageBinding(),
      transition: Transition.noTransition
    ),
    GetPage(
      name: _Paths.CHANGE_PIN_CODE_PAGE,
      page: () => const ChangePinCodePageView(),
      binding: ChangePinCodePageBinding(),
      transition: Transition.noTransition
    ),
    GetPage(
      name: _Paths.CONFIRM_PIN_CODE_PAGE,
      page: () => const ConfirmPinCodePageView(),
      binding: ConfirmPinCodePageBinding(),
      transition: Transition.noTransition
    ),
    GetPage(
      name: _Paths.CHANGE_STEP_ONE_PIN_CODE_PAGE,
      page: () => const ChangeStepOnePinCodePageView(),
      binding: ChangeStepOnePinCodePageBinding(),
      transition: Transition.noTransition
    ),
    GetPage(
      name: _Paths.CHANGE_STEP_TWO_PIN_CODE_PAGE,
      page: () => const ChangeStepTwoPinCodePageView(),
      binding: ChangeStepTwoPinCodePageBinding(),
      transition: Transition.noTransition
    ),
  ];
}
