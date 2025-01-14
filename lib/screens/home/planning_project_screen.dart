import 'package:flutter/material.dart';
import '../../widgets/custom_back_app_bar.dart';
import '../../widgets/home_container.dart';
import '../../widgets/project_card.dart';

class PlanningProjectScreen extends StatelessWidget {
  const PlanningProjectScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomBackAppBar(title: '전사 프로젝트'),
      body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                ProjectCard(
                    title: '나의 프로젝트1 (1/12 ~ 3/12)',
                    projectName: '고츄핑', experience: 300.toString(),
                    description: '목적(why)-과정(how)-결과(what) 에 대한 정리본 필요',
                    participants: ['고경수']),
                SizedBox(height: 50,),
                ProjectCard(
                    title: '나의 프로젝트2 (1/12 ~ 3/12)',
                    projectName: '고츄핑',
                    experience: 500.toString(),
                    description: '목적(why)-과정(how)-결과(what) 에 대한 정리본 필요\n버터갈릭 감자튀김 구매 바람',
                    participants: ['고경수', '김서연', '박찬', '이동건', '장서인']),
                SizedBox(height: 50,),
                CustomContainer(title: '현재까지 전사 프로젝트로 얻은 do',
                    child: Container(
                        height: 100,
                        child: Center(
                          child: Text('800', style: TextStyle(fontFamily: 'Dohyeon', fontSize: 25),),
                        ))),
                SizedBox(height: 50,),
                ProjectCard(
                    title: '나의 과거 프로젝트1 (1/12 ~ 3/12)',
                    projectName: '고츄핑',
                    experience: 500.toString(),
                    description: '목적(why)-과정(how)-결과(what) 에 대한 정리본 필요\n버터갈릭 감자튀김 구매 바람',
                    participants: ['고경수', '김서연', '박찬', '이동건', '장서인']),
                SizedBox(height: 50,),
                ProjectCard(
                    title: '나의 과거 프로젝트2 (1/12 ~ 3/12)',
                    projectName: '고츄핑',
                    experience: 500.toString(),
                    description: '목적(why)-과정(how)-결과(what) 에 대한 정리본 필요\n버터갈릭 감자튀김 구매 바람',
                    participants: ['고경수', '김서연', '박찬', '이동건', '장서인']),
                SizedBox(height: 50,)
              ],
            ),
          )), // 빈 화면
    );
  }
}
