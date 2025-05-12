import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:period_tracking/app/modules/analyticsPage/controllers/analytics_page_controller.dart';
import 'package:intl/intl.dart';

class MenstrualFlowChart extends StatelessWidget {
  const MenstrualFlowChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AnalyticsPageController controller = Get.find();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await controller.initialize();
    });

    return Obx(() {
      final isMonthly = controller.isMonthlyView.value;
      final flowData = isMonthly
          ? controller.getMonthlyMenstrualFlowData()
          : controller.getMenstrualFlowData();

      final days = isMonthly
          ? controller.getMonthDays().map((day) => day.toString().padLeft(2, '0')).toList()
          : controller.getCurrentWeekDays();

      // Format for date display
      final dateFormat = DateFormat('MMM d');
      final monthYearFormat = DateFormat('MMMM yyyy');

      return Card(
        elevation: null,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Menstrual Flow',
                    style: TextStyle(
                      color: const Color(0xFF252525),
                      fontSize: 16.sp,
                      fontFamily: GoogleFonts.poppins().fontFamily,
                      fontWeight: FontWeight.w500,
                      height: 1.50.h,
                    ),
                  ),
                  ToggleButtons(
                    isSelected: [!controller.isMonthlyView.value, controller.isMonthlyView.value],
                    onPressed: (index) {
                      controller.isMonthlyView.value = index == 1;
                    },
                    borderRadius: BorderRadius.circular(4.r),
                    selectedColor: Colors.white,
                    color: const Color(0xFF9E9E9E),
                    selectedBorderColor: Colors.blue,
                    fillColor: Colors.blue,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          'Weekly',
                          style: TextStyle(
                            color: !controller.isMonthlyView.value
                                ?  Colors.white
                                : const Color(0xFF9E9E9E),
                            fontSize: 12.sp,
                            fontFamily: GoogleFonts.poppins().fontFamily,
                            fontWeight: FontWeight.w400,
                            height: 1.50.h,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          'Monthly',
                          style: TextStyle(
                            color: controller.isMonthlyView.value
                                ?  Colors.white
                                : const Color(0xFF9E9E9E),
                            fontSize: 12.sp,
                            fontFamily: GoogleFonts.poppins().fontFamily,
                            fontWeight: FontWeight.w400,
                            height: 1.50.h,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 8),
              // Date range indicator with navigation
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.chevron_left, size: 20.sp),
                    onPressed: () {
                      if (isMonthly) {
                        controller.previousMonth();
                      } else {
                        controller.previousWeek();
                      }
                    },
                  ),
                  Text(
                    isMonthly
                        ? monthYearFormat.format(DateTime(controller.selectedYear.value, controller.selectedMonth.value))
                        : '${dateFormat.format(controller.selectedWeekStart.value)} - ${dateFormat.format(controller.selectedWeekStart.value.add(Duration(days: 6)))}',
                    style: TextStyle(
                      color: const Color(0xFF252525),
                      fontSize: 14.sp,
                      fontFamily: GoogleFonts.poppins().fontFamily,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.chevron_right, size: 20.sp),
                    onPressed: () {
                      if (isMonthly) {
                        controller.nextMonth();
                      } else {
                        controller.nextWeek();
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.circle_outlined, color: Colors.red, size: 16.sp),
                  SizedBox(width: 4.w),
                  Text(
                    'Menstrual Flow',
                    style: TextStyle(
                      color: const Color(0xFF9E9E9E),
                      fontSize: 12.sp,
                      fontFamily: GoogleFonts.poppins().fontFamily,
                      fontWeight: FontWeight.w400,
                      height: 1.50.h,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              SizedBox(
                height: 200.h,
                child: isMonthly
                    ? LayoutBuilder(
                  builder: (context, constraints) {
                    // Calculate width needed for the chart with small gap at end
                    // Using the original bar width (10.w) and group space (6)
                    double barWidth = 10.w;
                    double groupSpace = 6;
                    double smallEndGap = 12.w; // Small gap at the end

                    // Calculate total width needed
                    double chartWidth = (barWidth + groupSpace) * flowData.length + smallEndGap;

                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: SizedBox(
                        width: chartWidth,
                        child: BarChart(
                          BarChartData(
                            alignment: BarChartAlignment.start,
                            groupsSpace: 6, // Original group space
                            maxY: 4,
                            barTouchData: BarTouchData(enabled: false),
                            titlesData: FlTitlesData(
                              show: true,
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  getTitlesWidget: (value, meta) {
                                    return SideTitleWidget(
                                      axisSide: meta.axisSide,
                                      child: Transform.rotate(
                                        angle: -0.5,
                                        child: Text(
                                          days[value.toInt()],
                                          style: TextStyle(
                                            color: const Color(0xFF9E9E9E),
                                            fontSize: 8.sp,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  reservedSize: 40, // Original reserved size
                                ),
                              ),
                              leftTitles: const AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                              topTitles: const AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                              rightTitles: const AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                            ),
                            gridData: const FlGridData(show: false),
                            borderData: FlBorderData(show: false),
                            barGroups: flowData.asMap().entries.map((entry) {
                              final int x = entry.key;
                              final double data = entry.value;
                              return BarChartGroupData(
                                x: x,
                                barsSpace: 4,
                                barRods: [
                                  BarChartRodData(
                                    toY: data,
                                    color: Colors.red,
                                    width: barWidth,
                                    borderRadius: BorderRadius.zero,
                                  ),
                                ],
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    );
                  },
                )
                    : BarChart(
                  BarChartData(
                    alignment: BarChartAlignment.spaceAround,
                    groupsSpace: 12,
                    maxY: 4,
                    barTouchData: BarTouchData(enabled: false),
                    titlesData: FlTitlesData(
                      show: true,
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            return SideTitleWidget(
                              axisSide: meta.axisSide,
                              child: Text(
                                days[value.toInt()],
                                style: TextStyle(
                                  color: const Color(0xFF9E9E9E),
                                  fontSize: 10.sp,
                                ),
                              ),
                            );
                          },
                          reservedSize: 28,
                        ),
                      ),
                      leftTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      topTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      rightTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                    ),
                    gridData: const FlGridData(show: false),
                    borderData: FlBorderData(show: false),
                    barGroups: flowData.asMap().entries.map((entry) {
                      final int x = entry.key;
                      final double data = entry.value;
                      return BarChartGroupData(
                        x: x,
                        barsSpace: 4,
                        barRods: [
                          BarChartRodData(
                            toY: data,
                            color: Colors.red,
                            width: 16.w,
                            borderRadius: BorderRadius.zero,
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}