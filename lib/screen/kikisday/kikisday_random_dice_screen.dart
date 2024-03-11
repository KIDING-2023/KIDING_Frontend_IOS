import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import '../../model/timer_model.dart';

class KikisdayRandomDiceScreen extends StatefulWidget {
  final int currentNumber;

  KikisdayRandomDiceScreen({Key? key, required this.currentNumber}) : super(key: key);

  @override
  State<KikisdayRandomDiceScreen> createState() => _KikisdayRandomDiceScreenState();
}

class _KikisdayRandomDiceScreenState extends State<KikisdayRandomDiceScreen> {
  late VideoPlayerController _controller;

  // 주사위를 굴렸는지 여부를 나타내는 상태 변수
  bool _rolledDice = false;

  // 랜덤 주사위값
  late int randomNumber;

  // 주사위 굴린 후 넘겨줄 주사위값
  late int totalDice;

  // 다음 화면
  late var nextScreen;

  // @override
  // void initState() {
  //   super.initState();
  //   // 예시로 'dice1.mp4'를 사용하며, 실제 경로는 앱에 맞게 조정해야 합니다.
  //   _controller = VideoPlayerController.asset('assets/kikisday/dice1.mp4')
  //     ..initialize().then((_) {
  //       setState(() {});
  //     });
  // }
  //
  // @override
  // void dispose() {
  //   super.dispose();
  //   _controller.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          // 배경 이미지
          Positioned.fill(
            child: Image.asset(
              'assets/kikisday/kikisday_dice_bg.png',
              fit: BoxFit.cover,
            ),
          ),
          // 주사위 텍스트 이미지
          Positioned(
            top: 125.22,
            left: 0,
            right: 0,
            child: Image.asset('assets/kikisday/kikisday_random_dice_text.png',
                width: 339.79, height: 117.96),
          ),
          // 주사위 스와이프 이미지
          if (!_rolledDice)
            Positioned(
              top: 281.89, // imageView2 아래 적절한 위치 조정
              left: 0,
              right: 0,
              child: Center(
                child: Image.asset('assets/kikisday/dice_swipe.png',
                    width: 87.87, height: 139.91),
              ),
            ),
          if (!_rolledDice)
            Positioned(
              top: 350.96, // 스와이프 이미지 아래 적절한 위치 조정
              left: 0,
              right: 0,
              child: Center(
                child: Image.asset('assets/kikisday/dice_img3.png',
                    width: 360, height: 266.68),
              ),
            ),
          // 스와이프 제스처 감지
          Positioned.fill(
            child: GestureDetector(
              onVerticalDragUpdate: (details) {
                if (details.primaryDelta! < 0 && !_rolledDice) {
                  // 스와이프 감지 및 상태 업데이트
                  setState(() {
                    randomNumber = Random().nextInt(3) + 1;
                    totalDice = widget.currentNumber + randomNumber;
                    _controller = VideoPlayerController.asset('assets/kikisday/dice${randomNumber}.mp4')
                      ..initialize().then((_) {
                        setState(() {});
                        _controller.play();
                      });
                    _rolledDice = true;
                  });
                  // 주사위값에 따른 다음 화면 설정
                  switch (totalDice) {
                    case 2:
                      nextScreen = Kikisday2Screen(currentNumber: totalDice,);
                      break;
                    case 3:
                      nextScreen = Kikisday3Screen(currentNumber: totalDice,);
                      break;
                    case 4:
                      nextScreen = Kikisday4Screen(currentNumber: totalDice,);
                      break;
                    case 5:
                      nextScreen = Kikisday5Screen(currentNumber: totalDice,);
                      break;
                    case 6:
                      nextScreen = Kikisday6Screen(currentNumber: totalDice,);
                      break;
                  }
                  _controller.addListener(() {
                    if (!_controller.value.isPlaying && _rolledDice) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => nextScreen),
                      );
                      // 상태 업데이트
                      setState(() {
                        _rolledDice = false;
                      });
                      _controller.dispose(); // 컨트롤러 해제
                    }
                  });
                  // // GIF 재생 시간 후 다음 화면으로 자동 전환
                  // Future.delayed(Duration(seconds: 4), () {
                  //   // 여기에 다음 화면으로 넘어가는 코드를 작성하세요.
                  //   Navigator.push(
                  //     context,
                  //     MaterialPageRoute(builder: (context) => nextScreen),
                  //   );
                  //   // 상태 업데이트
                  //   setState(() {
                  //     _rolledDice = false;
                  //   });
                  // });
                }
              },
            ),
          ),
          // 주사위 GIF 애니메이션 (스와이프 후 전체 화면)
          Positioned.fill(
            child: _rolledDice
                ? AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            )
                : Container(),
          ),
          // if (_rolledDice)
          //   Positioned.fill(
          //     child: Image.asset(
          //       'assets/kikisday/dice${randomNumber}.gif', // 주사위 굴리는 GIF
          //       fit: BoxFit.cover,
          //     ),
          //   ),
          // 뒤로 가기 버튼
          Positioned(
            top: 45,
            left: 30,
            right: 30,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Image.asset('assets/kikisday/kikisday_back_btn.png', width: 13.16, height: 20.0),
                ),
                Consumer<TimerModel>( // TimerModel의 현재 시간을 소비합니다.
                  builder: (context, timer, child) => Text(
                    timer.formattedTime, // TimerModel로부터 현재 시간을 가져옵니다.
                    style: TextStyle(
                      fontFamily: 'Nanum',
                      fontSize: 15,
                      color: Color(0xFF868686),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Kikisday2Screen extends StatefulWidget {
  const Kikisday2Screen({super.key, required int currentNumber});

  @override
  State<Kikisday2Screen> createState() => _Kikisday2ScreenState();
}

class _Kikisday2ScreenState extends State<Kikisday2Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("2")),
    );
  }
}

class Kikisday3Screen extends StatefulWidget {
  const Kikisday3Screen({super.key, required int currentNumber});

  @override
  State<Kikisday3Screen> createState() => _Kikisday3ScreenState();
}

class _Kikisday3ScreenState extends State<Kikisday3Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("3")),
    );
  }
}

class Kikisday4Screen extends StatefulWidget {
  const Kikisday4Screen({super.key, required int currentNumber});

  @override
  State<Kikisday4Screen> createState() => _Kikisday4ScreenState();
}

class _Kikisday4ScreenState extends State<Kikisday4Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("4")),
    );
  }
}

class Kikisday5Screen extends StatefulWidget {
  const Kikisday5Screen({super.key, required int currentNumber});

  @override
  State<Kikisday5Screen> createState() => _Kikisday5ScreenState();
}

class _Kikisday5ScreenState extends State<Kikisday5Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("5")),
    );
  }
}

class Kikisday6Screen extends StatefulWidget {
  const Kikisday6Screen({super.key, required int currentNumber});

  @override
  State<Kikisday6Screen> createState() => _Kikisday6ScreenState();
}

class _Kikisday6ScreenState extends State<Kikisday6Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("6")),
    );
  }
}

