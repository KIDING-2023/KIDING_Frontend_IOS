import 'package:flutter/material.dart';
import '../layout/card_layout.dart';
import 'kikisday_blue_complete_screen.dart';

class Kikisday3Screen extends StatefulWidget {
  const Kikisday3Screen({super.key});

  @override
  State<Kikisday3Screen> createState() => _Kikisday3ScreenState();
}

class _Kikisday3ScreenState extends State<Kikisday3Screen> {
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
      bgStr: 'assets/kikisday/kikisday_bg.png',
      backBtnStr: 'assets/kikisday/kikisday_back_btn.png',
      textStr: 'assets/kikisday/kikisday_3_text.png',
      cardStr: 'assets/kikisday/kikisday_blue_card.png',
      completeScreen: KikisdayBlueCompleteScreen(currentNumber: 3, userId: userId),
      okBtnStr: 'assets/kikisday/kikisday_blue_btn.png',
      timerColor: Color(0xFF868686),
    );
  }
}
