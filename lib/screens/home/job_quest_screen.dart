import 'package:flutter/material.dart';
import '../../widgets/custom_back_app_bar.dart';
import '../../widgets/home_container.dart';
import '../../widgets/productivity_progress_bar.dart';

class JobQuestScreen extends StatelessWidget {
  const JobQuestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomBackAppBar(title: '직무 퀘스트'),
      body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                CustomContainer(title: '월별 퀘스트 (1월)',
                    child: Column(
                      children: [
                        SizedBox(height: 20,),
                        Container(
                          width: double.infinity, // 가로는 화면을 꽉 채움
                          child: Column(
                            mainAxisSize: MainAxisSize.min, // 높이를 자식의 크기에 따라 조정
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              Text(
                                '공부 열심히 하기',
                                style: TextStyle(fontFamily: 'Dohyeon', fontSize: 25),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20,)
                      ],
                    )
                ),
                SizedBox(height: 50,),
                CustomContainer(title: '2024 하반기 인사평가',
                    child: Column(
                      children: [
                        SizedBox(height: 20,),
                        Container(
                          width: double.infinity, // 가로는 화면을 꽉 채움
                          child: Column(
                            mainAxisSize: MainAxisSize.min, // 높이를 자식의 크기에 따라 조정
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              Text(
                                '공부 열심히 하기',
                                style: TextStyle(fontFamily: 'Dohyeon', fontSize: 25),
                              ),
                              Text(
                                '공부 열심히 구라임',
                                style: TextStyle(fontFamily: 'Dohyeon', fontSize: 25),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20,)
                      ],
                    )
                ),
                SizedBox(height: 50,),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Color(0xFFB4B4B4), width: 1.5),
                  ),
                  child: Table(
                    border: TableBorder(
                      horizontalInside: BorderSide(
                        color: Color(0xFFB4B4B4),
                        width: 1.25,
                      ),
                      verticalInside: BorderSide(
                        color: Color(0xFFB4B4B4),
                        width: 1.25,
                      ),
                    ),
                    columnWidths: const {
                      0: FlexColumnWidth(1), // 첫 번째 열
                      1: FlexColumnWidth(1), // 두 번째 열
                    },
                    children: [
                      // 상단 헤더
                      TableRow(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12), // 위아래 간격 추가
                            child: Center(
                              child: Text(
                                'MAX 점수',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Dohyeon',
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12), // 위아래 간격 추가
                            child: Center(
                              child: Text(
                                'MEDIUM 점수',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Dohyeon',
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      // 점수 데이터
                      TableRow(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12), // 위아래 간격 추가
                            child: Center(
                              child: Text(
                                '80',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'NanumGothic',
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12), // 위아래 간격 추가
                            child: Center(
                              child: Text(
                                '40',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'NanumGothic',
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30,),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Color(0xFFB4B4B4), width: 1.5),
                  ),
                  child: Table(
                    border: TableBorder(
                      horizontalInside: BorderSide(
                        color: Color(0xFFB4B4B4),
                        width: 1.25,
                      ),
                      verticalInside: BorderSide(
                        color: Color(0xFFB4B4B4),
                        width: 1.25,
                      ),
                    ),
                    columnWidths: const {
                      0: FlexColumnWidth(1), // 첫 번째 열
                      1: FlexColumnWidth(1), // 두 번째 열
                    },
                    children: [
                      // 상단 헤더
                      TableRow(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12), // 위아래 간격 추가
                            child: Center(
                              child: Text(
                                'MAX 기준',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Dohyeon',
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12), // 위아래 간격 추가
                            child: Center(
                              child: Text(
                                'MEDIUM 기준',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Dohyeon',
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      // 점수 데이터
                      TableRow(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12), // 위아래 간격 추가
                            child: Center(
                              child: Text(
                                '5.1',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'NanumGothic',
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12), // 위아래 간격 추가
                            child: Center(
                              child: Text(
                                '4.3',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'NanumGothic',
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 50,),
                CustomProgressBar(title:'32주차',currentValue: 4.713),
                SizedBox(height: 50,),
                CustomContainer(title: '현재까지 직무 퀘스트로 얻은 do',
                    child: Container(
                        height: 100,
                        child: Center(
                          child: Text('1,280', style: TextStyle(fontFamily: 'Dohyeon', fontSize: 25),),
                        ))),
                SizedBox(height: 50,)
              ],
            ),
          )), // 빈 화면
    );
  }
}
