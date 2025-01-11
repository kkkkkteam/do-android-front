import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            '비밀번호 변경',
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontFamily: 'NanumGothic',
              fontWeight: FontWeight.w400,
            ),
          ),
          centerTitle: true, // 제목 중앙 배치
          leading: IconButton(
            color: Colors.black,
            icon: Icon(Icons.arrow_back),
            onPressed: () {},
          ),
          backgroundColor: Colors.white, // 앱바 배경색
          elevation: 0, // 그림자 제거
        ),
        body: Column(
          children: [
            // AppBar 아래 회색 경계선
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Color(0xFFD9D9D9), // 회색 경계선 색상
                    width: 1.5, // 경계선 두께
                  ),
                ),
              ),
            ),
            SizedBox(height: 30), // 경계선과 내용 간격
            SizedBox(
              width: 350,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, // 자식 위젯 왼쪽 정렬
                children: [
                  Text(
                    '비밀번호 입력',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: 'Jua',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 15),
                  Container(
                    width: double.infinity,
                    height: 4,
                    color: Color(0xFF2E9528),
                  ),
                  SizedBox(height: 11,),
                  Text(
                    '기존 비밀번호 입력 후 새 비밀번호를 입력하세요.',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: 'NanumGothic',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 50,),
                  passwordInputField('현재 비밀번호'),
                  passwordInputField('새 비밀번호'),
                  passwordInputField('새 비밀번호 확인'),
                  SizedBox(height: 30,),
                  ElevatedButton(
                    onPressed: () {
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF2E9629), // 초록색 배경
                      minimumSize: Size(350, 50), // 버튼의 최소 크기 (너비, 높이)
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15), // 둥근 모서리
                      ),
                    ),
                    child: Text(
                      '변경', // 버튼 텍스트
                      style: TextStyle(
                        color: Colors.white, // 텍스트 색상
                        fontSize: 18, // 텍스트 크기
                        fontWeight: FontWeight.w600, // 텍스트 두께
                        fontFamily: 'NanumGothic', // 글꼴
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget passwordInputField(String labelText) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        labelText,
        style: TextStyle(
          color: Colors.black,
          fontSize: 14,
          fontFamily: 'NanumGothic',
          fontWeight: FontWeight.w800,
        ),
      ),
      SizedBox(height: 8),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 16), // 양옆 여백
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), // 둥근 모서리
          color: Color(0xFFD9D9D9), // 배경색
        ),
        child: TextField(
          decoration: InputDecoration(
            border: InputBorder.none, // 기본 입력 필드 테두리 제거
          ),
          obscureText: true, // 비밀번호 입력 시 텍스트 숨기기
          style: TextStyle(
            fontSize: 16,
            fontFamily: 'NanumGothic',
          ),
        ),
      ),
      SizedBox(height: 40)
    ],
  );
}