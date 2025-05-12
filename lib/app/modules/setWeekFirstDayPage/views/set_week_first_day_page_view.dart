import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:period_tracking/common/widgets/select_wheel.dart';
import 'package:period_tracking/common/wrapper/pin_code_wrapper.dart';

import '../../../../common/helpers/log_helper.dart';
import '../controllers/set_week_first_day_page_controller.dart';

class SetWeekFirstDayPageView extends StatefulWidget {
  const SetWeekFirstDayPageView({Key? key}) : super(key: key);

  @override
  State<SetWeekFirstDayPageView> createState() =>
      _SetWeekFirstDayPageViewState();
}

class _SetWeekFirstDayPageViewState extends State<SetWeekFirstDayPageView> {
  List<String> items = ["Mon", "Sat", "Sun"];
  final SetWeekFirstDayPageController _controller = Get.put(
    SetWeekFirstDayPageController(),
  );
@override
  void initState() {
    super.initState();
    _controller.dayName.value = items[0];
  }
  @override
  Widget build(BuildContext context) {
    return PinCodeWrapper(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Text(
            'Day Change',
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
                SelectWheelPicker(
                  items: items,
                  onSelectedItemChanged: (int) {
                    LoggerHelper.info(items[int]);
                    _controller.dayName.value = items[int];
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
        'Set the first day of the week',
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

  Widget _buildNextButton(BuildContext context) {
    return InkWell(
      onTap: () {
        _controller.setFirstDay();
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
