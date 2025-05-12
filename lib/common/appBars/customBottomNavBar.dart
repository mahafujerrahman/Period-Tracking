import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:period_tracking/app/routes/app_pages.dart';
import '../quikies/app_images.dart';

class CustomBottomNavBar extends StatefulWidget {
  final int initialIndex;
  const CustomBottomNavBar({Key? key, this.initialIndex = 0}) : super(key: key);

  @override
  _CustomBottomNavBarState createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  late int _selectedIndex;

  // Define the SVG asset paths
  final List<String> _svgAssetPaths = [
    AppImage.navBarHomeIcon,
    AppImage.navBarCalenderIcon,
    AppImage.navAnalliticsIcon,
    AppImage.navInfoIcon,
  ];

  // Define labels for each icon
  final List<String> _labels = [
    'Home',
    'Calendar',
    'Analytics',
    'Info',
  ];

  // Define routes for each index
  final List<String> _routes = [
    Routes.HOME,
    Routes.CALENDER_SCREEN,
    Routes.ANALYTICS_PAGE,
    Routes.INFO_PAGE,
  ];

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
    Get.addPages([]);
  }

  void _navigateToScreen(int index) {
    // Use toNamed to preserve route history
    Get.toNamed(_routes[index]);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NavigationController>(
      init: NavigationController(),
      builder: (controller) {
        _selectedIndex = _routes.indexOf(Get.currentRoute);

        return Stack(
          children: [
            BottomAppBar(
              child: Container(
                height: 70,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildNavBarItem(0),
                    _buildNavBarItem(1),
                    _buildMiddleButton(),
                    _buildNavBarItem(2),
                    _buildNavBarItem(3),
                  ],
                ),
              ),
            ),
            if (_selectedIndex != -1)
              Positioned(
                top: 0,
                left: _calculateIndicatorPosition(context),
                child: Container(
                  height: 2,
                  width: 50,
                  color: Colors.lightBlue,
                ),
              ),
          ],
        );
      },
    );
  }

  double _calculateIndicatorPosition(BuildContext context) {
    double itemWidth = MediaQuery.of(context).size.width / 5;
    double indicatorWidth = 50;
    double centerOffset = (itemWidth - indicatorWidth) / 2;
    if (_selectedIndex < 2) {
      return itemWidth * _selectedIndex + centerOffset;
    } else {
      return itemWidth * (_selectedIndex + 1) + centerOffset;
    }
  }

  Widget _buildNavBarItem(int index) {
    bool isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () {
        _navigateToScreen(index);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            _svgAssetPaths[index],
            height: 25,
            width: 25,
            color: isSelected ? Colors.lightBlue : Colors.black,
          ),
          Text(
            _labels[index],
            style: TextStyle(
              color: isSelected ? Colors.lightBlue : Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMiddleButton() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 60,
        height: 60,
        child: SizedBox(),
      ),
    );
  }
}

// Navigation Controller to help manage route state
class NavigationController extends GetxController {
  void updateNavigation() {
    update();
  }
}