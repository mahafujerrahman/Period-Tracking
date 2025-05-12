import 'package:flutter/material.dart';
import 'package:period_tracking/app/modules/loginPinCodePage/views/login_pin_code_page_view.dart';
import 'package:period_tracking/common/helpers/db_helper.dart';
import 'package:period_tracking/common/helpers/log_helper.dart';

class PinCodeWrapper extends StatefulWidget {
  final Widget child;
  final bool enablePinCode;

  const PinCodeWrapper({
    super.key,
    required this.child,
    this.enablePinCode = true,
  });

  @override
  _PinCodeWrapperState createState() => _PinCodeWrapperState();
}

class _PinCodeWrapperState extends State<PinCodeWrapper> with WidgetsBindingObserver {
  bool _showPinCode = false;
  bool _isPinTableExists = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _checkPinTableStatus();
  }

  Future<void> _checkPinTableStatus() async {
    try {
      final isPinTableExists = await checkUserPinTable();
      setState(() {
        _isPinTableExists = isPinTableExists;
      });
    } catch (e) {
      LoggerHelper.info("Error checking PIN table: $e");
      setState(() {
        _isPinTableExists = false;
      });
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed &&
        widget.enablePinCode &&
        _isPinTableExists) {
      setState(() {
        _showPinCode = true;
      });
    }
  }

  void _hidePinCode() {
    setState(() {
      _showPinCode = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Only show PIN code page if:
    // 1. PIN code is enabled
    // 2. PIN table exists
    // 3. App is in resumed state
    if (_showPinCode && widget.enablePinCode && _isPinTableExists) {
      return LoginPinCodePageView(
        onSuccess: _hidePinCode,
      );
    }

    // Otherwise, show the original child widget
    return widget.child;
  }
  final dbHelper = DatabaseHelper(dbName: 'period_database.db');

  // Reuse the existing method from your database helper
  Future<bool> checkUserPinTable() async {
    try {
      final db = await dbHelper.database;
      // Query to check if the table exists     
      final tables = await db.rawQuery(
        "SELECT name FROM sqlite_master WHERE type='table' AND name='user_pin'",
      );
      // Check if the table was found     
      if (tables.isNotEmpty) {
        LoggerHelper.info("==========>>user_pin table found<<==========");
        return true;
      } else {
        LoggerHelper.info("==========>>user_pin table not found<<==========");
        return false;
      }
    } catch (e) {
      LoggerHelper.info("==========>>Error checking user_pin table: $e<<==========");
      return false;
    }
  }
}
