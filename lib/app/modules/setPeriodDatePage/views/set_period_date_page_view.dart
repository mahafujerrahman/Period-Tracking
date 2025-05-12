import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:period_tracking/common/helpers/log_helper.dart';
import 'package:period_tracking/common/widgets/select_wheel.dart';
import '../../../../common/wrapper/pin_code_wrapper.dart';
import '../controllers/set_period_date_page_controller.dart';

class SetPeriodDatePageView extends StatefulWidget {
  const SetPeriodDatePageView({super.key});

  @override
  State<SetPeriodDatePageView> createState() => _SetPeriodDatePageViewState();
}

class _SetPeriodDatePageViewState extends State<SetPeriodDatePageView> {
  SetPeriodDatePageController controller=Get.put(SetPeriodDatePageController());

 @override
  void initState() {
    super.initState();
    controller.periodLength.value = controller.items[0];

  }


  @override
  Widget build(BuildContext context) {
    return PinCodeWrapper(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            'Period Length',
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
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
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
                  items: controller.items,
                  onSelectedItemChanged: (int) {
                    controller.periodLength.value = controller.items[int];
                    LoggerHelper.info(controller.items[int]);
                  },
                  selectedColor: Colors.black,
                ),

                Spacer(),
                _buildNextButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNextButton(BuildContext context) {
    return InkWell(
      onTap: () {
        controller.updatePeriodLength();
        Get.back();
      },
      child: Container(
        width: double.infinity,
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
            'Save',
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
