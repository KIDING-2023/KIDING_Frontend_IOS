import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'back_screen.dart';
import 'login_splash_screen.dart';

// 회원가입 비밀번호 입력 확인 화면
class PasswordConfirmScreen extends StatefulWidget {
  final String nickname; // 닉네임 받아오기
  final String phoneNumber; // 전화번호 받아오기
  final String password; // 비밀번호 받아오기

  const PasswordConfirmScreen(
      {super.key,
      required this.nickname,
      required this.phoneNumber,
      required this.password});

  @override
  State<PasswordConfirmScreen> createState() => _PasswordConfirmScreenState();
}

class _PasswordConfirmScreenState extends State<PasswordConfirmScreen> {
  final TextEditingController _pwController =
      TextEditingController(); // 비밀번호 입력 컨트롤러
  String errorMessage = "비밀번호를 다시 입력하세요"; // 에러 메시지 (항상 표시)
  bool _isErrorVisible = true; // 에러 메시지 앞 동그라미 가시성

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size; // 기기 화면 크기
    return Scaffold(
        body: Container(
      color: Colors.white,
      child: Stack(
        children: [
          // 뒤로가기 버튼
          Positioned(
            top: screenSize.height * 0.06,
            left: screenSize.width * 0.03,
            child: IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => BackScreen()));
              },
              icon: Image.asset('assets/kikisday/back_icon.png',
                  width: screenSize.width * 0.04,
                  height: screenSize.height * 0.03),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // 안내문
              Image.asset('assets/login/password_confirm_text.png',
                  width: screenSize.width * 0.74,
                  height: screenSize.height * 0.16),
              // 비밀번호 입력칸, 입력 완료 버튼
              Column(
                // 비밀번호 입력 칸
                children: [
                  Container(
                    width: screenSize.width * 0.73,
                    height: screenSize.height * 0.06,
                    // 텍스트 박스 하단 그림자
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xff000000).withOpacity(0.15),
                            spreadRadius: 0,
                            blurRadius: 1.75,
                            offset:
                                Offset(0, 0.87), // changes position of shadow
                          )
                        ]),
                    child: TextField(
                      controller: _pwController,
                      obscureText: true,
                      decoration: InputDecoration(
                          hintText: '비밀번호를 다시 입력하세요',
                          hintStyle: TextStyle(color: Color(0xFFAAAAAA)),
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(100)),
                          contentPadding: EdgeInsets.only(left: 20)),
                      style: TextStyle(
                        fontFamily: 'nanum',
                        fontSize: 17,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: screenSize.height * 0.01,
                  ),
                  // 비밀번호 오류 메시지
                  Row(
                    children: [
                      Padding(
                          padding:
                              EdgeInsets.only(left: screenSize.width * 0.21)),
                      Visibility(
                        visible: _isErrorVisible,
                        child: Icon(
                          Icons.circle,
                          size: screenSize.width * 0.01,
                          fill: 1.0,
                          color: Color(0xFFFFA37C),
                        ),
                      ),
                      Padding(
                          padding:
                              EdgeInsets.only(left: screenSize.width * 0.01)),
                      Text(
                        errorMessage,
                        style: TextStyle(
                            fontFamily: 'nanum',
                            fontSize: 13,
                            color: Color(0xFFFFA37C)),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: screenSize.height * 0.01,
                  ),
                  // 입력 완료 버튼
                  IconButton(
                    onPressed: _pw,
                    padding: EdgeInsets.zero,
                    icon: Image.asset('assets/login/input_finish_btn.png',
                        width: screenSize.width * 0.73),
                  ),
                ],
              ),
              // 진행 표시 선
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/login/progress.png',
                      width: screenSize.width * 0.23,
                      height: screenSize.height * 0.01),
                  SizedBox(
                    width: screenSize.width * 0.02,
                  ),
                  Image.asset('assets/login/progress.png',
                      width: screenSize.width * 0.23,
                      height: screenSize.height * 0.01),
                  SizedBox(
                    width: screenSize.width * 0.02,
                  ),
                  Image.asset('assets/login/progress_colored.png',
                      width: screenSize.width * 0.23,
                      height: screenSize.height * 0.01),
                ],
              )
            ],
          ),
        ],
      ),
    ));
  }

  // 비밀번호 일치 여부 확인
  void _pw() async {
    String pw_test = _pwController.text;
    String pw = widget.password;

    if (pw_test != pw) {
      setState(() {
        _isErrorVisible = true;
        errorMessage = "비밀번호가 일치하지 않습니다.";
      });
    } else {
      // 성공적인 회원가입 처리, 로그인 화면으로 이동
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => LoginSplashScreen(
                nickname: widget.nickname, password: pw_test)),
      );
    }
  }

  // // API를 통한 회원가입 요청
  // Future<void> _signup() async {
  //   String nickname = widget.nickname;
  //   String password = _pwController.text.trim();
  //   String phone = widget.phoneNumber; // 전화번호 입력 필드를 추가해야 합니다.
  //
  //   var url = Uri.parse('http://3.37.76.76:8081/signup');
  //   var response = await http.post(url,
  //       body: jsonEncode(
  //           {'nickname': nickname, 'password': password, 'phone': phone}),
  //       headers: {'Content-Type': 'application/json'});
  //
  //   if (response.statusCode == 200) {
  //     // 성공적인 회원가입 처리, 로그인 화면으로 이동
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //           builder: (context) => LoginSplashScreen(
  //               nickname: widget.nickname, password: password)),
  //     );
  //   } else {
  //     // 오류 메시지를 보여주는 로직
  //     setState(() {
  //       errorMessage = "회원가입에 실패했습니다.";
  //     });
  //   }
  // }
}
