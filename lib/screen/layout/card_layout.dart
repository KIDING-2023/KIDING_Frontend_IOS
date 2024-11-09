import 'package:flutter/material.dart';
import 'package:kiding/screen/layout/exit_layout.dart';
import 'package:provider/provider.dart';

import '../../model/timer_model.dart';
import 'card_qr_text_screen.dart';

class CardLayout extends StatelessWidget {
  final String bgStr;
  final String backBtnStr;
  final String textStr;
  final String cardStr;
  final Widget completeScreen;
  final String okBtnStr;
  final Color timerColor;
  final int currentNumber;

  const CardLayout(
      {super.key,
      required this.bgStr,
      required this.backBtnStr,
      required this.textStr,
      required this.cardStr,
      required this.completeScreen,
      required this.okBtnStr,
      required this.timerColor,
      required this.currentNumber});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          // 배경 이미지
          Positioned.fill(
            child: Image.asset(
              bgStr,
              fit: BoxFit.cover,
            ),
          ),
          // 뒤로 가기 버튼 및 타이머
          Positioned(
            top: screenHeight * 0.05625,
            left: screenWidth * 0.0417,
            right: screenWidth * 0.0833,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ExitLayout(
                                onKeepPressed: () {},
                                onExitPressed: () {},
                                isFromDiceOrCamera: false,
                                isFromCard: true,
                              )),
                    );
                  },
                  icon: Image.asset(backBtnStr, width: screenWidth * 0.0366, height: screenHeight * 0.025),
                ),
                Consumer<TimerModel>(
                  // TimerModel의 현재 시간을 소비합니다.
                  builder: (context, timer, child) => Text(
                    timer.formattedTime, // TimerModel로부터 현재 시간을 가져옵니다.
                    style: TextStyle(
                      fontFamily: 'Nanum',
                      fontSize: 15,
                      color: timerColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // 카드 텍스트 이미지
          Positioned(
            top: screenHeight * 0.15,
            left: 0,
            right: 0,
            child: Image.asset(textStr, width: screenWidth * 0.9359, height: screenHeight * 0.1475),
          ),
          // 카드 이미지
          Positioned(
            top: screenHeight * 0.3375,
            left: 0,
            right: 0,
            child: Image.asset(cardStr, width: screenWidth * 0.4738, height: screenHeight * 0.2992),
          ),
          // 버튼
          Positioned(
              top: screenHeight * 0.56055,
              left: 0,
              right: 0,
              child: GestureDetector(
                onTap: () {
                  // complete 화면으로 전환합니다.
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => completeScreen),
                  );
                },
                child: Image.asset(okBtnStr, width: screenWidth * 0.3333, height: screenHeight * 0.0507),
              )),
          // 카드덱 읽기 버튼
          Positioned(
              top: screenHeight * 0.675,
              left: 0,
              right: 0,
              child: GestureDetector(
                onTap: () {
                  // 바코드 인식 안내 화면으로 이동
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CardQRTextScreen(
                              currentNumber: currentNumber,
                              completeScreen: completeScreen,
                          color: timerColor)));
                },
                child: Image.asset('assets/space/read_card_btn.png',
                    width: screenWidth * 0.3119, height: screenHeight * 0.04085),
              ))
        ],
      ),
    );
    ;
  }
}
