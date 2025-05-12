import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:period_tracking/app/modules/splashScreen/controllers/splash_screen_controller.dart';
import 'package:period_tracking/common/quikies/app_images.dart';

class SplashScreenView extends StatefulWidget {
  const SplashScreenView({super.key});

  @override
  State<SplashScreenView> createState() => _SplashScreenViewState();
}

class _SplashScreenViewState extends State<SplashScreenView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  final double finalSize = 214.0;
  final SplashScreenController _splashScreenController = Get.put(SplashScreenController(),);

  @override
  void initState() {
    super.initState();
    _initializeAnimation();
    _splashScreenController.checkTokenAndNavigate();
  }

  void _initializeAnimation() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double initialSize =
        screenSize.width > screenSize.height
            ? screenSize.width
            : screenSize.height;

    _animation = Tween<double>(
      begin: initialSize,
      end: finalSize,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    return Scaffold(
      body: Center(
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Image.asset(
              AppImage.appLogo,
              height: _animation.value,
              width: _animation.value,
              fit: BoxFit.cover,
            );
          },
        ),
      ),
    );
  }
}
