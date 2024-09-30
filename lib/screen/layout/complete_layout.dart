import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/timer_model.dart';
import 'exit_layout.dart';

class CompleteLayout extends StatelessWidget {
  final String bgStr;
  final String backBtnStr;
  final String completeStr;
  final Color timerColor;
  final VoidCallback onBackButtonPressed;

  const CompleteLayout(
      {super.key,
      required this.bgStr,
      required this.backBtnStr,
      required this.completeStr,
      required this.timerColor,
      required this.onBackButtonPressed});

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
                    onPressed: onBackButtonPressed,
                    icon: Image.asset(backBtnStr, width: screenWidth * 0.0366, height: screenHeight * 0.025)),
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
          // 키딩칩 획득 이미지
          Positioned(
            top: screenHeight * 0.1596,
            left: 0,
            right: 0,
            child: Image.asset(completeStr, width: screenWidth * 0.9359, height: screenHeight * 0.4627),
          ),
        ],
      ),
    );
  }
}
