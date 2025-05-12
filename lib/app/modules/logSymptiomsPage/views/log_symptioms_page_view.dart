import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:period_tracking/app/modules/logSymptiomsPage/controllers/log_symptioms_page_controller.dart';
import 'package:period_tracking/app/modules/logSymptiomsPage/views/widgets/category_builder.dart';
import 'package:period_tracking/app/modules/logSymptiomsPage/views/widgets/symptoms_button.dart';
import 'package:period_tracking/app/modules/logSymptiomsPage/views/widgets/symptoms_header.dart';
import 'package:period_tracking/app/routes/app_pages.dart';
import 'package:period_tracking/common/helpers/log_helper.dart';
import 'package:period_tracking/common/quikies/app_images.dart';
import 'package:period_tracking/common/wrapper/pin_code_wrapper.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class LogSymptiomsPageView extends StatefulWidget {
  const LogSymptiomsPageView({super.key});

  @override
  _LogSymptiomsPageViewState createState() => _LogSymptiomsPageViewState();
}

class _LogSymptiomsPageViewState extends State<LogSymptiomsPageView> {
  // State variables to track selected items
  DateTime? _selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _controller.selectedDate?.value =
            '${_selectedDate!.toLocal()}'.split(' ')[0];
        LoggerHelper.info(_selectedDate);
      });
    }
  }

  final LogSymptiomsPageController _controller = Get.put(
    LogSymptiomsPageController(),
  );

  String? commingDate;

  @override
  void initState() {
    super.initState();
    commingDate = Get.parameters['sentDate'];

    // Only proceed if we have a non-empty string
    if (commingDate?.isNotEmpty ?? false) {
      _controller.selectedDate?.value = commingDate!;
    }
    LoggerHelper.warn("============>> jadu jadu magic >>>>> $commingDate");
  }

  @override
  Widget build(BuildContext context) {
    return PinCodeWrapper(
      child: Scaffold(
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SymptomsHeader(
                    onSave: () {
                      _controller.saveLogSymptomps();
                    },
                  ),
                  SizedBox(height: 40.h),
                  Text(
                    'Date',
                    style: TextStyle(
                      color: Color(0xFF252525),
                      fontSize: 14.sp,
                      fontFamily: GoogleFonts.poppins().fontFamily,
                      fontWeight: FontWeight.w600,
                      height: 1.43.h,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  GestureDetector(
                    onTap: () {
                      _selectDate(context);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 24.w,
                        vertical: 4.h,
                      ),
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
                      child:
                          commingDate != null
                              ? Text(
                                commingDate!,
                                style: TextStyle(
                                  color: const Color(0xFFF6F6F6),
                                  fontSize: 16.sp,
                                  fontFamily: GoogleFonts.poppins().fontFamily,
                                  fontWeight: FontWeight.w400,
                                  height: 1.50.h,
                                ),
                              )
                              : Text(
                                _selectedDate == null
                                    ? 'Select Date'
                                    : '${_selectedDate!.toLocal()}'.split(
                                      ' ',
                                    )[0],
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

                  SizedBox(height: 16.h),
                  BuildCategory('Menstrual flow'),
                  SizedBox(height: 12.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SymptomsButton(
                          'Light',
                          AppImage.bloodOne,
                          context,
                          'menstrual_flow',
                          isSelected:
                              _controller.selectedMenstrualFlow?.value ==
                              'Light',
                          onTap: () {
                            _handleSelection('menstrual_flow', 'Light');
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SymptomsButton(
                          'Medium',
                          AppImage.bloodTwo,
                          context,
                          'menstrual_flow',
                          isSelected:
                              _controller.selectedMenstrualFlow?.value ==
                              'Medium',
                          onTap: () {
                            _handleSelection('menstrual_flow', 'Medium');
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SymptomsButton(
                          'Heavy',
                          AppImage.bloodThree,
                          context,
                          'menstrual_flow',
                          isSelected:
                              _controller.selectedMenstrualFlow?.value ==
                              'Heavy',
                          onTap: () {
                            _handleSelection('menstrual_flow', 'Heavy');
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24.h),
                  BuildCategory('Symptoms'),
                  SizedBox(height: 12.h),
                  Wrap(
                    spacing: 12.0,
                    runSpacing: 12.0,
                    children: [
                      SymptomsButton(
                        'Headache',
                        AppImage.headacheIcon,
                        context,
                        'symptoms',
                        isSelected: _controller.selectedSymptoms.contains(
                          'Headache',
                        ),
                        onTap: () {
                          _handleSelection('symptoms', 'Headache');
                        },
                      ),
                      SymptomsButton(
                        'Breast\nTenderness',
                        AppImage.breastIcon,
                        context,
                        'symptoms',
                        isSelected: _controller.selectedSymptoms.contains(
                          'Breast\nTenderness',
                        ),
                        onTap: () {
                          _handleSelection('symptoms', 'Breast\nTenderness');
                        },
                      ),
                      SymptomsButton(
                        'Backache',
                        AppImage.backache,
                        context,
                        'symptoms',
                        isSelected: _controller.selectedSymptoms.contains(
                          'Backache',
                        ),
                        onTap: () {
                          _handleSelection('symptoms', 'Backache');
                        },
                      ),
                      SymptomsButton(
                        'Cramps',
                        AppImage.crampsIcon,
                        context,
                        'symptoms',
                        isSelected: _controller.selectedSymptoms.contains(
                          'Cramps',
                        ),
                        onTap: () {
                          _handleSelection('symptoms', 'Cramps');
                        },
                      ),
                      SymptomsButton(
                        'Other\nSymptoms',
                        AppImage.otherIcon,
                        context,
                        'symptoms',
                        isSelected: _controller.selectedSymptoms.contains(
                          'Other\nSymptoms',
                        ),
                        onTap: () {
                          _handleSelection('symptoms', 'Other\nSymptoms');
                        },
                      ),
                      SymptomsButton(
                        'Other\nDischarge',
                        AppImage.oneIcon,
                        context,
                        'symptoms',
                        isSelected: _controller.selectedSymptoms.contains(
                          'Other\nDischarge',
                        ),
                        onTap: () {
                          _handleSelection('symptoms', 'Other\nDischarge');
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 24.h),
                  BuildCategory('Sex'),
                  SizedBox(height: 12.h),
                  SymptomsButton(
                    'Sex',
                    AppImage.sexIcon,
                    context,
                    'sex',
                    isSelected: _controller.selectedSex?.value == 'Sex',
                    onTap: () {
                      _handleSelection('sex', 'Sex');
                    },
                  ),
                  SizedBox(height: 8.h),
                  // Mood Section
                  Text(
                    'Mood',
                    style: TextStyle(
                      color: Color(0xFF252525),
                      fontSize: 14.sp,
                      fontFamily: GoogleFonts.poppins().fontFamily,
                      fontWeight: FontWeight.w500,
                      height: 1.43.h,
                    ),
                  ),
                  SfSlider(
                    min: 0,
                    max: 10,
                    value: _controller.energyValue.value,
                    onChanged: (dynamic value) {
                      setState(() {
                        _controller.energyValue.value = value;
                      });
                    },
                    activeColor: Colors.blue,
                    inactiveColor: Colors.grey[300],
                    tooltipTextFormatterCallback: (
                      dynamic value,
                      String formattedText,
                    ) {
                      return '${value.toStringAsFixed(0)}';
                    },
                    enableTooltip: true,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Bad',
                          style: TextStyle(
                            color: Color(0xFF9E9E9E),
                            fontSize: 10,
                            fontFamily: GoogleFonts.poppins().fontFamily,
                            fontWeight: FontWeight.w500,
                            height: 2,
                          ),
                        ),
                        Text(
                          'Great',
                          style: TextStyle(
                            color: Color(0xFF9E9E9E),
                            fontSize: 10,
                            fontFamily: GoogleFonts.poppins().fontFamily,
                            fontWeight: FontWeight.w500,
                            height: 2,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h),

                  // Mood Section
                  Text(
                    'Energy Level',
                    style: TextStyle(
                      color: Color(0xFF252525),
                      fontSize: 14.sp,
                      fontFamily: GoogleFonts.poppins().fontFamily,
                      fontWeight: FontWeight.w500,
                      height: 1.43.h,
                    ),
                  ),
                  SfSlider(
                    min: 0,
                    max: 10,
                    value: _controller.moodValue.value,
                    onChanged: (dynamic value) {
                      setState(() {
                        _controller.moodValue.value = value;
                      });
                    },
                    activeColor: Colors.blue,
                    inactiveColor: Colors.grey[300],
                    tooltipTextFormatterCallback: (
                      dynamic value,
                      String formattedText,
                    ) {
                      return '${value.toStringAsFixed(0)}';
                    },
                    enableTooltip: true,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Low',
                          style: TextStyle(
                            color: Color(0xFF9E9E9E),
                            fontSize: 10,
                            fontFamily: GoogleFonts.poppins().fontFamily,
                            fontWeight: FontWeight.w500,
                            height: 2,
                          ),
                        ),
                        Text(
                          'High',
                          style: TextStyle(
                            color: Color(0xFF9E9E9E),
                            fontSize: 10,
                            fontFamily: GoogleFonts.poppins().fontFamily,
                            fontWeight: FontWeight.w500,
                            height: 2,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8.h),

                  // Note Section
                  Text(
                    'Note',
                    style: TextStyle(
                      color: Color(0xFF252525),
                      fontSize: 14.sp,
                      fontFamily: GoogleFonts.poppins().fontFamily,
                      fontWeight: FontWeight.w500,
                      height: 1.43.h,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: TextField(
                      controller: _controller.noteController,
                      maxLines: 6,
                      decoration: InputDecoration(
                        hintText: 'Type here....',
                        hintStyle: TextStyle(color: Colors.grey[400]),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(16),
                      ),
                    ),
                  ),

                  SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  //helper function
  void _handleSelection(String category, String value) {
    setState(() {
      switch (category) {
        case 'menstrual_flow':
          _controller.selectedMenstrualFlow?.value =
              (_controller.selectedMenstrualFlow?.value == value ? null : value)
                  .toString();
          break;
        case 'symptoms':
          if (_controller.selectedSymptoms.contains(value)) {
            _controller.selectedSymptoms.remove(value);
          } else {
            _controller.selectedSymptoms.add(value);
          }
          break;
        case 'sex':
          _controller.selectedSex?.value =
              (_controller.selectedSex?.value == value ? null : value)
                  .toString();
          break;
      }
    });
  }
}
