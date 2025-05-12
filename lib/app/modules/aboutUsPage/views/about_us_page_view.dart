import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:period_tracking/common/wrapper/pin_code_wrapper.dart';

import '../controllers/about_us_page_controller.dart';

class AboutUsPageView extends GetView<AboutUsPageController> {
  const AboutUsPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return PinCodeWrapper(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'About Us',
            style: TextStyle(
              color: Color(0xFF252525),
              fontSize: 16.sp,
              fontFamily: GoogleFonts.poppins().fontFamily,
              fontWeight: FontWeight.w400,
              height: 1.50,
            ),
          ),
          centerTitle: false,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  width: 343,
                  child: Text(
                    'About Us',
                    style: TextStyle(
                      color: Color(0xFF252525),
                      fontSize: 16,
                      fontFamily: GoogleFonts.poppins().fontFamily,
                      fontWeight: FontWeight.w600,
                      height: 1.50,
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
                SizedBox(
                  width: 343,
                  child: Text(
                    "At Nelya, we are a small, dedicated team based in Finland, passionate about advocating for women's rights to their own bodies and the privacy of their health data. Our mission is to empower women by providing safe and private solutions for tracking their menstrual cycles.\n\n We firmly believe that every woman deserves to have full control over her personal health information. That\'s why we are committed to creating an app that not only helps you track your periods but also ensures that your data remains secure and private.\n\nJoin us on our journey to promote women's health and privacy. We track cycles, not you.\n\nThe Nelya Team\ninfo@nelya.app",
                    style: TextStyle(
                      color: Color(0xFF252525),
                      fontSize: 16,
                      fontFamily: GoogleFonts.poppins().fontFamily,
                      fontWeight: FontWeight.w400,
                      height: 1.75,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
