import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:period_tracking/app/modules/setPeriodCyclePage/controllers/set_period_cycle_page_controller.dart';
import 'package:period_tracking/common/helpers/log_helper.dart';
import 'package:period_tracking/common/widgets/select_wheel.dart';
import 'package:period_tracking/common/wrapper/pin_code_wrapper.dart';

class SetPeriodCyclePageView extends StatefulWidget {
  const SetPeriodCyclePageView({Key? key}) : super(key: key);

  @override
  State<SetPeriodCyclePageView> createState() => _SetPeriodCyclePageViewState();
}

class _SetPeriodCyclePageViewState extends State<SetPeriodCyclePageView> {
  String? selectedOption;
  List<String> items = [
    "20", "21", "22", "23", "24", "25", "26", "27", "28", "29",
    "30", "31", "32", "33", "34", "35", "36", "37", "38", "39",
    "40", "41", "42", "43", "44", "45"
  ];
  final SetPeriodCyclePageController _controller = Get.put(
    SetPeriodCyclePageController(),
  );
  @override
  void initState() {
    super.initState();

    _controller.menstrualCycle.value = items[0];
  }

  @override
  Widget build(BuildContext context) {
    return PinCodeWrapper(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Text(
            'Cycle Length',
            style: TextStyle(
              color: Color(0xFF252525),
              fontSize: 16,
              fontFamily: GoogleFonts.poppins().fontFamily,
              fontWeight: FontWeight.w400,
              height: 1.50,
            ),
          ),
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 40.h),
                _buildQuestionText(),
                SizedBox(height: 12.h),
                _buildTipText(),
                SizedBox(height: 8.h),
                SelectWheelPicker(
                  items: items,
                  onSelectedItemChanged: (int) {
                    _controller.menstrualCycle.value = items[int];

                    LoggerHelper.info(items[int]);
                  },
                  selectedColor: Colors.black,
                ),

                const Spacer(),
                _buildNextButton(context),
                SizedBox(height: 8.h),
              ],
            ),
          ),
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

  Widget _buildNextButton(BuildContext context) {
    return InkWell(
      onTap: () {
        _controller.updateMenstrualCycle();
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
