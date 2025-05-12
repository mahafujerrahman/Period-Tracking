import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:period_tracking/app/routes/app_pages.dart';
import 'package:period_tracking/common/helpers/db_helper.dart';
import 'package:period_tracking/common/quikies/app_images.dart';
import 'package:period_tracking/common/quikies/dialogues.dart';
import 'package:period_tracking/common/wrapper/pin_code_wrapper.dart';

import '../../home/controllers/home_controller.dart';

class InfoPageView extends StatefulWidget {
  const InfoPageView({super.key});

  @override
  State<InfoPageView> createState() => _InfoPageViewState();
}

class _InfoPageViewState extends State<InfoPageView> {
  final HomeController _controller = Get.find();
  DatabaseHelper dbHelper = DatabaseHelper(dbName: 'period_database.db');

  final List<Map<String, dynamic>> menuItems = [
    {"icon": AppImage.greenWaterDrop, "title": "Period Length"},
    {"icon": AppImage.greenTimeIcon, "title": "Cycle Length"},
    {"icon": AppImage.greenLockIcon, "title": "Pin Code"},
    {
      "icon": AppImage.greenCalenderIcon,
      "title": "Set the first day of the week",
    },
    {"icon": AppImage.greenMessageIcon, "title": "Terms and Conditions"},
    {"icon": AppImage.greenQuestionIcon, "title": "About Us"},
    {"icon": AppImage.greenPrivacyPolicyIcon, "title": "Privacy Policy"},
    {"icon": AppImage.greenDeleteIcon, "title": "Delete my Data"},
  ];

  @override
  void dispose() {
    super.dispose();
    _controller.fetchUserInfo(dbHelper);
    _controller.fetchUserLogSymptoms(dbHelper);
  }

  @override
  Widget build(BuildContext context) {
    return PinCodeWrapper(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Info',
            style: TextStyle(
              color: Color(0xFF252525),
              fontSize: 16,
              fontFamily: GoogleFonts.poppins().fontFamily,
              fontWeight: FontWeight.w400,
              height: 1.50,
            ),
          ),
          // centerTitle: true,
          // leading: IconButton(
          //   icon: Icon(Icons.arrow_back),
          //   onPressed: () {
          //     Get.back();
          //   },
          // ),
        ),
        body: Column(
          children: [
            // Menu Items List
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                itemCount: menuItems.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    contentPadding: EdgeInsets.symmetric(vertical: 4.h),
                    leading: SvgPicture.asset(
                      menuItems[index]["icon"],
                      //  color: Colors.pinkAccent,
                    ),
                    title: Text(
                      menuItems[index]["title"],
                      style: GoogleFonts.poppins(
                        color: Color(0xFF252525),
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        height: 1.50.h,
                      ),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 16.sp,
                      color: Color(0xFF3AA5E3),
                    ),
                    onTap: () {
                      switch (index) {
                        case 0:
                          Get.toNamed(Routes.SET_PERIOD_DATE_PAGE);
                          break;
                        case 1:
                          Get.toNamed(Routes.SET_PERIOD_CYCLE_PAGE);
                          break;
                        case 2:
                          Get.toNamed(Routes.SET_PIN_CHANGE_PIN_PAGE);
                          break;
                        case 3:
                          Get.toNamed(Routes.SET_WEEK_FIRST_DAY_PAGE);
                          break;
                        case 4:
                          Get.toNamed(Routes.SETTING_TERMSPAGE_PAGE);
                          break;
                        case 5:
                          Get.toNamed(Routes.ABOUT_US_PAGE);
                          break;
                        case 6:
                          Get.toNamed(Routes.PRIVACY_POLICY_PAGE);
                          break;
                        case 7:
                          showSurePopUp(
                            context,
                            message:
                                'Are you sure you want to delete your Data ?',
                          );
                          break;
                        default:
                          break;
                      }

                      print(index);
                    },
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Divider(height: 0.5);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
