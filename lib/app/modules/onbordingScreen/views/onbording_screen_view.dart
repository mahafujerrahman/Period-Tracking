import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:period_tracking/app/routes/app_pages.dart';

import '../../../../common/quikies/app_images.dart';
import '../controllers/onbording_screen_controller.dart';

class OnbordingScreenView extends GetView<OnbordingScreenController> {
  const OnbordingScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:  Padding(
        padding: const EdgeInsets.all(16.0),
        child: InkWell(
          onTap: (){
            Get.toNamed(Routes.TERMS_CONDITION_SCREEN);
          },
          child: Container(
            width: 343.w,
            height: 48.h,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            decoration: ShapeDecoration(
              gradient: LinearGradient(
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
                'Continue',
                style: TextStyle(
                  color: Color(0xFFF6F6F6),
                  fontSize: 16.sp,
                  fontFamily: GoogleFonts.poppins().fontFamily,
                  fontWeight: FontWeight.w400,
                  height: 1.50.h,
                ),
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20.h),
            SizedBox(
              width: 329.w,
              child: Text(
                'Welcome to Nelya period tracking app',
                style: TextStyle(
                  color: Color(0xFF252525),
                  fontSize: 24.sp,
                  fontFamily: GoogleFonts.poppins().fontFamily,
                  fontWeight: FontWeight.w500,
                  height: 1.33.h,
                ),
              ),
            ),
            SizedBox(height: 174.h),
            Center(
              child: Image.asset(AppImage.appLogo, height: 214.h, width: 214.w),
            ),

          ],
        ),
      ),
    );
  }
}
