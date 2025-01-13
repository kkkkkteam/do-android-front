import 'package:flutter/material.dart';
import '../../widgets/custom_back_app_bar.dart';
import '../../widgets/custom_textField.dart';
import '../../widgets/custom_button.dart';


class PostCreationPage extends StatefulWidget {
  @override
  _PostCreationPageState createState() => _PostCreationPageState();
}

class _PostCreationPageState extends State<PostCreationPage> {
  bool isAnonymous = false; // 체크박스 상태 변수
  String selectedBoard = '자유게시판'; // 선택된 게시판 기본값

  final List<String> boards = [
    '자유게시판',
    '비밀게시판',
    '음성1센터 게시판',
    '음성2센터 게시판',
    '용인백암센터 게시판',
    '남양주센터 게시판',
    '파주센터 게시판',
    '그로스팀 게시판',
    '사업기획팀 게시판',
    'CX팀 게시판',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomBackAppBar(title: '게시물 작성'), // BoardUploadAppBar 사용
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // DropdownButton
            SizedBox(height: 30,),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xFFAAAAAA), width: 1), // 연한 검은색 테두리
                borderRadius: BorderRadius.circular(10),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: selectedBoard,
                  items: boards
                      .map(
                        (board) => DropdownMenuItem<String>(
                      value: board,
                      child: Text(board),
                    ),
                  )
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedBoard = value!;
                    });
                  },
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'NanumGothic',
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            SizedBox(height: 12),
            // 제목 입력 필드
            CustomTextField(
              hintText: '제목',
              borderColor: Color(0xFFAAAAAA), // 테두리 색상 변경
              maxLines: 1,
            ),
            SizedBox(height: 12),
            // 내용 입력 필드
            CustomTextField(
              hintText: '내용을 입력하세요',
              borderColor: Color(0xFFAAAAAA), // 테두리 색상 변경
              maxLines: 10,
            ),
            SizedBox(height: 60),
            // 업로드 버튼
            Center(
              child: CustomButton(text: '업로드', onPressed: (){
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('업로드가 완료되었습니다!')),
                );
                // 게시물 작성 후 게시판 화면으로 돌아가기
                Navigator.pop(context);
              },
                color: Color(0xFF2E9629),
            )),
          ]
        ),
      ),
    );
  }
}
