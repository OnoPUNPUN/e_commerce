import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OtpNotifier extends StateNotifier<int> {
  OtpNotifier() : super(120) {
    _startTimer();
  }

  Timer? _timer;

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state > 0) {
        state--;
      } else {
        timer.cancel();
      }
    });
  }

  void resetTimer() {
    state = 120;
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

final otpProvider = StateNotifierProvider<OtpNotifier, int>((ref) {
  return OtpNotifier();
});
