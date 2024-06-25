import 'package:flutter/material.dart';
import '../layout/card_layout.dart';
import 'kikisday_skyblue_complete_screen.dart';

class Kikisday10Screen extends StatefulWidget {
  const Kikisday10Screen({super.key});

  @override
  State<Kikisday10Screen> createState() => _Kikisday10ScreenState();
}

class _Kikisday10ScreenState extends State<Kikisday10Screen> {
  late int userId;

  @override
  void initState() {
    super.initState();

    // 인자를 추출합니다.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args = ModalRoute.of(context)!.settings.arguments as Map;
      if (args != null) {
        userId = args['userId']; // userId 인자 사용
        // userId를 사용한 추가 로직
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return CardLayout(
      bgStr: 'assets/kikisday/kikisday_2_bg.png',
      backBtnStr: 'assets/kikisday/kikisday_back_btn.png',
      textStr: 'assets/kikisday/kikisday_10_text.png',
      cardStr: 'assets/kikisday/kikisday_skyblue_card.png',
      completeScreen: KikisdaySkyblueCompleteScreen(currentNumber: 10, userId: userId,),
      okBtnStr: 'assets/kikisday/kikisday_skyblue_btn.png',
      timerColor: Color(0xFF868686),
    );
  }
}
