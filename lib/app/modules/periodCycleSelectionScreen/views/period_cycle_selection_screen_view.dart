import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:period_tracking/app/modules/lastPeriodSelectionScreen/controllers/last_period_selection_screen_controller.dart';
import 'package:period_tracking/common/helpers/log_helper.dart';
import 'package:period_tracking/common/widgets/custom_progress_bar.dart';
import 'package:period_tracking/common/wrapper/pin_code_wrapper.dart';
import '../../../../common/widgets/select_wheel.dart';
import '../../../routes/app_pages.dart';

class PeriodCycleSelectionScreenView extends StatefulWidget {
  const PeriodCycleSelectionScreenView({Key? key}) : super(key: key);

  @override
  State<PeriodCycleSelectionScreenView> createState() =>
      _PeriodCycleSelectionScreenViewState();
}

class _PeriodCycleSelectionScreenViewState
    extends State<PeriodCycleSelectionScreenView> {
  String? selectedOption;
  List<String> cycleOptions = ["I am not sure", "It varies"];
  List<String> items = [
    "20", "21", "22", "23", "24", "25", "26", "27", "28", "29",
    "30", "31", "32", "33", "34", "35", "36", "37", "38", "39",
    "40", "41", "42", "43", "44", "45"
  ];

  final LastPeriodSelectionScreenController
  _lastPeriodSelectionScreenController = Get.put(
    LastPeriodSelectionScreenController(),
  );
@override
  void initState() {
    super.initState();
    _lastPeriodSelectionScreenController
        .averangeMenstrualCycle
        .value = items[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: _buildProgressIndicator(context)),
              SizedBox(height: 40.h),
              _buildQuestionText(),
              SizedBox(height: 12.h),
              _buildTipText(),
              SizedBox(height: 8.h),
              SelectWheelPicker(
                items: items,
                onSelectedItemChanged: (int) {
                  LoggerHelper.info(items[int]);
                  _lastPeriodSelectionScreenController
                      .averangeMenstrualCycle
                      .value = items[int];
                },
                selectedColor: Colors.black,
              ),

              SizedBox(height: 40.h),
              // Selectable options
              ...cycleOptions.map((option) => _buildSelectableOption(option)),
              const Spacer(),
              _buildNavigationButtons(context),
              SizedBox(height: 8.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProgressIndicator(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 100.w,
          child: CustomProgressBar(value: 0.2, height: 8.h),
        ),
        SizedBox(width: 20.w),
        GestureDetector(
          onTap: () {
            Get.toNamed(Routes.PERIOD_LENGTH_SELECTION_SCREEN);
          },
          child: _buildSkipButton(),
        ),
      ],
    );
  }

  Widget _buildSkipButton() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: ShapeDecoration(
        gradient: const LinearGradient(
          begin: Alignment(0.00, -1.00),
          end: Alignment(0, 1),
          colors: [Color(0xFF50D4FB), Color(0xFF3AA5E3)],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
      child: Text(
        'Skip',
        style: TextStyle(
          color: const Color(0xFFF6F6F6),
          fontSize: 16.sp,
          fontFamily: GoogleFonts.poppins().fontFamily,
          fontWeight: FontWeight.w400,
          height: 1.50.h,
        ),
      ),
    );
  }

  Widget _buildQuestionText() {
    return SizedBox(
      width: 343.50,
      child: Text(
        'What is the average length of your menstrual cycle ?',
        style: TextStyle(
          color: Color(0xFF252525),
          fontSize: 24.sp,
          fontFamily: GoogleFonts.poppins().fontFamily,
          fontWeight: FontWeight.w500,
          height: 1.33.h,
        ),
      ),
    );
  }

  Widget _buildTipText() {
    return Text(
      'Tips: An average cycle lasts 24 - 38 days. ',
      style: TextStyle(
        color: Color(0xFF252525),
        fontSize: 14.sp,
        fontFamily: GoogleFonts.poppins().fontFamily,
        fontWeight: FontWeight.w400,
        height: 1.43.h,
      ),
    );
  }

  Widget _buildSelectableOption(String optionText) {
    bool isSelected = selectedOption == optionText;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedOption = optionText;
          _lastPeriodSelectionScreenController.averangeMenstrualCycle.value =
              optionText;
        });
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        margin: const EdgeInsets.only(bottom: 12),
        // Add spacing between items
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: isSelected ? const Color(0xFFDAF0F9) : Colors.white,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 1.w,
              color:
                  isSelected ? const Color(0xFF50D4FB) : Colors.grey.shade300,
            ),
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              optionText,
              style: TextStyle(
                color: Color(0xFF252525),
                fontSize: 14.sp,
                fontFamily: GoogleFonts.poppins().fontFamily,
                fontWeight: FontWeight.w400,
                height: 1.43.h,
              ),
            ),
            _buildSelectionIndicator(isSelected),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectionIndicator(bool isSelected) {
    return Container(
      width: 16.w,
      height: 16.h,
      decoration: ShapeDecoration(
        gradient:
            isSelected
                ? const LinearGradient(
                  begin: Alignment(0.00, -1.00),
                  end: Alignment(0, 1),
                  colors: [Color(0xFF50D4FB), Color(0xFF3AA5E3)],
                )
                : null,
        color: isSelected ? null : Colors.white,
        shape: RoundedRectangleBorder(
          side:
              !isSelected
                  ? BorderSide(color: Colors.grey.shade400)
                  : BorderSide.none,
          borderRadius: BorderRadius.circular(99.r),
        ),
      ),
      child: Center(
        child:
            isSelected
                ? const Icon(Icons.check, color: Colors.white, size: 12)
                : null,
      ),
    );
  }

  Widget _buildNavigationButtons(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 350.w,
        height: 50.h,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 12,
          children: [
            InkWell(
              onTap: () {
                Get.back();
              },
              child: _buildBackButton(),
            ),
            _buildNextButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildBackButton() {
    return Container(
      width: 87.w,
      height: 50.h,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1, color: Color(0xFF50D4FB)),
          borderRadius: BorderRadius.circular(99.r),
        ),
      ),
      child: Container(
        width: 20.w,
        height: 20.h,
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(),
        child: Icon(Icons.arrow_back_ios, size: 20.sp),
      ),
    );
  }

  Widget _buildNextButton(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(Routes.PERIOD_LENGTH_SELECTION_SCREEN);
        LoggerHelper.warn(
          _lastPeriodSelectionScreenController.averangeMenstrualCycle.value,
        );
      },
      child: Container(
        width: 220.w,
        height: 50.h,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: ShapeDecoration(
          gradient: const LinearGradient(
            begin: Alignment(0.00, -1.00),
            end: Alignment(0, 1),
            colors: [Color(0xFF50D4FB), Color(0xFF3AA5E3)],
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(99.r),
          ),
        ),
        child: Center(
          child: Text(
            'Next',
            style: TextStyle(
              color: const Color(0xFFF6F6F6),
              fontSize: 16.sp,
              fontFamily: GoogleFonts.poppins().fontFamily,
              fontWeight: FontWeight.w400,
              height: 1.50.h,
            ),
          ),
        ),
      ),
    );
  }
}
