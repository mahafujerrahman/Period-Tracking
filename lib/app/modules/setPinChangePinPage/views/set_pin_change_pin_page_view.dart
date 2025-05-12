import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:period_tracking/app/routes/app_pages.dart';
import 'package:period_tracking/common/helpers/db_helper.dart';
import 'package:period_tracking/common/helpers/log_helper.dart';
import 'package:period_tracking/common/wrapper/pin_code_wrapper.dart';

class SetPinChangePinPageView extends StatefulWidget {
  const SetPinChangePinPageView({super.key});

  @override
  State<SetPinChangePinPageView> createState() =>
      _SetPinChangePinPageViewState();
}

class _SetPinChangePinPageViewState extends State<SetPinChangePinPageView> {
  final dbHelper = DatabaseHelper(dbName: 'period_database.db');
  final RxBool alreadyHavePin = false.obs; // Reactive variable

  Future<bool> checkUserPinTable() async {
    try {
      final db = await dbHelper.database;
      final result = await db.rawQuery(
        "SELECT * FROM user_pin WHERE pinCode IS NOT NULL",
      );
      return result.isNotEmpty;
    } catch (e) {
      LoggerHelper.info("Error checking PIN: $e");
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      alreadyHavePin.value = await checkUserPinTable();
    });
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
          centerTitle: true,
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                itemCount: 1,
                itemBuilder: (context, index) {
                  return Obx(() {
                    final menuItemTitle = alreadyHavePin.value ? "Change Pin Code" : "Set Pin Code";
                    final menuItemRoute = alreadyHavePin.value ? Routes.CHANGE_PIN_CODE_PAGE : Routes.PIN_CODE_PAGE;

                    return ListTile(
                      contentPadding: EdgeInsets.symmetric(vertical: 4.h),
                      title: Text(
                        menuItemTitle,
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
                        Get.toNamed(menuItemRoute);
                      },
                    );
                  });
                },
                separatorBuilder: (context, index) => Divider(height: 0.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}