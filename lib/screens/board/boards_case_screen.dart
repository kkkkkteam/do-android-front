import 'package:flutter/material.dart';
import '../../widgets/custom_back_app_bar.dart'; // BoardUploadAppBar import
import 'post_creation_page.dart'; // 게시물 작성 페이지 import
import '../../widgets/search_textField.dart';
import '../../widgets/custom_post.dart'; // PostCard import

class BoardsCaseScreen extends StatelessWidget {
  final String title;

  const BoardsCaseScreen({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomBackAppBar(title: title), // BoardUploadAppBar 사용
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 검색 창
              SearchTextField(hintText: '게시물의 제목 또는 작성자를 입력하세요'),
              const SizedBox(height: 20),

              // 게시물 리스트
              ...List.generate(
                5,
                    (index) => Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: InkWell(
                    onTap: () {
                      // 게시물 클릭 시 동작
                      print('게시물 $index 클릭');
                    },
                    child: PostCard(
                      title: '긴급상황: 이것은 제목입니다 $index',
                      content: '안녕하세요, 이것은 내용입니다. 감자튀김이 있어요...', // 수정된 매개변수 이름
                      author: '익명',
                      date: '2025.01.22',
                    ),

                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // + 버튼 클릭 시, PostCreationPage로 이동
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PostCreationPage()), // PostCreationPage로 화면 전환
          );
        },
        backgroundColor: const Color(0xFF2E9629),
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
