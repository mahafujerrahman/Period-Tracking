import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:period_tracking/app/modules/lastPeriodSelectionScreen/controllers/last_period_selection_screen_controller.dart';
import '../../../../common/helpers/log_helper.dart';
import '../../../../common/widgets/custom_progress_bar.dart';
import '../../../../common/widgets/select_wheel.dart';
import '../../../routes/app_pages.dart';
import '../controllers/period_length_selection_screen_controller.dart';

class PeriodLengthSelectionScreenView extends StatefulWidget {
  const PeriodLengthSelectionScreenView({super.key});

  @override
  State<PeriodLengthSelectionScreenView> createState() =>
      _PeriodLengthSelectionScreenViewState();
}

class _PeriodLengthSelectionScreenViewState
    extends State<PeriodLengthSelectionScreenView> {
  final LastPeriodSelectionScreenController
  _lastPeriodSelectionScreenController = Get.put(
    LastPeriodSelectionScreenController(),
  );
  final PeriodLengthSelectionScreenController _controller = Get.put(
    PeriodLengthSelectionScreenController(),
  );

  @override
  void initState() {
    super.initState();

    _lastPeriodSelectionScreenController.periodLastFor.value =
        _controller.items[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildProgressIndicator(context),
              SizedBox(height: 40.h),
              SizedBox(
                width: 343.w,
                child: Text(
                  'How long your period usually last?',
                  style: TextStyle(
                    color: Color(0xFF252525),
                    fontSize: 24.sp,
                    fontFamily: GoogleFonts.poppins().fontFamily,
                    fontWeight: FontWeight.w500,
                    height: 1.33.h,
                  ),
                ),
              ),
              SizedBox(height: 12.h),
              SizedBox(
                width: 343.w,
                child: Text(
                  'Tips: An average period length is 5 - 10 days. ',
                  style: TextStyle(
                    color: Color(0xFF252525),
                    fontSize: 14.sp,
                    fontFamily: GoogleFonts.poppins().fontFamily,
                    fontWeight: FontWeight.w400,
                    height: 1.43.h,
                  ),
                ),
              ),
              SizedBox(height: 8.h),
              SelectWheelPicker(
                items: _controller.items,
                onSelectedItemChanged: (int) {
                  _lastPeriodSelectionScreenController.periodLastFor.value =
                      _controller.items[int];
                  LoggerHelper.info(_controller.items[int]);
                },
                selectedColor: Colors.black,
              ),

              SizedBox(height: 40.h),
              const Spacer(),
              _buildNavigationButtons(context),
            ],
          ),
        ),
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
        LoggerHelper.warn(
          _lastPeriodSelectionScreenController.periodLastFor.value,
        );
        Get.toNamed(Routes.USUAL_PERIOD_SELECTION_SCREEN);
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

  Widget _buildProgressIndicator(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: SizedBox(
            width: 100.w,
            child: CustomProgressBar(value: 0.4, height: 8.h),
          ),
        ),
        SizedBox(width: 20.w),
        GestureDetector(
          onTap: () {
            Get.toNamed(Routes.USUAL_PERIOD_SELECTION_SCREEN);
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
}
