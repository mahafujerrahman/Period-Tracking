import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter/services.dart';
import 'package:period_tracking/common/wrapper/pin_code_wrapper.dart';

import '../../termsConditionScreen/views/terms_page.dart';

class SettingTermspagePageView extends StatelessWidget {
  const SettingTermspagePageView({super.key});

  @override
  Widget build(BuildContext context) {
    return PinCodeWrapper(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Terms and Conditions',
            style: TextStyle(
              color: Color(0xFF252525),
              fontSize: 16.sp,
              fontFamily: GoogleFonts.poppins().fontFamily,
              fontWeight: FontWeight.w400,
              height: 1.50.h,
            ),
          ),
        ),

        body: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TermsPage()
            ],
          ),
        ),
      ),
    );
  }
}
