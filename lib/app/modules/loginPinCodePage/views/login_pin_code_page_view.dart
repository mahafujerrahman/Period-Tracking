import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/login_pin_code_page_controller.dart';

class LoginPinCodePageView extends StatefulWidget {
  final VoidCallback? onSuccess;

  const LoginPinCodePageView({super.key, this.onSuccess});

  @override
  _LoginPinCodePageViewState createState() => _LoginPinCodePageViewState();
}

class _LoginPinCodePageViewState extends State<LoginPinCodePageView> {
  final LoginPinCodePageController _controller = Get.put(
    LoginPinCodePageController(),
  );

  int _pinLength = 4;

  void _onNumberTap(String number) {
    setState(() {
      if (_controller.isWrongPass.value) {
        _controller.isWrongPass.value = false;
      }
      if (_controller.pinCode.value.length < _pinLength) {
        _controller.pinCode.value = _controller.pinCode.value + number;
      }
    });
  }

  void _onDeleteTap() {
    setState(() {
      if (_controller.pinCode.value.isNotEmpty) {
        _controller.pinCode.value = _controller.pinCode.value.substring(
          0,
          _controller.pinCode.value.length - 1,
        );
      }
    });
  }

  Widget _buildIndicator() {
    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          _pinLength,
          (index) => Container(
            width: 12.w,
            height: 12.h,
            margin: EdgeInsets.symmetric(horizontal: 8.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color:
                  _controller.isWrongPass.value
                      ? Colors.red
                      : (index < _controller.pinCode.value.length
                          ? Colors
                              .blue // Filled circles
                          : Colors.grey[300]), // Empty circles
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNumberButton(String number) {
    return Expanded(
      child: InkWell(
        onTap: () => _onNumberTap(number),
        child: Center(child: Text(number, style: TextStyle(fontSize: 24.sp))),
      ),
    );
  }

  Widget _buildDeleteButton() {
    return Expanded(
      child: InkWell(
        onTap: () => _onDeleteTap(),
        child: Center(child: Icon(Icons.backspace)),
      ),
    );
  }

  Widget _buildNumberRow(String a, String b, String c) {
    return Row(
      children: [
        _buildNumberButton(a),
        _buildNumberButton(b),
        _buildNumberButton(c),
      ],
    );
  }

  void _handlePinCodeValidation() {
    _controller.matchPinCodeAndNavigate(
      onSuccess: () {
        widget.onSuccess?.call();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 20.h),
              Text(
                "Enter PIN",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF252525),
                  fontSize: 24.sp,
                  fontFamily: GoogleFonts.poppins().fontFamily,
                  fontWeight: FontWeight.w500,
                  height: 1.33.h,
                ),
              ),
              SizedBox(height: 32.h),
              _buildIndicator(),
              Obx(() {
                if (_controller.isWrongPass.value) {
                  return Column(
                    children: [
                      SizedBox(height: 8),
                      Text(
                        "Wrong PIN",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 16.sp,
                          fontFamily: GoogleFonts.poppins().fontFamily,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  );
                }
                return SizedBox();
              }),

              SizedBox(height: 48.h),
              _buildNumberRow("1", "2", "3"),
              SizedBox(height: 40.h),
              _buildNumberRow("4", "5", "6"),
              SizedBox(height: 40.h),
              _buildNumberRow("7", "8", "9"),
              SizedBox(height: 40.h),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(child: SizedBox()),
                  _buildNumberButton("0"),
                  _buildDeleteButton(),
                ],
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  _controller.matchPinCodeAndNavigate();
                },
                child: Container(
                  width: 343.w,
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.w,
                    vertical: 12.h,
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
                  child: Center(
                    child: Text(
                      'Go',
                      style: TextStyle(
                        color: Color(0xFFF6F6F6),
                        fontSize: 16.sp,
                        fontFamily: GoogleFonts.poppins().fontFamily,
                        fontWeight: FontWeight.w400,
                        height: 1.50.h,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8.h),
            ],
          ),
        ),
      ),
    );
  }
}
