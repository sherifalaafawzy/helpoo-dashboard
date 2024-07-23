import 'dart:async';

import 'package:flutter/material.dart';
import '../../../core/util/constants.dart';
import '../../../core/util/extensions/days_extensions.dart';

class MyClock extends StatefulWidget {
  const MyClock({super.key});

  @override
  State<MyClock> createState() => _MyClockState();
}

class _MyClockState extends State<MyClock> {
  String _timeString = '';

  @override
  void initState() {
    _timeString = _formatDateTime(DateTime.now());
    _timer();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _timer().cancel();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _timeString,
      style: TextStyle(
        color: mainColorHex,
        fontSize: 30,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Timer _timer() {
    return Timer.periodic(const Duration(seconds: 1), (Timer t) => _getTime());
  }

  void _getTime() {
    final DateTime now = DateTime.now();
    final String formattedDateTime = _formatDateTime(now);
    setState(() {
      _timeString = formattedDateTime;
    });
  }

  String _formatDateTime(DateTime dateTime) {
    return dateTime.timeFormat12;
  }
}
