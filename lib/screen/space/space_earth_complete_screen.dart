import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:kiding/screen/space/space_random_dice_earth_screen.dart';
import 'package:kiding/screen/space/space_random_dice_screen.dart';

import '../layout/complete_layout.dart';
import '../layout/exit_layout.dart';

class SpaceEarthCompleteScreen extends StatefulWidget {
  final int currentNumber;

  const SpaceEarthCompleteScreen({super.key, required this.currentNumber});

  @override
  State<SpaceEarthCompleteScreen> createState() =>
      _SpaceEarthCompleteScreenState();
}

class _SpaceEarthCompleteScreenState extends State<SpaceEarthCompleteScreen> {
  late Timer _timer;
  final int duration = 5; // 3초 후 화면 전환
  int remainingTime = 3;

  // 다음 화면
  late var nextScreen;

  @override
  void initState() {
    super.initState();
    _startTimer(remainingTime);
  }

  void _startTimer(int duration) {
    _timer = Timer(Duration(seconds: duration), _navigateToRandomDiceScreen);
  }

  void _pauseTimer() {
    if (_timer != null && _timer!.isActive) {
      _timer?.cancel();
    }
  }

  void _resumeTimer() {
    _startTimer(remainingTime);
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _navigateToRandomDiceScreen() {
    switch (widget.currentNumber) {
      case 3:
        nextScreen = SpaceRandomDiceScreen(currentNumber: widget.currentNumber);
        break;
      default:
        nextScreen =
            SpaceRandomDiceEarthScreen(currentNumber: widget.currentNumber);
        break;
    }
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => nextScreen),
    );
    log('currentNumber: ${widget.currentNumber}');
  }

  void _onBackButtonPressed() {
    _timer?.cancel(); // 타이머 취소
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ExitLayout(
                onKeepPressed: _resumeTimer,
                onExitPressed: () {},
                isFromDiceOrCamera: false,
                isFromCard: false,
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CompleteLayout(
      bgStr: 'assets/space/earth_dice_bg.png',
      backBtnStr: 'assets/space/back_icon_white.png',
      completeStr: 'assets/space/earth_complete_text.png',
      timerColor: Color(0xFFE7E7E7),
      onBackButtonPressed: _onBackButtonPressed,
    );
  }
}
