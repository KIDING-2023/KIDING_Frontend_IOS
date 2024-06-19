import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:kiding/screen/space/space_random_dice_screen.dart';

import '../layout/complete_layout.dart';

class SpaceMarsCompleteScreen extends StatefulWidget {
  final int currentNumber;

  const SpaceMarsCompleteScreen({super.key, required this.currentNumber});

  @override
  State<SpaceMarsCompleteScreen> createState() => _SpaceMarsCompleteScreenState();
}

class _SpaceMarsCompleteScreenState extends State<SpaceMarsCompleteScreen> {
  late Timer _timer;
  final int duration = 3; // 3초 후 화면 전환

  @override
  void initState() {
    super.initState();
    _timer = Timer(Duration(seconds: duration), _navigateToRandomDiceScreen);
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _navigateToRandomDiceScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => SpaceRandomDiceScreen(
          currentNumber: widget.currentNumber,
        ),
      ),
    );
    log('currentNumber: ${widget.currentNumber}');
  }

  @override
  Widget build(BuildContext context) {
    return CompleteLayout(
      bgStr: 'assets/space/space_tutorial_dice_bg.png',
      backBtnStr: 'assets/space/back_icon_white.png',
      completeStr: 'assets/space/red_complete.png',
      timerColor: Color(0xFFE7E7E7),
    );
  }
}
