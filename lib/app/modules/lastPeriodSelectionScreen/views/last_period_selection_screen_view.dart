import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:period_tracking/app/data/app_constants.dart';
import 'package:period_tracking/common/helpers/log_helper.dart';
import 'package:period_tracking/common/helpers/share_pref_helper.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../common/quikies/dialogues.dart';
import '../../../../common/widgets/custom_progress_bar.dart';
import '../../../routes/app_pages.dart';
import '../controllers/last_period_selection_screen_controller.dart';

class LastPeriodSelectionScreenView extends StatefulWidget {
  const LastPeriodSelectionScreenView({super.key});

  @override
  State<LastPeriodSelectionScreenView> createState() =>
      _LastPeriodSelectionScreenViewState();
}

class _LastPeriodSelectionScreenViewState
    extends State<LastPeriodSelectionScreenView> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  final CalendarFormat _calendarFormat = CalendarFormat.month;
  late DateTime thirtyDaysAgo;

  @override
  void initState() {
    super.initState();
    // Get the current UTC date and time
    DateTime now = DateTime.now().toUtc();
    // Subtract 30 days using the Duration class
    thirtyDaysAgo = now.subtract(Duration(days: 30));
    _selectedDay = DateTime.now().toUtc();
  }

  final LastPeriodSelectionScreenController
  _lastPeriodSelectionScreenController = Get.put(
    LastPeriodSelectionScreenController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              _buildProgressIndicator(context),
              SizedBox(height: 40.h),
              SizedBox(
                width: 343.w,
                child: Text(
                  'When did your last period start ?',
                  style: TextStyle(
                    color: Color(0xFF252525),
                    fontSize: 24.sp,
                    fontFamily: GoogleFonts.openSans().fontFamily,
                    fontWeight: FontWeight.w500,
                    height: 1.33.h,
                  ),
                ),
              ),
              TableCalendar(
                firstDay: thirtyDaysAgo,
                lastDay: DateTime.utc(2028,10,30),
                focusedDay: _focusedDay,
                calendarFormat: _calendarFormat,
                headerStyle: HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                  leftChevronIcon: const Icon(
                    Icons.chevron_left,
                    color: Colors.black54,
                  ),
                  rightChevronIcon: const Icon(
                    Icons.chevron_right,
                    color: Colors.black54,
                  ),
                  titleTextStyle: const TextStyle(fontSize: 16),
                ),
                calendarStyle: CalendarStyle(
                  weekendTextStyle: TextStyle(color: Colors.black54),
                  outsideDaysVisible: true,
                  markersMaxCount: 0,
                  selectedDecoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment(0.00, -1.00),
                      end: Alignment(0, 1),
                      colors: [Color(0xFF50D4FB), Color(0xFF3AA5E3)],
                    ),
                    // borderRadius: BorderRadius.circular(2),
                  ),
                  todayDecoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(color: Color(0xFF3AA5E3), width: 1),
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(2),
                  ),
                  todayTextStyle: TextStyle(color: Colors.black),
                  defaultTextStyle: TextStyle(color: Colors.black87),
                  cellMargin: EdgeInsets.all(4),
                  cellPadding: EdgeInsets.all(0),
                ),
                availableGestures: AvailableGestures.horizontalSwipe,
                selectedDayPredicate: (day) {
                  return isSameDay(_selectedDay, day);
                },
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                    _lastPeriodSelectionScreenController
                        .lastMenstrualStartDate
                        .value = selectedDay.toUtc().toString();
                  });
                },
                onPageChanged: (focusedDay) {
                  _focusedDay = focusedDay;
                },
                daysOfWeekStyle: DaysOfWeekStyle(
                  weekdayStyle: TextStyle(
                    fontWeight: FontWeight.normal,
                    color: Colors.black54,
                    fontSize: 12,
                  ),
                  weekendStyle: TextStyle(
                    fontWeight: FontWeight.normal,
                    color: Colors.black54,
                    fontSize: 12,
                  ),
                ),
                calendarBuilders: CalendarBuilders(
                  headerTitleBuilder: (context, date) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            DateFormat('MMMM yyyy').format(date),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Spacer(),
              _buildNavigationButtons(context),
              SizedBox(height: 8.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavigationButtons(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 350.w,
        height: 50.h,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 12,
          children: [
            // InkWell(
            //   onTap: () {
            //     Get.back();
            //   },
            //   child: _buildBackButton(),
            // ),
            _buildNextButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildNextButton(BuildContext context) {
    return InkWell(
      onTap: () async {
        PrefsHelper.setBool(AppConstants.hasUsed, true);
        LoggerHelper.warn(
          _lastPeriodSelectionScreenController.lastMenstrualStartDate.value,
        );
        _lastPeriodSelectionScreenController.saveInfo();
      },
      child: Container(
        width: 343.w,
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
            'Continue',
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

  Widget _buildProgressIndicator(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: SizedBox(
            width: 100.w,
            child: CustomProgressBar(value: 1, height: 8.h),
          ),
        ),
        SizedBox(width: 20.w),
        GestureDetector(
          onTap: () async {
            PrefsHelper.setBool(AppConstants.hasUsed, true);
          },
          child: _buildSkipButton(),
        ),
      ],
    );
  }

  Widget _buildSkipButton() {
    return GestureDetector(
      onTap: () {
        // Get.toNamed(Routes.HOME);
        showNoDataPopUp(context, message: 'If you skip this step, no analytics—such as predicted ovulation periods or menstrual cycle dates—will be displayed on the homepage.',);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: ShapeDecoration(
          gradient: const LinearGradient(
            begin: Alignment(0.00, -1.00),
            end: Alignment(0, 1),
            colors: [Color(0xFF50D4FB), Color(0xFF3AA5E3)],
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
        child: Text(
          'Skip',
          style: TextStyle(
            color: const Color(0xFFF6F6F6),
            fontSize: 16.sp,
            fontFamily: GoogleFonts.poppins().fontFamily,
            fontWeight: FontWeight.w400,
            height: 1.50.h,
          ),
        ),
      ),
    );
  }
}
