import 'dart:async';

import 'package:flutter/material.dart';

class LifecyclePeriodicTimer extends WidgetsBindingObserver {
  final Duration delay;
  final Function() onTick;

  LifecyclePeriodicTimer({
    this.delay = const Duration(milliseconds: 500),
    required this.onTick,
  }) {
    WidgetsBinding.instance.addObserver(this);
    _startTimer();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        _startTimer();
        break;
      case AppLifecycleState.inactive:
        _cancelTimer();
        break;
      default:
    }
    super.didChangeAppLifecycleState(state);
  }

  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _cancelTimer();
  }

  Timer? _timer;

  void _startTimer() {
    if (_timer != null) return;
    _timer = Timer.periodic(delay, (t) => onTick());
  }

  void _cancelTimer() {
    _timer?.cancel();
    _timer = null;
  }

}
