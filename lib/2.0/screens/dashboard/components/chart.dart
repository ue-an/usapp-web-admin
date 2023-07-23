import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:web_tut/models/student.dart';

import '../../../constants.dart';

class Chart extends StatelessWidget {
  List<Student> streamedStudents;
  int totalUsers;
  Chart({
    Key key,
    this.totalUsers,
    this.streamedStudents,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Student> ccsStudents = [];
    List<Student> cobStudents = [];
    List<Student> coaStudents = [];
    for (var student in streamedStudents) {
      if (student.college == 'CCS') {
        ccsStudents.add(student);
      }
      if (student.college == 'COA') {
        coaStudents.add(student);
      }
      if (student.college == 'COB') {
        cobStudents.add(student);
      }
    }
    return SizedBox(
      height: 200,
      child: Stack(
        children: [
          PieChart(
            PieChartData(
              sectionsSpace: 0,
              centerSpaceRadius: 70,
              startDegreeOffset: -90,
              sections: [
                PieChartSectionData(
                  color: primaryColor,
                  value: double.parse(coaStudents.length.toString()),
                  // value: 20,
                  showTitle: false,
                  radius: 25,
                ),
                PieChartSectionData(
                  color: Color(0xFF26E5FF),
                  value: double.parse(cobStudents.length.toString()),
                  // value: 20,
                  showTitle: false,
                  radius: 22,
                ),
                PieChartSectionData(
                  color: Color(0xFFFFCF26),
                  value: double.parse(ccsStudents.length.toString()),
                  // value: 20,
                  showTitle: false,
                  radius: 19,
                ),
              ],
            ),
          ),
          Positioned.fill(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: defaultPadding),
                Text(
                  totalUsers.toString(),
                  style: Theme.of(context).textTheme.headline4.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        height: 0.5,
                      ),
                ),
                const Text("Students")
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// List<PieChartSectionData> paiChartSelectionDatas = [
//   PieChartSectionData(
//     color: primaryColor,
//     value: 25,
//     showTitle: false,
//     radius: 25,
//   ),
//   PieChartSectionData(
//     color: Color(0xFF26E5FF),
//     value: 20,
//     showTitle: false,
//     radius: 22,
//   ),
//   PieChartSectionData(
//     color: Color(0xFFFFCF26),
//     value: 10,
//     showTitle: false,
//     radius: 19,
//   ),
//   PieChartSectionData(
//     color: Color(0xFFEE2727),
//     value: 15,
//     showTitle: false,
//     radius: 16,
//   ),
//   PieChartSectionData(
//     color: primaryColor.withOpacity(0.1),
//     value: 25,
//     showTitle: false,
//     radius: 13,
//   ),
// ];
