import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kiding/screen/space/space_barcode_text_screen.dart';
import 'package:kiding/screen/space/space_venus_complete_screen.dart';

import '../layout/card_layout.dart';

class Space6Screen extends StatefulWidget {
  const Space6Screen({super.key});

  @override
  State<Space6Screen> createState() => _Space6ScreenState();
}

class _Space6ScreenState extends State<Space6Screen> {
  late bool canread;

  @override
  void initState() {
    super.initState();

    // 인자를 추출합니다.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args = ModalRoute.of(context)!.settings.arguments as Map;
      if (args != null) {
        canread = args['canread'];
        // canread가 false인 경우 3초 후에 화면 전환
        if (!canread) {
          Timer(Duration(seconds: 3), () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => SpaceBarcodeTextScreen(currentNumber: 6, canread: canread)),
            );
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return CardLayout(
        bgStr: 'assets/space/venus_card_bg.png',
        backBtnStr: 'assets/space/back_icon_white.png',
        textStr: 'assets/space/6_text.png',
        cardStr: 'assets/space/venus_card.png',
        completeScreen: SpaceVenusCompleteScreen(
          currentNumber: 6, canread: true,
        ),
        okBtnStr: 'assets/space/venus_card_btn.png',
        timerColor: Color(0xFFE7E7E7));
  }
}
