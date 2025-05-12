import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:period_tracking/app/modules/termsConditionScreen/views/terms_page.dart';
import 'package:period_tracking/common/wrapper/pin_code_wrapper.dart';

import '../../../routes/app_pages.dart';

class TermsConditionScreenView extends StatefulWidget {
  const TermsConditionScreenView({super.key});

  @override
  State<TermsConditionScreenView> createState() =>
      _TermsConditionScreenViewState();
}

class _TermsConditionScreenViewState extends State<TermsConditionScreenView> {
  bool _isChecked = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [Expanded(child: TermsPage()), _buildBottomControls()],
        ),
      ),
    );
  }

  Widget _buildBottomControls() {
    return Column(
      children: [
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Checkbox(
                value: _isChecked,
                onChanged: (value) {
                  setState(() {
                    _isChecked = value ?? false;
                  });
                },
                checkColor: Color(0xFF50D4FB),
                focusColor: Color(0xFF50D4FB),
              ),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'I agree to the ',
                      style: TextStyle(
                        color: Color(0xFF252525),
                        fontSize: 14.sp,
                        fontFamily: GoogleFonts.poppins().fontFamily,
                        fontWeight: FontWeight.w400,
                        height: 1.43.h,
                      ),
                    ),
                    TextSpan(
                      text: 'terms & conditions',
                      style: TextStyle(
                        color: Color(0xFF252525),
                        fontSize: 14.sp,
                        fontFamily: GoogleFonts.poppins().fontFamily,
                        fontWeight: FontWeight.w400,
                        decoration: TextDecoration.underline,
                        height: 1.43.h,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8.h),
          child: SizedBox(
            width: 350.w,
            height: 50.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [_buildBackButton(), _buildNextButton()],
            ),
          ),
        ),
        SizedBox(height: 8.h),
      ],
    );
  }

  Widget _buildBackButton() {
    return Container(
      width: 87.w,
      height: 50.h,
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFF50D4FB)),
        borderRadius: BorderRadius.circular(99.r),
      ),
      child: IconButton(
        icon: Icon(Icons.arrow_back_ios, size: 20.sp),
        onPressed: () => Get.back(),
      ),
    );
  }

  Widget _buildNextButton() {
    return InkWell(
      onTap: () => Get.toNamed(Routes.PERIOD_CYCLE_SELECTION_SCREEN),
      child: Container(
        width: 244.w,
        height: 50.h,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF50D4FB), Color(0xFF3AA5E3)],
          ),
          borderRadius: BorderRadius.circular(99.r),
        ),
        child: Center(
          child: Text(
            'Next',
            style: TextStyle(
              color: Color(0xFFF6F6F6),
              fontSize: 16.sp,
              fontFamily: GoogleFonts.poppins().fontFamily,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}
