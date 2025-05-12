import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:period_tracking/app/modules/analyticsPage/controllers/analytics_page_controller.dart';
import 'package:period_tracking/app/modules/analyticsPage/views/widgets/mestural_flowchart.dart';
import 'package:period_tracking/app/modules/analyticsPage/views/widgets/mood_enargy_chart.dart';
import 'package:period_tracking/app/routes/app_pages.dart';
import 'package:period_tracking/common/helpers/db_helper.dart';
import 'package:period_tracking/common/wrapper/pin_code_wrapper.dart';
import '../../../../common/appBars/customBottomNavBar.dart';

class AnalyticsPageView extends StatefulWidget {
  const AnalyticsPageView({super.key});

  @override
  State<AnalyticsPageView> createState() => _AnalyticsPageViewState();
}

class _AnalyticsPageViewState extends State<AnalyticsPageView> {
  final AnalyticsPageController _controller = Get.put(
    AnalyticsPageController(),
  );

  @override
  void initState() {
    super.initState();
    DatabaseHelper dbHelper = DatabaseHelper(dbName: 'period_database.db');

    _controller.fetchAllDataFromTable(dbHelper);
  }

  @override
  Widget build(BuildContext context) {
    return PinCodeWrapper(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Analytics',
            style: TextStyle(
              color: Color(0xFF252525),
              fontSize: 16.sp,
              fontFamily: GoogleFonts.poppins().fontFamily,
              fontWeight: FontWeight.w400,
              height: 1.50.h,
            ),
          ),
        ),
        backgroundColor: Colors.white,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: GestureDetector(
          onTap: () {
            Get.toNamed(Routes.LOG_SYMPTIOMS_PAGE);
          },

          child: Container(
            width: 50.w,
            height: 50.h,
            decoration: BoxDecoration(
              color: Colors.lightBlue,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.add, color: Colors.white, size: 30.sp),
          ),
        ),
        bottomNavigationBar: CustomBottomNavBar(initialIndex: 2),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  MoodEnergyChart(),
                  SizedBox(height: 8.h),
                  MenstrualFlowChart(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
