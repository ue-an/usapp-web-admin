import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class _BarChart extends StatefulWidget {
  const _BarChart({Key key}) : super(key: key);

  @override
  State<_BarChart> createState() => _BarChartState();
}

class _BarChartState extends State<_BarChart> {
  @override
  void initState() {
    super.initState();
    //=== BSOA ===
    //1st year
    totalA11 = 0;
    totalA12 = 0;
    totalA13 = 0;
    totalA14 = 0;
    // fetchA11();
    // fetchA12();
    // fetchA13();
    // fetchA14();
    //2nd year
    totalA21 = 0;
    totalA22 = 0;
    totalA23 = 0;
    totalA24 = 0;
    // fetchA21();
    // fetchA22();
    // fetchA23();
    // fetchA24();
    //3rd year
    totalA31 = 0;
    totalA32 = 0;
    totalA33 = 0;
    totalA34 = 0;
    // fetchA31();
    // fetchA32();
    // fetchA33();
    // fetchA34();
    //4th year
    totalA41 = 0;
    totalA42 = 0;
    totalA43 = 0;
    totalA44 = 0;
    // fetchA41();
    // fetchA42();
    // fetchA43();
    // fetchA44();
  }

  //=== total ===
  double total;
  //=== end ===

  double totalA11;
  double totalA12;
  double totalA13;
  double totalA14;
  double totalA21;
  double totalA22;
  double totalA23;
  double totalA24;
  double totalA31;
  double totalA32;
  double totalA33;
  double totalA34;
  double totalA41;
  double totalA42;
  double totalA43;
  double totalA44;

