import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class SelectWheelPicker extends StatefulWidget {
  final List<String> items;
  final Function(int) onSelectedItemChanged;
  final double itemExtent;
  final double perspective;
  final double diameterRatio;
  final double height;
  final Color selectedColor;
  final Color unselectedColor;
  final TextStyle? textStyle;
  final int initialIndex;

  const SelectWheelPicker({
    Key? key,
    required this.items,
    required this.onSelectedItemChanged,
    this.itemExtent = 50,
    this.perspective = 0.005,
    this.diameterRatio = 1.2,
    this.height = 200,
    this.selectedColor = const Color(0xFFFF69B4),
    this.unselectedColor = Colors.grey,
    this.textStyle,
    this.initialIndex = 0,
  }) : super(key: key);

  @override
  _SelectWheelPickerState createState() => _SelectWheelPickerState();
}

class _SelectWheelPickerState extends State<SelectWheelPicker> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: ListWheelScrollView.useDelegate(
        itemExtent: widget.itemExtent,
        perspective: widget.perspective,
        diameterRatio: widget.diameterRatio,
        physics: const FixedExtentScrollPhysics(),
        onSelectedItemChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
          widget.onSelectedItemChanged(index);
        },
        childDelegate: ListWheelChildBuilderDelegate(
          childCount: widget.items.length,


            builder: (context, index) {
              final item = widget.items[index];
              final isSelected = index == _selectedIndex;
              final color = isSelected ? widget.selectedColor : widget.unselectedColor;

              TextStyle style = widget.textStyle ??
                  GoogleFonts.poppins(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w500,
                    color: color,
                  );

              return Container(
                width: 150.w,
                child: Column(
                  children: [
                    if (isSelected) Divider(height: 0.5.h, thickness: 1, color: Color(0xFF252525) ),
                    SizedBox(height: 6.h,),
                    Center(
                      child: Text(item, style: style.copyWith(color: color)),
                    ),
                    SizedBox(height: 6.h,),
                    if (isSelected) Divider(height: 0.5.h, thickness: 1, color: Color(0xFF252525)),
                  ],
                ),
              );
            }

        ),
      ),
    );
  }
}
