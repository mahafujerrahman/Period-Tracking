import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:period_tracking/app/modules/home/views/widgets/overview_cart.dart';
import 'package:period_tracking/app/modules/home/views/widgets/symptoms_card.dart';
import 'package:period_tracking/app/routes/app_pages.dart';
import 'package:period_tracking/common/helpers/db_helper.dart';
import 'package:period_tracking/common/quikies/app_images.dart';
import 'package:period_tracking/common/wrapper/pin_code_wrapper.dart';

import '../../../../common/appBars/customBottomNavBar.dart';
import '../controllers/home_controller.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final HomeController _controller = Get.put(HomeController());
  DatabaseHelper dbHelper = DatabaseHelper(dbName: 'period_database.db');

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _controller.fetchUserInfo(dbHelper);
      await _controller.fetchUserLogSymptoms(dbHelper);
    });
  }

  @override
  Widget build(BuildContext context) {
    return PinCodeWrapper(
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: GestureDetector(
          onTap: () {
            Get.toNamed(Routes.LOG_SYMPTIOMS_PAGE);
          },
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.lightBlue,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.add, color: Colors.white, size: 30),
          ),
        ),
        bottomNavigationBar: CustomBottomNavBar(initialIndex: 0),
        backgroundColor: Color(0xFFF8F8F8),
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: 165,
                  children: [
                    Text(
                      'Welcome',
                      style: TextStyle(
                        color: Color(0xFF50D4FB),
                        fontSize: 16.sp,
                        fontFamily: GoogleFonts.poppins().fontFamily,
                        fontWeight: FontWeight.w500,
                        height: 1.50.h,
                      ),
                    ),
                    SizedBox(
                      width: 40.w,
                      height: 40.h,
                      child: Image.asset(AppImage.appLogo),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8.h),

              Obx(() {
                if (_controller.cycleDay.value <= 0) {
                  return SizedBox();
                }

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    children: [
                      // First card - Period prediction
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 12,
                          ),
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            spacing: 8,
                            children: [
                              SizedBox(
                                width: 155.w,
                                child: Text(
                                  'Predicted Next Period',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color(0xFF252525),
                                    fontSize: 12.sp,
                                    fontFamily:
                                        GoogleFonts.poppins().fontFamily,
                                    fontWeight: FontWeight.w500,
                                    height: 1.50.h,
                                  ),
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  spacing: 8,
                                  children: [
                                    Container(
                                      width: 20.w,
                                      height: 20.h,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: 17.w,
                                            height: 20.h,
                                            child: SvgPicture.asset(
                                              AppImage.calenderIcon,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    Text(
                                      _controller.predictedNextPeriodDate.value,
                                      style: TextStyle(
                                        color: Color(0xFF252525),
                                        fontSize: 18.sp,
                                        fontFamily:
                                            GoogleFonts.poppins().fontFamily,
                                        fontWeight: FontWeight.w600,
                                        height: 1.56.h,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 155.w,
                                child: Text(
                                  '${_controller.remainingDay}',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color(0xFF9E9E9E),
                                    fontSize: 12.sp,
                                    fontFamily:
                                        GoogleFonts.poppins().fontFamily,
                                    fontWeight: FontWeight.w400,
                                    height: 1.50.h,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 12,
                          ),
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            spacing: 8,
                            children: [
                              SizedBox(
                                width: 155.w,
                                child: Text(
                                  'Predicted Next Ovulation',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color(0xFF252525),
                                    fontSize: 12.sp,
                                    fontFamily:
                                        GoogleFonts.poppins().fontFamily,
                                    fontWeight: FontWeight.w500,
                                    height: 1.50.h,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: double.infinity,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  spacing: 8,
                                  children: [
                                    Container(
                                      width: 20.w,
                                      height: 20.h,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: 17.w,
                                            height: 20.h,
                                            child: SvgPicture.asset(
                                              AppImage.spermIcon,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Obx(() {
                                      // if (int.parse(_controller.nextOvulationDay.value) <= 0) {
                                      //   return SizedBox();
                                      // }
                                      return Text(
                                        _controller.nextOvulationDay.value,
                                        style: TextStyle(
                                          color: Color(0xFF252525),
                                          fontSize: 18.sp,
                                          fontFamily:
                                              GoogleFonts.poppins().fontFamily,
                                          fontWeight: FontWeight.w600,
                                          height: 1.56.h,
                                        ),
                                      );
                                    }),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 155.w,
                                child: Obx(() {
                                  // if (int.parse(_controller.nextOvulationDay.value) <= 0) {
                                  //   return SizedBox();
                                  // }
                                  return Text(
                                    _controller.nextOvulationIN.value,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Color(0xFF9E9E9E),
                                      fontSize: 12.sp,
                                      fontFamily:
                                          GoogleFonts.poppins().fontFamily,
                                      fontWeight: FontWeight.w400,
                                      height: 1.50.h,
                                    ),
                                  );
                                }),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),

              SizedBox(height: 8.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      Get.toNamed(Routes.LOG_SYMPTIOMS_PAGE);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 4,
                      ),
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
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8.0,
                          horizontal: 12,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          spacing: 8,
                          children: [
                            Icon(
                              Icons.add_circle_outline,
                              color: Colors.white,
                              size: 20.sp,
                            ),
                            Text(
                              'Log Period',
                              style: TextStyle(
                                color: Color(0xFFF6F6F6),
                                fontSize: 16.sp,
                                fontFamily: GoogleFonts.poppins().fontFamily,
                                fontWeight: FontWeight.w400,
                                height: 1.50.h,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  SizedBox(width: 8.w),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(Routes.DISCLAIMER_PAGE);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 4,
                      ),
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(width: 1, color: Color(0xFF50D4FB)),
                          borderRadius: BorderRadius.circular(99.r),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 12,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          spacing: 8,
                          children: [
                            Container(
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SvgPicture.asset(
                                    AppImage.questionIcon,
                                    height: 12.h,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              Obx(() {
                if (_controller.cycleDay.value <= 0) {
                  return SizedBox();
                }

                return Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12.0,
                    horizontal: 16,
                  ),
                  child: OverviewCard(
                    cycleCount: _controller.cycleDay.value.toString(),
                    cycleTotalDays: int.parse(_controller.menstrualCycle.value),
                  ),
                );
              }),

              Obx(() {
                if (_controller.uniqueSymptomsList.isEmpty) {
                  return SizedBox();
                }
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 4.0,
                    horizontal: 16,
                  ),
                  child: SymptomsCard(
                    symptomsList: _controller.uniqueSymptomsList,
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
