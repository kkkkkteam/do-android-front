import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../widgets/custom_title.dart';
import '../../widgets/custom_back_app_bar.dart';

class YearlyExperiencePage extends StatelessWidget {
  const YearlyExperiencePage({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> experienceData = const [
    {"year": "2021년", "experience": 2000},
    {"year": "2022년", "experience": 5000},
    {"year": "2023년", "experience": 6000},
    {"year": "2024년", "experience": 3000},
  ];

  int get totalExperience =>
      experienceData.fold(0, (sum, item) => sum + item["experience"] as int);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomBackAppBar(title: '연도별 경험치'),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomTitle(title: '경험치'),
                  const SizedBox(height: 5),
                  ...experienceData.map((data) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 7.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            data["year"],
                            style: const TextStyle(
                              fontSize: 14,
                              fontFamily: 'NanumGothic',
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            "${data["experience"]} do",
                            style: const TextStyle(
                              fontSize: 14,
                              fontFamily: 'NanumGothic',
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                  const Divider(color: Colors.grey),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "총경험치",
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'NanumGothic',
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        "$totalExperience do",
                        style: const TextStyle(
                          fontSize: 14,
                          fontFamily: 'NanumGothic',
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
          const Center(
            child: Text(
              "연도별 경험치 그래프",
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'NanumGothic',
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          Container(
            width: 400,
            height: 280, // 그래프 크기 조정
            padding: const EdgeInsets.all(16.0),
            child: LineChart(
              LineChartData(
                minY: 0,
                maxY: 7000,
                gridData: FlGridData(
                  show: true,
                  drawHorizontalLine: true,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: Colors.grey.shade300,
                      strokeWidth: 1,
                    );
                  },
                  drawVerticalLine: false,
                ),
                titlesData: FlTitlesData(
                  leftTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 40,
                    getTitles: (value) {
                      return value.toInt().toString();
                    },
                    interval: 1000,
                    margin: 8,
                  ),
                  bottomTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 32,
                    getTitles: (value) {
                      switch (value.toInt()) {
                        case 0:
                          return '2021년';
                        case 1:
                          return '2022년';
                        case 2:
                          return '2023년';
                        case 3:
                          return '2024년';
                        default:
                          return '';
                      }
                    },
                    margin: 8,
                  ),
                ),
                borderData: FlBorderData(
                  show: true,
                  border: Border.all(
                    color: Colors.grey.shade300,
                    width: 1,
                  ),
                ),
                lineBarsData: [
                  LineChartBarData(
                    spots: [
                      FlSpot(0, 2000),
                      FlSpot(1, 5000),
                      FlSpot(2, 6000),
                      FlSpot(3, 3000),
                    ],
                    isCurved: false,
                    barWidth: 2,
                    colors: [const Color(0xFF2E9528)], // 선 색상 변경
                    dotData: FlDotData(show: false),
                    belowBarData: BarAreaData(show: false),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
