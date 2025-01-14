import 'package:flutter/material.dart';
import '../../widgets/home_app_bar.dart';
import '../../widgets/home_toDoList.dart';
import '../../widgets/color_progress_bar.dart';
import '../../screens/home/performance_evaluation_screen.dart';
import '../../screens/home/job_quest_screen.dart';
import '../../screens/home/planning_project_screen.dart';
import '../../screens/home/leader_quest_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: '음성 1센터 - 그룹 1'),
      body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                CustomContainer(leftText: '인사평가', rightText: '6,500', contentList: ['상반기 - 6,500do', '하반기 - '],
                  onPressed: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PerformanceEvaluationScreen(),));
                  },),
                SizedBox(height: 30,),
                CustomContainer(leftText: '직무 퀘스트', rightText: '1,280', contentList: ['1월 - 열심히 공부하기', '1주차 - 열심히 공부하기'],
                  onPressed: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const JobQuestScreen(),));}),
                SizedBox(height: 30,),
                CustomContainer(leftText: '리더부여 퀘스트', rightText: '1,280', contentList: ['업무 개선', '월특근', '음오아예'],
                onPressed: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LeaderQuestScreen(),));
                }),
                SizedBox(height: 30,),
                CustomContainer(leftText: '전사 프로젝트', rightText: '800', contentList: ['고츄핑 프로젝트', '스텔라 프로젝트'],
                onPressed: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PlanningProjectScreen(),));
                }),
                SizedBox(height: 40,),
                CustomExperienceBar(title: '2024 종합 경험치',
                  firstValue: 6500,
                  secondValue: 1280,
                  thirdValue: 1280,
                  fourthValue: 800,),
                SizedBox(height: 30,),
                CustomExperienceBar(title: '2024 중위 평균 경험치',
                  firstValue: 6500,
                  secondValue: 1280,
                  thirdValue: 1280,
                  fourthValue: 800,)
                
              ],
            ),
          )), // 빈 화면
    );
  }
}
