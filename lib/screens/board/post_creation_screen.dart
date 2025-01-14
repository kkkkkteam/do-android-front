import 'package:flutter/material.dart';
import '../../widgets/custom_back_app_bar.dart';
import '../../widgets/custom_textField.dart';
import '../../widgets/custom_button.dart';

class PostCreationScreen extends StatefulWidget {
  const PostCreationScreen({Key? key}) : super(key: key);

  @override
  _PostCreationScreenState createState() => _PostCreationScreenState();
}

class _PostCreationScreenState extends State<PostCreationScreen> {
  bool isAnonymous = false; // 체크박스 상태 변수
  String selectedBoard = '전체게시판'; // 선택된 게시판 기본값

  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  final List<String> boards = [
    '전체게시판',
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
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

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
            const SizedBox(height: 30),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFFAAAAAA), width: 1), // 연한 검은색 테두리
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white, // 배경색 설정
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: selectedBoard,
                      items: boards
                          .map(
                            (board) => DropdownMenuItem<String>(
                          value: board,
                          child: Container(
                            color: Colors.white, // 항목의 배경색
                            child: Text(board),
                          ),
                        ),
                      )
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedBoard = value!;
                        });
                      },
                      style: const TextStyle(
                        fontSize: 14,
                        fontFamily: 'NanumGothic',
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                      dropdownColor: Colors.white, // 드롭다운 메뉴 배경색
                    ),
                  ),
                ),
                Spacer(),
                Row(
                  children: [
                    Text(
                      '익명',
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'NanumGothic',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Transform.scale(
                      scale: 0.8,
                      child: Checkbox(
                        value: isAnonymous,
                        onChanged: (value) {
                          setState(() {
                            isAnonymous = value ?? false;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            // 제목 입력 필드
            CustomTextField(
              hintText: '제목',
              borderColor: const Color(0xFFAAAAAA), // 테두리 색상 변경
              maxLines: 1,
              controller: titleController,
            ),
            const SizedBox(height: 12),
            // 내용 입력 필드
            CustomTextField(
              hintText: '내용을 입력하세요',
              borderColor: const Color(0xFFAAAAAA), // 테두리 색상 변경
              maxLines: 10,
              controller: contentController,
            ),
            const SizedBox(height: 60),
            // 업로드 버튼
            Center(
              child: CustomButton(
                text: '업로드',
                onPressed: () {
                  final newPost = {
                    'title': titleController.text.trim(),
                    'content': contentController.text.trim(),
                    'author': isAnonymous ? '익명' : '작성자 이름',
                    'date': DateTime.now().toLocal().toString().split(' ')[0],
                  };

                  // 게시물 데이터 반환
                  Navigator.pop(context, newPost);

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('업로드가 완료되었습니다!')),
                  );
                },
                color: const Color(0xFF2E9629),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
