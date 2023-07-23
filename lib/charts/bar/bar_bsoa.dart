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
    totalOA11 = 0;
    totalOA12 = 0;
    totalOA13 = 0;
    totalOA14 = 0;
    // fetchOA11();
    // fetchOA12();
    // fetchOA13();
    // fetchOA14();
    //2nd year
    totalOA21 = 0;
    totalOA22 = 0;
    totalOA23 = 0;
    totalOA24 = 0;
    // fetchOA21();
    // fetchOA22();
    // fetchOA23();
    // fetchOA24();
    //3rd year
    totalOA31 = 0;
    totalOA32 = 0;
    totalOA33 = 0;
    totalOA34 = 0;
    // fetchOA31();
    // fetchOA32();
    // fetchOA33();
    // fetchOA34();
    //4th year
    totalOA41 = 0;
    totalOA42 = 0;
    totalOA43 = 0;
    totalOA44 = 0;
    // fetchOA41();
    // fetchOA42();
    // fetchOA43();
    // fetchOA44();
  }

  //=== total ===
  double total;
  //=== end ===

  //=== OA ===
  //1st
  double totalOA11;
  double totalOA12;
  double totalOA13;
  double totalOA14;
  //2nd
  double totalOA21;
  double totalOA22;
  double totalOA23;
  double totalOA24;
  //3rd
  double totalOA31;
  double totalOA32;
  double totalOA33;
  double totalOA34;
  //4th
  double totalOA41;
  double totalOA42;
  double totalOA43;
  double totalOA44;
  //==== end ====

  fetchTotal() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('students')
        .orderBy('student_number')
        .get();
    total = snapshot.docs.length.toDouble();
  }

  //========= Fetch BSIT =========
//========= 1st =========
//   fetchOA11() async {
//     QuerySnapshot oa11 = await FirebaseFirestore.instance
//         .collection('students')
//         .where('year_and_section', isEqualTo: 'OA 1-1')
//         .get();
//     setState(() {
//       totalOA11 = oa11.docs.length.toDouble();
//     });
//   }

//   fetchOA12() async {
//     QuerySnapshot oa12 = await FirebaseFirestore.instance
//         .collection('students')
//         .where('year_and_section', isEqualTo: 'OA 1-2')
//         .get();
//     setState(() {
//       totalOA12 = oa12.docs.length.toDouble();
//     });
//   }

//   fetchOA13() async {
//     QuerySnapshot oa13 = await FirebaseFirestore.instance
//         .collection('students')
//         .where('year_and_section', isEqualTo: 'OA 1-3')
//         .get();
//     setState(() {
//       totalOA13 = oa13.docs.length.toDouble();
//     });
//   }

//   fetchOA14() async {
//     QuerySnapshot oa14 = await FirebaseFirestore.instance
//         .collection('students')
//         .where('year_and_section', isEqualTo: 'OA 1-4')
//         .get();
//     setState(() {
//       totalOA14 = oa14.docs.length.toDouble();
//     });
//   }

// //========= 2nd =========
//   fetchOA21() async {
//     QuerySnapshot oa21 = await FirebaseFirestore.instance
//         .collection('students')
//         .where('year_and_section', isEqualTo: 'OA 2-1')
//         .get();
//     setState(() {
//       totalOA21 = oa21.docs.length.toDouble();
//     });
//   }

//   fetchOA22() async {
//     QuerySnapshot oa22 = await FirebaseFirestore.instance
//         .collection('students')
//         .where('year_and_section', isEqualTo: 'OA 2-2')
//         .get();
//     setState(() {
//       totalOA22 = oa22.docs.length.toDouble();
//     });
//   }

//   fetchOA23() async {
//     QuerySnapshot oa23 = await FirebaseFirestore.instance
//         .collection('students')
//         .where('year_and_section', isEqualTo: 'OA 2-3')
//         .get();
//     setState(() {
//       totalOA23 = oa23.docs.length.toDouble();
//     });
//   }

//   fetchOA24() async {
//     QuerySnapshot oa24 = await FirebaseFirestore.instance
//         .collection('students')
//         .where('year_and_section', isEqualTo: 'OA 2-4')
//         .get();
//     setState(() {
//       totalOA24 = oa24.docs.length.toDouble();
//     });
//   }

// //========= 3rd =========
//   fetchOA31() async {
//     QuerySnapshot oa31 = await FirebaseFirestore.instance
//         .collection('students')
//         .where('year_and_section', isEqualTo: 'OA 3-1')
//         .get();
//     setState(() {
//       totalOA31 = oa31.docs.length.toDouble();
//     });
//   }

//   fetchOA32() async {
//     QuerySnapshot oa32 = await FirebaseFirestore.instance
//         .collection('students')
//         .where('year_and_section', isEqualTo: 'OA 3-2')
//         .get();
//     setState(() {
//       totalOA32 = oa32.docs.length.toDouble();
//     });
//   }

//   fetchOA33() async {
//     QuerySnapshot oa33 = await FirebaseFirestore.instance
//         .collection('students')
//         .where('year_and_section', isEqualTo: 'OA 3-3')
//         .get();
//     setState(() {
//       totalOA33 = oa33.docs.length.toDouble();
//     });
//   }

