import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class BuildCategory extends StatefulWidget {
  String title;
   BuildCategory(this.title,{super.key,});

  @override
  State<BuildCategory> createState() => _BuildCategoryState();
}

class _BuildCategoryState extends State<BuildCategory> {
  @override
  Widget build(BuildContext context) {
    return   Text(
      widget.title,
      style: GoogleFonts.poppins(
        color: Color(0xFF252525),
        fontSize: 14.w,
        fontWeight: FontWeight.w500,
        height: 1.43.h,
      ),
    );
  }
}
