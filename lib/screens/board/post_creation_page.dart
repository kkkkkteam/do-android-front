import 'package:flutter/material.dart';
import '../../widgets/board_upload_app_bar.dart'; // BoardUploadAppBar 사용

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
      appBar: BoardUploadAppBar(title: '게시물 작성'), // BoardUploadAppBar 사용
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // DropdownButton
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
            TextField(
              decoration: InputDecoration(
                hintText: '제목',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Color(0xFFAAAAAA), width: 1), // 연한 검은색 테두리
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Color(0xFFAAAAAA), width: 1), // 비활성 테두리
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Color(0xFFAAAAAA), width: 1), // 활성화 테두리
                ),
              ),
            ),
            SizedBox(height: 12),
            // 내용 입력 필드
            TextField(
              maxLines: 8,
              decoration: InputDecoration(
                hintText: '내용을 입력하세요',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Color(0xFFAAAAAA), width: 1), // 연한 검은색 테두리
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Color(0xFFAAAAAA), width: 1), // 비활성 테두리
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Color(0xFFAAAAAA), width: 1), // 활성화 테두리
                ),
              ),
            ),
            SizedBox(height: 12),
            // 업로드 버튼
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // 게시물 작성 후 게시판 화면으로 돌아가기
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF2E9629),
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  '업로드',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'NanumGothic',
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
