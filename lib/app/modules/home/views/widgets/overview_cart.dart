import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class OverviewCard extends StatelessWidget {
  final String cycleCount;
  final int cycleTotalDays;

  const OverviewCard({
    super.key,
    required this.cycleCount,
    required this.cycleTotalDays,
  });

  String getPhase(int currentDay, int totalDays) {
    // Calculate phases based on cycle length
    // General pattern: Menstrual (1-5 days), Follicular (varies), Ovulation (typically 3 days), Luteal (14 days)

    // For all cycle lengths, menstrual phase is roughly the first 3-7 days
    // Using 5 days as the standard menstrual phase length
    if (currentDay >= 1 && currentDay <= 5) return "Menstrual";

    // Ovulation typically occurs 14 days before the end of the cycle
    int ovulationDay = totalDays - 14;

    // Ovulation phase is typically 1-3 days centered around ovulation day
    int ovulationStart = ovulationDay - 1;
    int ovulationEnd = ovulationDay + 1;

    // Follicular phase is after menstrual phase until ovulation
    if (currentDay >= 6 && currentDay < ovulationStart) return "Follicular";

    // Ovulation phase
    if (currentDay >= ovulationStart && currentDay <= ovulationEnd)
      return "Ovulation";

    // Luteal phase is after ovulation until end of cycle
    if (currentDay > ovulationEnd && currentDay <= totalDays) return "Luteal";

    // Handle edge cases
    if (totalDays < 24 ||
        totalDays > 38 ||
        currentDay < 1 ||
        currentDay > totalDays)
      return "Unknown";

    return "Unknown";
  }

  String getFertility(int currentDay, int totalDays) {
    // Get fertility level based on phase
    String phase = getPhase(currentDay, totalDays);

    if (phase == "Menstrual") return "Very Low";
    if (phase == "Follicular") return "Medium";
    if (phase == "Ovulation") return "Very High";
    if (phase == "Luteal") return "Low";

    return "Unknown";
  }

  Color getPhaseColor(String phase) {
    if (phase == "Menstrual") return Color(0xFF50D4FB);
    if (phase == "Follicular") return Color(0xFFFFC107);
    if (phase == "Ovulation") return Color(0xFFE91E63);
    if (phase == "Luteal") return Color(0xFF9C27B0);
    return Color(0xFF9E9E9E);
  }

  Color getFertilityColor(String fertility) {
    if (fertility == "Very Low") return Color(0xFFF22C2C);
    if (fertility == "Low") return Color(0xFFFF9800);
    if (fertility == "Medium") return Color(0xFFFFEB3B);
    if (fertility == "Very High") return Color(0xFF4CAF50);
    return Color(0xFF9E9E9E);
  }

  @override
  Widget build(BuildContext context) {
    int currentDay = int.tryParse(cycleCount) ?? 1;
    String phase = getPhase(currentDay, cycleTotalDays);
    String fertility = getFertility(currentDay, cycleTotalDays);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey.withOpacity(0.5), width: 0.5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Today\'s Overview',
              style: TextStyle(
                color: Color(0xFF252525),
                fontSize: 14.sp,
                fontFamily: GoogleFonts.poppins().fontFamily,
                fontWeight: FontWeight.w500,
                height: 1.43.h,
              ),
            ),
            SizedBox(height: 16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                OverviewItem(
                  title: "Cycle Day",
                  value: cycleCount,
                  color: Color(0xFF252525),
                ),
                OverviewItem(
                  title: "Fertility",
                  value: fertility,
                  color: getFertilityColor(fertility),
                ),
                OverviewItem(
                  title: "Phase",
                  value: phase,
                  color: getPhaseColor(phase),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class OverviewItem extends StatelessWidget {
  final String title;
  final String value;
  final Color color;

  const OverviewItem({
    Key? key,
    required this.title,
    required this.value,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            color: color,
            fontSize: 16.sp,
            fontFamily: GoogleFonts.poppins().fontFamily,
            fontWeight: FontWeight.w600,
            height: 1.50.h,
          ),
        ),
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFF9E9E9E),
            fontSize: 12.sp,
            fontFamily: GoogleFonts.poppins().fontFamily,
            fontWeight: FontWeight.w400,
            height: 1.50.h,
          ),
        ),
      ],
    );
  }
}
