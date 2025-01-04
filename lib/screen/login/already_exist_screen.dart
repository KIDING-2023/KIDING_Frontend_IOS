import 'package:flutter/material.dart';
import 'package:kiding_frontend/screen/login/find_nickname_screen.dart';
import 'package:kiding_frontend/screen/login/find_password_screen.dart';

class AlreadyExistScreen extends StatelessWidget {
  const AlreadyExistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/login/character_logo.png',
                  width: 244,
                  height: 48,
                ),
                Text(
                  '이미 있는 계정입니다',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontFamily: 'Nanum',
                    fontWeight: FontWeight.w800,
                    height: 1.60,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 179.71,
            ),
            Column(
              children: [
                Text(
                  '내 계정이 기억나지 않는다면,',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                    fontFamily: 'Nanum',
                    fontWeight: FontWeight.w800,
                    height: 1.86,
                  ),
                ),
                SizedBox(
                  height: 6.14,
                ),
                Container(
                  width: 259.96,
                  height: 52.47,
                  decoration: ShapeDecoration(
                    color: Color(0xFFEDEDED),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(31.29),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FindNicknameScreen(),
                            ),
                          );
                        },
                        child: Container(
                          width: 121.11,
                          height: 43.63,
                          decoration: ShapeDecoration(
                            color: Color(0xFFFF6A2A),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(31.29),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              '닉네임 찾기',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                fontFamily: 'Nanum',
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FindPasswordScreen(),
                            ),
                          );
                        },
                        child: Container(
                          width: 121.11,
                          height: 43.63,
                          decoration: ShapeDecoration(
                            color: Color(0xFFFF6A2A),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(31.29),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              '비밀번호 찾기',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                fontFamily: 'Nanum',
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