  //========= Fetch BSIT =========
//========= 1st =========
//   fetchA11() async {
//     QuerySnapshot a11 = await FirebaseFirestore.instance
//         .collection('students')
//         .where('year_and_section', isEqualTo: 'A 1-1')
//         .get();
//     setState(() {
//       totalA11 = a11.docs.length.toDouble();
//     });
//   }

//   fetchA12() async {
//     QuerySnapshot a12 = await FirebaseFirestore.instance
//         .collection('students')
//         .where('year_and_section', isEqualTo: 'A 1-2')
//         .get();
//     setState(() {
//       totalA12 = a12.docs.length.toDouble();
//     });
//   }

//   fetchA13() async {
//     QuerySnapshot a13 = await FirebaseFirestore.instance
//         .collection('students')
//         .where('year_and_section', isEqualTo: 'A 1-3')
//         .get();
//     setState(() {
//       totalA13 = a13.docs.length.toDouble();
//     });
//   }

//   fetchA14() async {
//     QuerySnapshot a14 = await FirebaseFirestore.instance
//         .collection('students')
//         .where('year_and_section', isEqualTo: 'A 1-4')
//         .get();
//     setState(() {
//       totalA14 = a14.docs.length.toDouble();
//     });
//   }

// //========= 2nd =========
//   fetchA21() async {
//     QuerySnapshot a21 = await FirebaseFirestore.instance
//         .collection('students')
//         .where('year_and_section', isEqualTo: 'A 2-1')
//         .get();
//     setState(() {
//       totalA21 = a21.docs.length.toDouble();
//     });
//   }

//   fetchA22() async {
//     QuerySnapshot a22 = await FirebaseFirestore.instance
//         .collection('students')
//         .where('year_and_section', isEqualTo: 'A 2-2')
//         .get();
//     setState(() {
//       totalA22 = a22.docs.length.toDouble();
//     });
//   }

//   fetchA23() async {
//     QuerySnapshot a23 = await FirebaseFirestore.instance
//         .collection('students')
//         .where('year_and_section', isEqualTo: 'A 2-3')
//         .get();
//     setState(() {
//       totalA23 = a23.docs.length.toDouble();
//     });
//   }

//   fetchA24() async {
//     QuerySnapshot a24 = await FirebaseFirestore.instance
//         .collection('students')
//         .where('year_and_section', isEqualTo: 'A 2-4')
//         .get();
//     setState(() {
//       totalA24 = a24.docs.length.toDouble();
//     });
//   }

// //========= 3rd =========
//   fetchA31() async {
//     QuerySnapshot a31 = await FirebaseFirestore.instance
//         .collection('students')
//         .where('year_and_section', isEqualTo: 'A 3-1')
//         .get();
//     setState(() {
//       totalA31 = a31.docs.length.toDouble();
//     });
//   }

//   fetchA32() async {
//     QuerySnapshot a32 = await FirebaseFirestore.instance
//         .collection('students')
//         .where('year_and_section', isEqualTo: 'A 3-2')
//         .get();
//     setState(() {
//       totalA32 = a32.docs.length.toDouble();
//     });
//   }

//   fetchA33() async {
//     QuerySnapshot a33 = await FirebaseFirestore.instance
//         .collection('students')
//         .where('year_and_section', isEqualTo: 'A 3-3')
//         .get();
//     setState(() {
//       totalA33 = a33.docs.length.toDouble();
//     });
//   }

//   fetchA34() async {
//     QuerySnapshot a34 = await FirebaseFirestore.instance
//         .collection('students')
//         .where('year_and_section', isEqualTo: 'A 3-4')
//         .get();
//     setState(() {
//       totalA34 = a34.docs.length.toDouble();
//     });
//   }

// //========= 4th =========
//   fetchA41() async {
//     QuerySnapshot a41 = await FirebaseFirestore.instance
//         .collection('students')
//         .where('year_and_section', isEqualTo: 'A 4-1')
//         .get();
//     setState(() {
//       totalA41 = a41.docs.length.toDouble();
//     });
//   }

//   fetchA42() async {
//     QuerySnapshot a42 = await FirebaseFirestore.instance
//         .collection('students')
//         .where('year_and_section', isEqualTo: 'A 4-2')
//         .get();
//     setState(() {
//       totalA42 = a42.docs.length.toDouble();
//     });
//   }

//   fetchA43() async {
//     QuerySnapshot a43 = await FirebaseFirestore.instance
//         .collection('students')
//         .where('year_and_section', isEqualTo: 'A 4-3')
//         .get();
//     setState(() {
//       totalA43 = a43.docs.length.toDouble();
//     });
//   }

//   fetchA44() async {
//     QuerySnapshot a44 = await FirebaseFirestore.instance
//         .collection('students')
//         .where('year_and_section', isEqualTo: 'A 4-4')
//         .get();
//     setState(() {
//       totalA44 = a44.docs.length.toDouble();
//     });
//   }

//========= end =========

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
          barTouchData: barTouchData,
          titlesData: titlesData,
          borderData: borderData,
          barGroups: barGroups,
          alignment: BarChartAlignment.spaceAround,
          maxY: total),
    );
  }

  BarTouchData get barTouchData => BarTouchData(
        enabled: false,
        touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: Colors.transparent,
          tooltipPadding: const EdgeInsets.all(0),
          tooltipMargin: 8,
          getTooltipItem: (
            BarChartGroupData group,
            int groupIndex,
            BarChartRodData rod,
            int rodIndex,
          ) {
            return BarTooltipItem(
              rod.y.round().toString(),
              const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      );

  FlTitlesData get titlesData => FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          getTextStyles: (context, value) => const TextStyle(
            color: Color(0xff7589a2),
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          margin: 20,
          getTitles: (double value) {
            switch (value.toInt()) {
              case 0:
                return 'A 1-1';
              case 1:
                return 'A 1-2';
              case 2:
                return 'A 1-3';
              case 3:
                return 'A 1-4';
              case 4:
                return 'A 2-1';
              case 5:
                return 'A 2-2';
              case 6:
                return 'A 2-3';
              case 7:
                return 'A 2-4';
              case 8:
                return 'A 3-1';
              case 9:
                return 'A 3-2';
              case 10:
                return 'A 3-3';
              case 11:
                return 'A 3-4';
              case 12:
                return 'A 4-1';
              case 13:
                return 'A 4-2';
              case 14:
                return 'A 4-3';
              case 15:
                return 'A 4-4';
              default:
                return '';
            }
          },
        ),
        leftTitles: SideTitles(showTitles: false),
        topTitles: SideTitles(showTitles: false),
        rightTitles: SideTitles(showTitles: false),
      );

  FlBorderData get borderData => FlBorderData(
        show: false,
      );

  List<BarChartGroupData> get barGroups => [
        //========= BSIT =========
        //========= 1st year =========
        BarChartGroupData(
          x: 0,
          barRods: [
            BarChartRodData(
              y: totalA11,
              colors: [Colors.lightBlueAccent, Colors.greenAccent],
            ),
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 1,
          barRods: [
            BarChartRodData(
              y: totalA12,
              // y: 12,
              colors: [Colors.lightBlueAccent, Colors.greenAccent],
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 2,
          barRods: [
            BarChartRodData(
                y: totalA13,
                colors: [Colors.lightBlueAccent, Colors.greenAccent])
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 3,
          barRods: [
            BarChartRodData(
                y: totalA14,
                colors: [Colors.lightBlueAccent, Colors.greenAccent])
          ],
          showingTooltipIndicators: [0],
        ),
        //========= 2nd year =========
        BarChartGroupData(
          x: 4,
          barRods: [
            BarChartRodData(
              y: totalA21,
              colors: [Colors.lightBlueAccent, Colors.greenAccent],
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 5,
          barRods: [
            BarChartRodData(
              y: totalA22,
              colors: [Colors.lightBlueAccent, Colors.greenAccent],
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 6,
          barRods: [
            BarChartRodData(
              y: totalA23,
              colors: [Colors.lightBlueAccent, Colors.greenAccent],
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 7,
          barRods: [
            BarChartRodData(
              y: totalA24,
              colors: [Colors.lightBlueAccent, Colors.greenAccent],
            )
          ],
          showingTooltipIndicators: [0],
        ),
        //========= 3rd year =========
        BarChartGroupData(
          x: 8,
          barRods: [
            BarChartRodData(
              y: totalA31,
              colors: [Colors.lightBlueAccent, Colors.greenAccent],
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 9,
          barRods: [
            BarChartRodData(
              y: totalA32,
              colors: [Colors.lightBlueAccent, Colors.greenAccent],
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 10,
          barRods: [
            BarChartRodData(
              y: totalA33,
              colors: [Colors.lightBlueAccent, Colors.greenAccent],
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 11,
          barRods: [
            BarChartRodData(
              y: totalA34,
              colors: [Colors.lightBlueAccent, Colors.greenAccent],
            )
          ],
          showingTooltipIndicators: [0],
        ),
        //========= 4th year =========
        BarChartGroupData(
          x: 12,
          barRods: [
            BarChartRodData(
              y: totalA41,
              colors: [Colors.lightBlueAccent, Colors.greenAccent],
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 13,
          barRods: [
            BarChartRodData(
              y: totalA42,
              colors: [Colors.lightBlueAccent, Colors.greenAccent],
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 14,
          barRods: [
            BarChartRodData(
              y: totalA43,
              colors: [Colors.lightBlueAccent, Colors.greenAccent],
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 15,
          barRods: [
            BarChartRodData(
              y: totalA44,
              colors: [Colors.lightBlueAccent, Colors.greenAccent],
            )
          ],
          showingTooltipIndicators: [0],
        ),
      ];
}

class BarBsa extends StatefulWidget {
  const BarBsa({Key key}) : super(key: key);

  @override
  _BarBsaState createState() => _BarBsaState();
}

class _BarBsaState extends State<BarBsa> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
