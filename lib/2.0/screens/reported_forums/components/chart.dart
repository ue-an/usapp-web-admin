import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:web_tut/models/report.dart';
import 'package:web_tut/models/student.dart';
import 'package:web_tut/models/thread.dart';

import '../../../constants.dart';

class Chart extends StatelessWidget {
  List<Thread> streamedForums;
  int totalThreads;
  List<Thread> ccsForums;
  List<Thread> cobForums;
  List<Thread> coaForums;
  Chart({
    Key key,
    this.totalThreads,
    this.streamedForums,
    this.ccsForums,
    this.coaForums,
    this.cobForums,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  value: double.parse(coaForums.length.toString()),
                  // value: 20,
                  showTitle: false,
                  radius: 25,
                ),
                PieChartSectionData(
                  color: const Color(0xFF26E5FF),
                  value: double.parse(cobForums.length.toString()),
                  // value: 20,
                  showTitle: false,
                  radius: 22,
                ),
                PieChartSectionData(
                  color: const Color(0xFFFFCF26),
                  value: double.parse(ccsForums.length.toString()),
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
                  totalThreads.toString(),
                  style: Theme.of(context).textTheme.headline4.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        height: 0.5,
                      ),
                ),
                totalThreads > 1 ? const Text("Forums") : const Text("Forum"),
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
