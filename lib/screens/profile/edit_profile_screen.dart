import 'package:flutter/material.dart';
import '../../widgets/custom_button.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  String selectedGender = '남자'; // 현재 선택된 성별
  String selectedImage = 'assets/images/man-01.png'; // 현재 선택된 이미지

  // 남자와 여자 이미지 리스트
  final Map<String, List<String>> genderImageMap = {
    '남자': [
      'assets/images/man-01.png',
      'assets/images/man-02.png',
      'assets/images/man-03.png',
      'assets/images/man-05.png',
    ],
    '여자': [
      'assets/images/woman-01.png',
      'assets/images/woman-03.png',
      'assets/images/woman-04.png',
      'assets/images/woman-05.png',
    ],
  };

  void _showSnackBar(BuildContext context) {
    final snackBar = SnackBar(
      content: const Text(
        '프로필 사진이 변경되었습니다!',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      duration: const Duration(seconds: 3),
      backgroundColor: Colors.green,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    final imageList = genderImageMap[selectedGender]!;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context); // 뒤로 가기
          },
        ),
        title: const Text(
          '프로필 수정',
          style: TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontFamily: 'NanumGothic',
            fontWeight: FontWeight.w400,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 20, top: 20),
              child: Text(
                '프로필 사진',
                style: TextStyle(
                  fontFamily: 'Jua',
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20, right: 20, top: 5),
              child: Divider(
                thickness: 4,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ToggleButtons(
                isSelected: [selectedGender == '남자', selectedGender == '여자'],
                onPressed: (index) {
                  setState(() {
                    selectedGender = index == 0 ? '남자' : '여자';
                    selectedImage = genderImageMap[selectedGender]![0]; // 성별 변경 시 첫 이미지 선택
                  });
                },
                borderRadius: BorderRadius.circular(30),
                borderColor: Colors.green,
                selectedBorderColor: Colors.green,
                fillColor: Colors.green,
                selectedColor: Colors.white,
                color: Colors.green,
                constraints: const BoxConstraints(
                  minWidth: 100,
                  minHeight: 40,
                ),
                children: const [
                  Text(
                    '남자',
                    style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'RobotoBold'),
                  ),
                  Text(
                    '여자',
                    style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'RobotoBold'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(20),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                childAspectRatio: 1, // 정사각형 비율로 조정
              ),
              itemCount: imageList.length,
              itemBuilder: (context, index) {
                final imagePath = imageList[index];
                final isSelected = selectedImage == imagePath;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedImage = imagePath; // 선택된 이미지 업데이트
                    });
                  },
                  child: AspectRatio(
                    aspectRatio: 1, // 정사각형 유지
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: const Color(0xFFD9D9D9)),
                        color: isSelected ? Colors.grey[300] : Colors.white, // 선택 시 회색 배경
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          imagePath,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: CustomButton(
                  text: '변경',
                  color: Colors.green,
                  onPressed: () {
                    _showSnackBar(context); // SnackBar 표시
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