//   fetchOA34() async {
//     QuerySnapshot oa34 = await FirebaseFirestore.instance
//         .collection('students')
//         .where('year_and_section', isEqualTo: 'OA 3-4')
//         .get();
//     setState(() {
//       totalOA34 = oa34.docs.length.toDouble();
//     });
//   }

// //========= 4th =========
//   fetchOA41() async {
//     QuerySnapshot oa41 = await FirebaseFirestore.instance
//         .collection('students')
//         .where('year_and_section', isEqualTo: 'OA 4-1')
//         .get();
//     setState(() {
//       totalOA41 = oa41.docs.length.toDouble();
//     });
//   }

//   fetchOA42() async {
//     QuerySnapshot oa42 = await FirebaseFirestore.instance
//         .collection('students')
//         .where('year_and_section', isEqualTo: 'OA 4-2')
//         .get();
//     setState(() {
//       totalOA42 = oa42.docs.length.toDouble();
//     });
//   }

//   fetchOA43() async {
//     QuerySnapshot oa43 = await FirebaseFirestore.instance
//         .collection('students')
//         .where('year_and_section', isEqualTo: 'OA 4-3')
//         .get();
//     setState(() {
//       totalOA43 = oa43.docs.length.toDouble();
//     });
//   }

//   fetchOA44() async {
//     QuerySnapshot oa44 = await FirebaseFirestore.instance
//         .collection('students')
//         .where('year_and_section', isEqualTo: 'OA 4-4')
//         .get();
//     setState(() {
//       totalOA44 = oa44.docs.length.toDouble();
//     });
//   }

//========= end =========

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: fetchTotal(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          return BarChart(
            BarChartData(
                titlesData: titlesData,
                borderData: borderData,
                barGroups: barGroups,
                alignment: BarChartAlignment.spaceAround,
                maxY: total),
          );
        });
  }

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
                return 'OA 1-1';
              case 1:
                return 'OA 1-2';
              case 2:
                return 'OA 1-3';
              case 3:
                return 'OA 1-4';
              case 4:
                return 'OA 2-1';
              case 5:
                return 'OA 2-2';
              case 6:
                return 'OA 2-3';
              case 7:
                return 'OA 2-4';
              case 8:
                return 'OA 3-1';
              case 9:
                return 'OA 3-2';
              case 10:
                return 'OA 3-3';
              case 11:
                return 'OA 3-4';
              case 12:
                return 'OA 4-1';
              case 13:
                return 'OA 4-2';
              case 14:
                return 'OA 4-3';
              case 15:
                return 'OA 4-4';
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
              y: totalOA11,
              colors: [Colors.lightBlueAccent, Colors.greenAccent],
            ),
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 1,
          barRods: [
            BarChartRodData(
              y: totalOA12,
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
                y: totalOA13,
                colors: [Colors.lightBlueAccent, Colors.greenAccent])
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 3,
          barRods: [
            BarChartRodData(
                y: totalOA14,
                colors: [Colors.lightBlueAccent, Colors.greenAccent])
          ],
          showingTooltipIndicators: [0],
        ),
        //========= 2nd year =========
        BarChartGroupData(
          x: 4,
          barRods: [
            BarChartRodData(
              y: totalOA21,
              colors: [Colors.lightBlueAccent, Colors.greenAccent],
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 5,
          barRods: [
            BarChartRodData(
              y: totalOA22,
              colors: [Colors.lightBlueAccent, Colors.greenAccent],
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 6,
          barRods: [
            BarChartRodData(
              y: totalOA23,
              colors: [Colors.lightBlueAccent, Colors.greenAccent],
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 7,
          barRods: [
            BarChartRodData(
              y: totalOA24,
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
              y: totalOA31,
              colors: [Colors.lightBlueAccent, Colors.greenAccent],
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 9,
          barRods: [
            BarChartRodData(
              y: totalOA32,
              colors: [Colors.lightBlueAccent, Colors.greenAccent],
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 10,
          barRods: [
            BarChartRodData(
              y: totalOA33,
              colors: [Colors.lightBlueAccent, Colors.greenAccent],
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 11,
          barRods: [
            BarChartRodData(
              y: totalOA34,
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
              y: totalOA41,
              colors: [Colors.lightBlueAccent, Colors.greenAccent],
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 13,
          barRods: [
            BarChartRodData(
              y: totalOA42,
              colors: [Colors.lightBlueAccent, Colors.greenAccent],
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 14,
          barRods: [
            BarChartRodData(
              y: totalOA43,
              colors: [Colors.lightBlueAccent, Colors.greenAccent],
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 15,
          barRods: [
            BarChartRodData(
              y: totalOA44,
              colors: [Colors.lightBlueAccent, Colors.greenAccent],
            )
          ],
          showingTooltipIndicators: [0],
        ),
      ];
}

class BarBsoa extends StatefulWidget {
  const BarBsoa({Key key}) : super(key: key);

  @override
  _BarBsoaState createState() => _BarBsoaState();
}

class _BarBsoaState extends State<BarBsoa> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: const Color(0xff2c4260).withOpacity(0.8),
          height: MediaQuery.of(context).size.height / 2.6,
          width: MediaQuery.of(context).size.width / 2.4,
          child: Card(
            elevation: 0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            color: const Color(0xff2c4260).withOpacity(0.8),
            child: const _BarChart(),
          ),
        ),
      ],
    );
  }
}
