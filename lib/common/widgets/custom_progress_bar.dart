import 'package:flutter/material.dart';

class CustomProgressBar extends StatelessWidget {
  final double value;
  final double height;
  final Radius borderRadius;

  const CustomProgressBar({
    super.key,
    required this.value,
    this.height = 16.0,
    this.borderRadius = const Radius.circular(8.0),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(borderRadius),
          color: Color(0xFF4DB9F8).withAlpha(50),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.all(borderRadius),
          child: Stack(
            children: [
              SizedBox(
                height: height,
                child: LinearProgressIndicator(
                  value: value,
                  backgroundColor: Colors.transparent,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Colors.transparent,
                  ),
                ),
              ),
              Positioned.fill(
                child: FractionallySizedBox(
                  widthFactor: value,
                  alignment: Alignment.centerLeft,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFF4DB9F8),
                          Color(0xFF4DB9F8),
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                    ),
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