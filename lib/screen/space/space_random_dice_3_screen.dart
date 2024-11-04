import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import '../../model/timer_model.dart';
import '../layout/exit_layout.dart';

class SpaceRandomDice3Screen extends StatefulWidget {
  //final bool canread;
  final int currentNumber;

  const SpaceRandomDice3Screen({super.key, required this.currentNumber});

  @override
  State<SpaceRandomDice3Screen> createState() => _SpaceRandomDice3ScreenState();
}

class _SpaceRandomDice3ScreenState extends State<SpaceRandomDice3Screen> {
  VideoPlayerController? _controller;
  Future<void>? _initializeVideoPlayerFuture;

  // 주사위를 굴렸는지 여부를 나타내는 상태 변수
  bool _rolledDice = false;

  // 랜덤 주사위값
  late int randomNumber;

  // 주사위 굴린 후 넘겨줄 주사위값
  late int totalDice;

  // 다음 화면
  late var nextScreen;

  @override
  void initState() {
    super.initState();
    // 컨트롤러 초기화를 initState에서 하지 않고, 스와이프 감지 시에만 진행합니다.
  }

  void _initializeAndPlayVideo() {
    _controller = VideoPlayerController.asset(
        // 우주여행 주사위로 변경해야 함
        'assets/space/dice_${randomNumber}_saturn.mp4')
      ..initialize().then((_) {
        setState(() {});
        _controller?.play();
        _controller?.addListener(_checkVideo);
      });
  }

  void _checkVideo() {
    // 현재 재생 위치와 비디오 길이가 같은지 확인
    if (_controller?.value.position == _controller?.value.duration) {
      _controller?.removeListener(_checkVideo); // 리스너 제거
      _controller?.dispose(); // 컨트롤러 해제
      Navigator.of(context).pushNamed(nextScreen); // 다음 화면으로 전환
    }
  }

  // void _pauseVideo() {
  //   if (_controller.value.isPlaying) {
  //     _controller.pause();
  //   }
  // }

  void _resumeVideo() {
    _controller?.play();
    // if (!_controller.value.isPlaying) {
    //   _controller.play();
    // }
  }

  void _stopVideo() {
    _controller?.removeListener(_checkVideo);
    _controller?.dispose();
    _controller = null;
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

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
              'assets/space/saturn_blur_bg.png',
              fit: BoxFit.cover,
            ),
          ),
          // FutureBuilder를 이용해 스와이프 동작이 감지되기 전과 후의 화면을 다르게 구성
          Positioned.fill(
            child: GestureDetector(
              onVerticalDragUpdate: (details) {
                if (details.primaryDelta! < 0 && !_rolledDice) {
                  setState(() {
                    _rolledDice = true;
                    randomNumber = Random().nextInt(3) + 1;
                    totalDice = widget.currentNumber + randomNumber;
                    // 주사위값에 따른 다음 화면 설정
                    nextScreen = '/space${totalDice}';
                    _initializeAndPlayVideo();
                  });
                }
              },
              child: _rolledDice
                  ? FutureBuilder(
                      future: _initializeVideoPlayerFuture,
                      builder: (context, snapshot) {
                        if (_controller!.value.isInitialized) {
                          return AspectRatio(
                            aspectRatio: _controller!.value.aspectRatio,
                            child: VideoPlayer(_controller!),
                          );
                        } else {
                          return Center();
                          // return Center(child: CircularProgressIndicator());
                        }
                      },
                    )
                  : Stack(
                      children: <Widget>[
                        Positioned(
                          top: screenHeight * 0.39375,
                          left: 0,
                          right: 0,
                          child: Center(
                            child: Image.asset('assets/space/dice_swipe.png',
                                width: screenWidth * 0.2441, height: screenHeight * 0.1749),
                          ),
                        ),
                        Positioned(
                          top: screenHeight * 0.13,
                          left: -10,
                          right: 0,
                          child: Center(
                            child: Image.asset('assets/space/dice.png'),
                          ),
                        ),
                      ],
                    ),
            ),
          ),
          // 주사위 텍스트 이미지
          Positioned(
            top: screenHeight * 0.156525,
            left: 0,
            right: 0,
            child: Image.asset('assets/space/random_dice_text.png',
                width: screenWidth * 0.94386111, height: screenHeight * 0.212225),
          ),
          // 뒤로 가기 버튼
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
                                  onKeepPressed: _resumeVideo,
                                  onExitPressed: _stopVideo,
                                  isFromDiceOrCamera: true,
                                  isFromCard: false,
                                )),
                      );
                    },
                    icon: Image.asset(
                      'assets/space/back_icon_white.png',
                      width: screenWidth * 0.0366,
                      height: screenHeight * 0.025,
                    )),
                Consumer<TimerModel>(
                  // TimerModel의 현재 시간을 소비합니다.
                  builder: (context, timer, child) => Text(
                    timer!.formattedTime, // TimerModel로부터 현재 시간을 가져옵니다.
                    style: TextStyle(
                      fontFamily: 'Nanum',
                      fontSize: 15,
                      color: Color(0xFFE7E7E7),
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
