import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:period_tracking/app/routes/app_pages.dart';
import 'package:period_tracking/common/quikies/app_images.dart';

class SymptomsCard extends StatelessWidget {
  final List<String> symptomsList;

  const SymptomsCard({super.key, required this.symptomsList});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey.withOpacity(0.5), width: 0.5.w),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Today's Symptoms",
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 16.h),
            GestureDetector(
              onTap: () {
                Get.toNamed(Routes.LOG_SYMPTIOMS_PAGE);
              },
              child: SizedBox(
                width: 240.w,
                height: 75.h,
                child: Stack(
                  children: [
                    for (int i = 0; i < symptomsList.length && i < 3; i++)
                      Positioned(
                        left: (i * 50).w,
                        child: SymptomIcon(
                          icon: _getIconForSymptom(symptomsList[i]),
                          color: Colors.white,
                        ),
                      ),

                    if (symptomsList.length > 3)
                      Positioned(
                        left: 150.w,
                        child: AddMoreSymptoms(
                          moreCount: symptomsList.length - 3,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getIconForSymptom(String symptom) {
    switch (symptom) {
      case 'Headache':
        return AppImage.headacheIcon;
      case 'Breast Tenderness':
        return AppImage.breastIcon;
      case 'Backache':
        return AppImage.backache;
      case 'Cramps':
        return AppImage.crampsIcon;
      case 'Other Symptoms':
        return AppImage.otherIcon;
      case 'Other Discharge':
        return AppImage.otherIcon;
      default:
        return AppImage.oneIcon;
    }
  }
}

class SymptomIcon extends StatelessWidget {
  final String icon;
  final Color color;

  const SymptomIcon({Key? key, required this.icon, required this.color})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 73.w,
      height: 73.w,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: Colors.grey.withOpacity(0.5), width: 0.5.w),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: SvgPicture.asset(
            icon,
            height: 20.sp,
            // color: Colors.grey[700],
          ),
        ),
      ),
    );
  }
}

class AddMoreSymptoms extends StatelessWidget {
  final int moreCount;

  const AddMoreSymptoms({super.key, required this.moreCount});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 73.w,
      height: 73.h,
      decoration: BoxDecoration(
        color: Colors.blue.shade300,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Center(
        child: Text(
          "+$moreCount",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
