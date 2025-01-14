import 'package:flutter/material.dart';
import '../../widgets/custom_back_app_bar.dart';
import '../../widgets/home_container.dart';
import '../../widgets/color_progress_bar.dart';

class PerformanceEvaluationScreen extends StatelessWidget {
  const PerformanceEvaluationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomBackAppBar(title: '인사평가'),
      body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                CustomContainer(title: '2024 상반기 인사평가',
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(height: 30,),
                        Text('S', style: TextStyle(fontFamily: 'RubikScribble', color: Color(0xFF2E9529),fontSize: 140),),
                        Transform.translate(
                          offset: const Offset(-10, 20), // X축: 0, Y축: +1 (아래로 이동)
                          child: Text(
                            'rank',
                            style: const TextStyle(
                              fontFamily: 'RubikScribble',
                              color: Color(0xFF2E9529),
                              fontSize: 70,
                            ),
                          ),
                        ),
                        Text('6,500do를 \n얻었어요',style: TextStyle(fontFamily: 'Dohyeon', fontSize: 18),)
                      ],
                    )
                ),
                SizedBox(height: 50,),
                CustomContainer(title: '2024 하반기 인사평가',
                    child: Container(
                      height: 150,
                      child: Center(
                        child: Text('아직 하반기가 마무리 되지 않았어요!', style: TextStyle(fontFamily: 'Dohyeon', fontSize: 18),),
                      ))),
                SizedBox(height: 50,),
                CustomExperienceBar(title: '2024 종합 경험치',
                  firstValue: 6500,
                  secondValue: 1280,
                  thirdValue: 1280,
                  fourthValue: 800,),
                SizedBox(height: 50,),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: const Color(0xFFB4B4B4), width: 1.5),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.only(top: 12),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // 제목
                      Transform.translate(
                        offset: const Offset(0, 5), // X축: 0, Y축: +1 (아래로 1픽셀 이동)
                        child: const Text(
                          '인사평가',
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Dohyeon',
                          ),
                        ),
                      ),
                      Transform.translate(
                        offset: const Offset(0, 10), // X축: 0, Y축: +1 (아래로 1픽셀 이동)
                        child: const Divider(
                          color: Color(0xFFB4B4B4),
                          thickness: 1.35,
                          height: 20,
                        ),
                      ),
                      Table(
                        border: TableBorder.symmetric(
                          inside: BorderSide(color: const Color(0xFFB4B4B4), width: 1.2),
                        ),
                        columnWidths: const {
                          0: FlexColumnWidth(1),
                          1: FlexColumnWidth(1),
                        },
                        children: [
                          for (var row in [
                            ['S', '6,500'],
                            ['A', '4,500'],
                            ['B', '3,000'],
                            ['C', '1,500'],
                            ['D', '0'],
                          ])
                            TableRow(
                              children: row.map((cell) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 12), // 위아래 간격 추가
                                  child: Center(
                                    child: Text(
                                      cell,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'NanumGothic',
                                        fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30,)
              ],
            ),
          )), // 빈 화면
    );
  }
}
