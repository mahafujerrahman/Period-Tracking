import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SymptomsHeader extends StatefulWidget {
  final VoidCallback onSave;

  const SymptomsHeader({
    super.key,
    required this.onSave,
  });

  @override
  State<SymptomsHeader> createState() => _SymptomsHeaderState();
}

class _SymptomsHeaderState extends State<SymptomsHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 375.w,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  padding: EdgeInsets.all(4.r),
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
                    child: Icon(Icons.close, color: Colors.white, size: 16.sp),
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              Text(
                'Log Symptoms',
                style: TextStyle(
                  color: const Color(0xFF252525),
                  fontSize: 16.sp,
                  fontFamily: GoogleFonts.poppins().fontFamily,
                  fontWeight: FontWeight.w400,
                  height: 1.50.h,
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: widget.onSave,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 4.h),
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
        ],
      ),
    );
  }
}