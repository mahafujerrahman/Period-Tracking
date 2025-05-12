import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:period_tracking/common/helpers/db_helper.dart';
import 'package:period_tracking/common/helpers/log_helper.dart';
import 'package:period_tracking/common/wrapper/pin_code_wrapper.dart';
import 'package:table_calendar/table_calendar.dart';
import '../controllers/log_period_calender_controller.dart';

class LogPeriodCalenderView extends StatefulWidget {
  const LogPeriodCalenderView({Key? key});

  @override
  _LogPeriodCalenderViewState createState() => _LogPeriodCalenderViewState();
}

class _LogPeriodCalenderViewState extends State<LogPeriodCalenderView> {
  DateTime _focusedDay = DateTime.now().toUtc();
  final Set<DateTime> _selectedDays = {};
  late final DateTime _firstDay;
  late final DateTime _lastDay;
  Map<DateTime, List<dynamic>> _events = {};
  DatabaseHelper dbHelper = DatabaseHelper(dbName: 'period_database.db');
  final LogPeriodCalenderController _controller = Get.put(
    LogPeriodCalenderController(),
  );

  @override
  void initState() {
    super.initState();
    _firstDay = DateTime(
      _focusedDay.year - 1,
      _focusedDay.month,
      _focusedDay.day,
    );
    _lastDay = DateTime(
      _focusedDay.year + 1,
      _focusedDay.month,
      _focusedDay.day,
    );

    // // Fetch data from DB and initialize selected days
    // _controller.fetchAllDataFromTable(dbHelper).then((_) {
    //   setState(() {
    //     _selectedDays.addAll(_controller.selectedDays);
    //
    //   });
    //
    //   LoggerHelper.debug("selected dates: $_selectedDays");
    //   LoggerHelper.debug("from controller${_controller.selectedDays}");
    //
    // });
    // In initState:
    _controller.fetchAllDataFromTable(dbHelper).then((_) {
      setState(() {
        // Add normalized dates to the _selectedDays set
        for (final date in _controller.selectedDays) {
          _selectedDays.add(DateTime(date.year, date.month, date.day));
        }
      });

      LoggerHelper.debug("selected dates: $_selectedDays");
      LoggerHelper.debug("from controller${_controller.selectedDays}");
    });
  }

