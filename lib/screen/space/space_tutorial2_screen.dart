import 'package:flutter/material.dart';
import 'package:kiding/screen/space/space_random_dice_screen.dart';
import 'package:kiding/screen/space/space_tutorial_dice_screen.dart';

import '../layout/tutorial_layout.dart';

class SpaceTutorial2Screen extends StatefulWidget {
  final int userId;

  const SpaceTutorial2Screen({super.key, required this.userId});

  @override
  State<SpaceTutorial2Screen> createState() => _SpaceTutorial2ScreenState();
}

class _SpaceTutorial2ScreenState extends State<SpaceTutorial2Screen> {
  @override
  Widget build(BuildContext context) {
    return TutorialLayout(
      bgStr: 'assets/space/space_tutorial_bg.png',
      backBtnStr: 'assets/space/back_icon_white.png',
      textWid: Image.asset(
        'assets/kikisday/kikisday_tutorial2_text.png',
        width: 339.79,
        height: 229.08,
      ),
      characterWid: Image.asset(
        'assets/space/space_tutorial2_ch.png',
        width: 360,
        height: 302.53,
      ),
      okBtnStr: 'assets/kikisday/kikisday_ok_btn.png',
      timerColorStr: Color(0xFFE7E7E7),
      // 튜토리얼 주사위 화면으로 수정 필요
      screenBuilder: (context) => SpaceRandomDiceScreen(userId: widget.userId, currentNumber: 3,),
    );
  }
}
