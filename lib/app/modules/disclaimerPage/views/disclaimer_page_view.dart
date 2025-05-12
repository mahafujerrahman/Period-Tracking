import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/disclaimer_page_controller.dart';

class DisclaimerPageView extends GetView<DisclaimerPageController> {
  const DisclaimerPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Info',
          style: TextStyle(
            color: Color(0xFF252525),
            fontSize: 16.sp,
            fontFamily: GoogleFonts.poppins().fontFamily,
            fontWeight: FontWeight.w400,
            height: 1.50.h,
          ),
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              width: 343.w,
              child: Text(
                'Disclaimer',
                style: TextStyle(
                  color: Color(0xFF252525),
                  fontSize: 16.sp,
                  fontFamily: GoogleFonts.poppins().fontFamily,
                  fontWeight: FontWeight.w500,
                  height: 1.50.h,
                ),
              ),
            ),
            SizedBox(
              width: 343.w,
              child: Text(
                'This app is not intended for use as birth control or for detailed reproductive planning. Pregnancy is possible at any point in your cycle. The data provided is for personal tracking only and may not be completely accurate due to data limitations and individual cycle variations. It offers only basic information regarding menstrual timing and fertility windows. Always consult your healthcare provider about birth control and alternative options.',
                style: TextStyle(
                  color: Color(0xFF252525),
                  fontSize: 16.sp,
                  fontFamily: GoogleFonts.poppins().fontFamily,
                  fontWeight: FontWeight.w400,
                  height: 1.75.h,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