  List<dynamic> _getEventsForDay(DateTime day) {
    return _events[DateTime(day.year, day.month, day.day)] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return PinCodeWrapper(
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0.w),
            child: Column(
              children: [
                Container(
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
                                child: Icon(
                                  Icons.close,
                                  color: Colors.white,
                                  size: 16.sp,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            'Calendar',
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
                        onTap: () {
                          _controller.updatePeriodLength(selectedDdays: _selectedDays);
                          Get.back();
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
                ),
                SizedBox(height: 40.h,),
                Text(
                  'Choose the dates you had your period',
                  style: TextStyle(
                    color: const Color(0xFF252525),
                    fontSize: 16.sp,
                    fontFamily: GoogleFonts.poppins().fontFamily,
                    fontWeight: FontWeight.w400,
                    height: 1.50.h,
                  ),
                ),
                SizedBox(height: 16.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.chevron_left),
                        onPressed: () {
                          setState(() {
                            _focusedDay = DateTime(
                              _focusedDay.year,
                              _focusedDay.month - 1,
                              1,
                            );
                          });
                        },
                      ),
                      Text(
                        DateFormat('MMMM yyyy').format(_focusedDay),
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontFamily: GoogleFonts.poppins().fontFamily,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.chevron_right),
                        onPressed: () {
                          setState(() {
                            _focusedDay = DateTime(
                              _focusedDay.year,
                              _focusedDay.month + 1,
                              1,
                            );
                          });
                        },
                      ),
                    ],
                  ),
                ),
                TableCalendar(
                  firstDay: _firstDay,
                  lastDay: _lastDay,
                  focusedDay: _focusedDay,
                  calendarFormat: CalendarFormat.month,
                  // selectedDayPredicate: (day) {
                  //   return _selectedDays.contains(day);
                  // },
                  selectedDayPredicate: (day) {
                    return _selectedDays.any(
                      (selectedDay) =>
                          selectedDay.year == day.year &&
                          selectedDay.month == day.month &&
                          selectedDay.day == day.day,
                    );
                  },

                  // onDaySelected: (selectedDay, focusedDay) {
                  //   setState(() {
                  //     if (_selectedDays.contains(selectedDay)) {
                  //       _selectedDays.remove(selectedDay);
                  //     } else {
                  //       _selectedDays.add(selectedDay);
                  //     }
                  //     _focusedDay = focusedDay;
                  //   });
                  // },
                  // In the onDaySelected callback:
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      // Normalize the date to remove time components
                      final normalizedDay = DateTime(
                        selectedDay.year,
                        selectedDay.month,
                        selectedDay.day,
                      );

                      if (_selectedDays.any(
                        (day) =>
                            day.year == normalizedDay.year &&
                            day.month == normalizedDay.month &&
                            day.day == normalizedDay.day,
                      )) {
                        _selectedDays.removeWhere(
                          (day) =>
                              day.year == normalizedDay.year &&
                              day.month == normalizedDay.month &&
                              day.day == normalizedDay.day,
                        );
                      } else {
                        _selectedDays.add(normalizedDay);
                      }
                      _focusedDay = focusedDay;
                    });
                  },

                  eventLoader: _getEventsForDay,
                  headerVisible: false,
                  daysOfWeekStyle: DaysOfWeekStyle(
                    weekdayStyle: TextStyle(
                      color: Colors.black,
                      fontFamily: GoogleFonts.poppins().fontFamily,
                    ),
                    weekendStyle: TextStyle(
                      color: Colors.black,
                      fontFamily: GoogleFonts.poppins().fontFamily,
                    ),
                  ),
                  calendarStyle: CalendarStyle(
                    outsideDaysVisible: true,
                    weekendTextStyle: TextStyle(
                      color: Colors.black,
                      fontFamily: GoogleFonts.poppins().fontFamily,
                    ),
                    holidayTextStyle: TextStyle(
                      color: Colors.black,
                      fontFamily: GoogleFonts.poppins().fontFamily,
                    ),
                    cellMargin: EdgeInsets.all(8.r),
                  ),
                  calendarBuilders: CalendarBuilders(
                    defaultBuilder: (context, date, _) {
                      return _buildDayCell(date);
                    },
                    todayBuilder: (context, date, _) {
                      return _buildDayCell(date, isToday: true);
                    },
                    selectedBuilder: (context, date, _) {
                      return _buildDayCell(date, isSelected: true);
                    },
                    outsideBuilder: (context, date, _) {
                      return _buildDayCell(date, isOutside: true);
                    },
                    markerBuilder: (context, date, events) {
                      return null;
                    },
                  ),
                  daysOfWeekHeight: 40.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDayCell(
    DateTime date, {
    bool isSelected = false,
    bool isToday = false,
    bool isOutside = false,
  }) {
    final hasEvents = _getEventsForDay(date).isNotEmpty;

    return Padding(
      padding: EdgeInsets.all(4.0.r),
      child: Stack(
        children: [
          DottedBorder(
            borderType: BorderType.RRect,
            radius: Radius.circular(8.r),
            dashPattern: const [5, 5],
            color: Colors.blue.withOpacity(0.7),
            strokeWidth: 1,
            child: Container(
              decoration: BoxDecoration(
                color:
                    isSelected
                        ? Colors.blue.withOpacity(0.1)
                        : Colors.transparent,
                borderRadius: BorderRadius.circular(8.r),
              ),
              width: double.infinity,
              height: double.infinity,
              child: Center(
                child: Text(
                  '${date.day}',
                  style: TextStyle(
                    color: isOutside ? Colors.grey : Colors.black,
                    fontFamily: GoogleFonts.poppins().fontFamily,
                    fontWeight: FontWeight.normal,
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ),
          ),
          if (hasEvents)
            Positioned(
              bottom: 4.h,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  width: 8.w,
                  height: 8.h,
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          if (_selectedDays.any((selectedDay) =>
          selectedDay.year == date.year &&
              selectedDay.month == date.month &&
              selectedDay.day == date.day))
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                width: 12.w,
                height: 12.h,
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(Icons.check, size: 8.sp, color: Colors.white),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
