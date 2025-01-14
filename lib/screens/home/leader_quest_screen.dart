import 'package:flutter/material.dart';
import '../../widgets/custom_back_app_bar.dart';
import '../../widgets/home_container.dart';
import '../../widgets/leader_progress_bar.dart';
import '../../widgets/quest_card.dart';

class LeaderQuestScreen extends StatelessWidget {
  const LeaderQuestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomBackAppBar(title: '리더부여 퀘스트'),
      body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(height: 10,),
                QuestCard(quest: '퀘스트 1 (1/1~2/1)',title: '업무 개선', weight: 40.toString(), experience: 800.toString(), description: '목적(why)-과정(how)-결과(what) 에 대한 정리본 필요', max: '업무 프로세스 개선 리드자', maxScore: 67, medium: '업무 프로세스 개선 참여자', mediumScore: 33),
                SizedBox(height: 50,),
                QuestCard(quest: '퀘스트 2 (1/13~2/12)',title: '월특근', weight: 60.toString(), experience: 1200.toString(),  max: '4회 이상', maxScore: 80, medium: '2회 이상', mediumScore: 40),
                SizedBox(height: 50,),
                CustomProgressBar(currentValue: 1280, title: '내가 현재까지 리더부여 퀘스트로 얻은 do'),
                SizedBox(height: 50,),
                CustomProgressBar(currentValue: 1504, title: '같은 센터의 다른 사원 평균'),
                SizedBox(height: 50,),
                CustomContainer(title: '현재까지 리더부여 퀘스트로 얻은 do',
                    child: Container(
                        height: 100,
                        child: Center(
                          child: Text('1280', style: TextStyle(fontFamily: 'Dohyeon', fontSize: 25),),
                        ))),
                SizedBox(height: 50,),
              ],
            ),
          )),
    );
  }
}
