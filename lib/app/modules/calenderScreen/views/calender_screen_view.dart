import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:period_tracking/app/modules/calenderScreen/controllers/calender_screen_controller.dart';
import 'package:period_tracking/app/modules/calenderScreen/views/widgets/informationPage.dart';
import 'package:period_tracking/app/modules/home/controllers/home_controller.dart';
import 'package:period_tracking/app/modules/logSymptiomsPage/controllers/log_symptioms_page_controller.dart';
import 'package:period_tracking/app/routes/app_pages.dart';
import 'package:period_tracking/common/helpers/db_helper.dart';
import 'package:period_tracking/common/helpers/log_helper.dart';
import 'package:period_tracking/common/quikies/app_images.dart';
import 'package:period_tracking/common/quikies/dialogues.dart';
import 'package:period_tracking/common/quikies/string_perser.dart';
import 'package:period_tracking/common/wrapper/pin_code_wrapper.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../common/appBars/customBottomNavBar.dart';

class CalenderScreenView extends StatefulWidget {
  const CalenderScreenView({super.key});

  @override
  State<CalenderScreenView> createState() => _CalenderScreenViewState();
}

class _CalenderScreenViewState extends State<CalenderScreenView> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  final CalenderScreenController _controller = Get.find();
  final HomeController _homeController = Get.put(HomeController());
  final LogSymptiomsPageController _logSymptiomsPageController = Get.put(
    LogSymptiomsPageController(),
  );

  StartingDayOfWeek _convertToStartingDayOfWeek(String weekName) {
    switch (weekName.toLowerCase()) {
      case 'sun':
        return StartingDayOfWeek.sunday;
      case 'mon':
        return StartingDayOfWeek.monday;
      case 'sat':
        return StartingDayOfWeek.saturday;
      default:
        return StartingDayOfWeek.sunday;
    }
  }

  @override
  void initState() {
    super.initState();
    // getAll data
    final DatabaseHelper _dbHelper = DatabaseHelper(
      dbName: 'period_database.db',
    );
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _controller.getAllData();
      await _controller.checkFirstDayTable(_dbHelper).then((_) async {
        _controller.mergeOvulationEvents();
        await _controller.addPredictedPeriodsToEvents();
        setState(() {});
      });
    });

    //print event
    LoggerHelper.info("`from controller:` ${_controller.events}");
  }

  List<String> _getEventsForDay(DateTime day) {
    // return _controller.events[day] ?? [];
    return _controller.events[day] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return PinCodeWrapper(
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: GestureDetector(
          onTap: () {
            if (_logSymptiomsPageController.selectedDate!.value.isEmpty ||
                _logSymptiomsPageController.selectedDate!.value == null) {
              Get.toNamed(Routes.LOG_SYMPTIOMS_PAGE);
            } else {
              Get.toNamed(
                Routes.LOG_SYMPTIOMS_PAGE,
                parameters: {
                  "sentDate": _logSymptiomsPageController.selectedDate!.value,
                },
              );
            }
          },
          child: Container(
            width: 50.w,
            height: 50.h,
            decoration: BoxDecoration(
              color: Colors.lightBlue,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.add, color: Colors.white, size: 30.sp),
          ),
        ),
        bottomNavigationBar: CustomBottomNavBar(initialIndex: 1),
        body: SafeArea(
          child: Column(
            children: [
              Container(
                width: 375.w,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: 120,
                  children: [
                    Text(
                      'Calendar',
                      style: TextStyle(
                        color: Color(0xFF252525),
                        fontSize: 16.sp,
                        fontFamily: GoogleFonts.poppins().fontFamily,
                        fontWeight: FontWeight.w400,
                        height: 1.50.h,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.LOG_PERIOD_CALENDER);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
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
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          spacing: 8,
                          children: [
                            SvgPicture.asset(
                              AppImage.calenderWhiteIcon,
                              color: Colors.white,
                              height: 15.h,
                            ),
                            Text(
                              'Edit',
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
                  ],
                ),
              ),
              // Legend
              Informationpage(),

              Obx(
                () => TableCalendar(
                  firstDay: DateTime.utc(2024, 10, 20),
                  lastDay: DateTime.utc(2028, 10, 20),
                  focusedDay: _focusedDay,
                  calendarFormat: _calendarFormat,
                  selectedDayPredicate: (day) {
                    return isSameDay(_selectedDay, day);
                  },
                  startingDayOfWeek: _convertToStartingDayOfWeek(
                    _controller.weekFirstDay.value ?? 'Sun',
                  ),

                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                      _logSymptiomsPageController.selectedDate?.value =
                          selectedDay.toString().split(" ")[0];
                    });
                    final selectedDayData = _controller.dailyData[selectedDay];

                    //  LoggerHelper.error("jadu jadu =========>> ${selectedDay.toString().split(" ")[0]}");

                    final formatter = DateFormat("MMM dd");
                    final localtime = selectedDay.toLocal();

                    final formattedDate = formatter.format(localtime);

                    if (_getEventsForDay(selectedDay).isNotEmpty) {
                      LoggerHelper.warn(
                        StringParser.parseSymptomsList(
                          selectedDayData?['symptoms'],
                        ),
                      );

                      if (selectedDayData?['menstrualFlow'] != null ||
                          (selectedDayData?['note'] != null &&
                              selectedDayData?['note'].isNotEmpty) ||
                          selectedDayData?['mood'] != null ||
                          selectedDayData?['energy'] != null) {
                        showSymptomDialogue(
                          context,
                          menstrualFlow: selectedDayData?['menstrualFlow'],
                          note: selectedDayData?['note'],
                          moodLevel: selectedDayData?['mood'],
                          energyLevel: selectedDayData?['energy'],
                          date: formattedDate,
                          symptoms: StringParser.parseSymptomsList(
                            selectedDayData?['symptoms'],
                          ),
                        );
                      }
                    }
                  },

                  onFormatChanged: (format) {
                    setState(() {
                      _calendarFormat = format;
                    });
                  },
                  onPageChanged: (focusedDay) {
                    _focusedDay = focusedDay;
                  },
                  calendarStyle: CalendarStyle(
                    selectedDecoration: BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.rectangle,
                      border: Border.all(width: 1, color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(5.r),
                    ),
                    selectedTextStyle: TextStyle(color: Colors.white),
                    todayDecoration: BoxDecoration(
                      color: Colors.blue[200],
                      shape: BoxShape.rectangle,
                      border: Border.all(width: 1, color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(5.r),
                    ),
                    defaultDecoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(5.r),
                      border: Border.all(width: 1, color: Colors.grey.shade300),
                    ),
                    weekendDecoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      border: Border.all(width: 1, color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(5.r),
                    ),
                  ),
                  headerStyle: HeaderStyle(
                    titleCentered: true,
                    formatButtonVisible: false,
                    titleTextFormatter:
                        (date, locale) => DateFormat.yMMMM(locale).format(date),
                  ),
                  calendarBuilders: CalendarBuilders(
                    markerBuilder: (context, day, events) {
                      List<String> dayEvents = _getEventsForDay(day);

                      if (dayEvents.isNotEmpty) {
                        return Positioned(
                          bottom: 5,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children:
                                dayEvents.map((event) {
                                  if (event == 'dot') {
                                    return Container(
                                      height: 5.h,
                                      width: 5.w,
                                      margin: EdgeInsets.symmetric(
                                        horizontal: 0.5,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.green,
                                        shape: BoxShape.circle,
                                      ),
                                    );
                                  } else if (event == 'heart') {
                                    return Icon(
                                      Icons.favorite,
                                      color: Colors.pink,
                                      size: 10.sp,
                                    );
                                  } else if (event == 'drop') {
                                    return Icon(
                                      Icons.water_drop,
                                      color: Colors.red,
                                      size: 10.sp,
                                    );
                                  } else if (event == 'predicted_drop') {
                                    return Icon(
                                      Icons.water_drop_outlined,
                                      color: Colors.red,
                                      size: 10.sp,
                                    );
                                  } else if (event == 'ovulation') {
                                    return Icon(
                                      Icons.circle,
                                      color: Color(0xFFE4AEF6),
                                      size: 8.sp,
                                    );
                                  } else if (event == 'pain') {
                                    return Icon(
                                      Icons.circle,
                                      color: Colors.blue,
                                      size: 8.sp,
                                    );
                                  } else if (event == 'other') {
                                    return Icon(
                                      Icons.circle,
                                      color: Color(0xFFF2BE60),
                                      size: 8.sp,
                                    );
                                  }
                                  return SizedBox.shrink();
                                }).toList(),
                          ),
                        );
                      }
                      return null;
                    },

                    defaultBuilder: (context, day, focusedDay) {
                      if (_getEventsForDay(day).isNotEmpty) {
                        return Padding(
                          // Add Padding
                          padding: const EdgeInsets.all(2.0),
                          child: Container(
                            decoration: BoxDecoration(
                              // color: Color(0xFFFEEAEA),
                              border: Border.all(width: 1, color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(5.r),
                            ),
                            child: Center(
                              child: Text(
                                day.day.toString(),
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                        );
                      }
                      return null;
                    },
                    todayBuilder: (context, day, focusedDay) {
                      if (_getEventsForDay(day).isNotEmpty) {
                        return Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color(0xFFFEEAEA),
                              border: Border.all(width: 1, color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(5.r),
                            ),
                            child: Center(
                              child: Text(
                                day.day.toString(),
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                        );
                      }
                      return null;
                    },
                    selectedBuilder: (context, day, focusedDay) {
                      if (_getEventsForDay(day).isNotEmpty) {
                        return Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color(0xFFFEEAEA),
                              border: Border.all(width: 1, color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(5.r),
                            ),
                            child: Center(
                              child: Text(
                                day.day.toString(),
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                        );
                      }
                      return null;
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
