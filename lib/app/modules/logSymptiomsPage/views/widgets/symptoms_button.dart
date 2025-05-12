import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class SymptomsButton extends StatefulWidget {
  final String label;
  final String icon;
  final BuildContext context;
  final String category;
  final bool isSelected;
  final VoidCallback? onTap;

  const SymptomsButton(
      this.label,
      this.icon,
      this.context,
      this.category, {
        this.isSelected = false,
        this.onTap,
        Key? key,
      }) : super(key: key);

  @override
  State<SymptomsButton> createState() => _SymptomsButtonState();
}

class _SymptomsButtonState extends State<SymptomsButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Column(
        children: [
          Container(
            width: 73.w,
            height: 60.h,
            padding: const EdgeInsets.all(16),
            decoration: ShapeDecoration(
              gradient: widget.isSelected
                  ? const LinearGradient(
                begin: Alignment(0.00, -1.00),
                end: Alignment(0, 1),
                colors: [Color(0xFF50D4FB), Color(0xFF3AA5E3)],
              )
                  : null,
              color: widget.isSelected ? null : const Color(0xFFFEFEFE),
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 0.50.w, color: const Color(0xFFE1E1E1)),
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 24.w,
                  height: 24.h,
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(),
                  child: SvgPicture.asset(widget.icon),
                ),
              ],
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            widget.label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: const Color(0xFF252525),
              fontSize: 12.sp,
              fontFamily: GoogleFonts.poppins().fontFamily,
              fontWeight: FontWeight.w400,
              height: 1.50.h,
            ),
          ),
        ],
      ),
    );
  }
}