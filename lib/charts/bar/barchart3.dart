// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';
// import 'package:web_tut/providers/pie_provider.dart';
// import 'package:web_tut/services/firestore_service.dart';

// class _BarChart extends StatelessWidget {
//   PieProvider pieProvider;
//   double totalStudents;
//   _BarChart({Key key, this.totalStudents, this.pieProvider}) : super(key: key);

//   final PieProvider _pieProvider = PieProvider();

//   double totalIT11;
//   double totalIT12;
//   double totalIT13;
//   double totalIT14;
//   //
//   double totalIT21;
//   double totalIT22;
//   double totalIT23;
//   double totalIT24;
//   //
//   double totalIT31;
//   double totalIT32;
//   double totalIT33;
//   double totalIT34;
//   //
//   double totalIT41;
//   double totalIT42;
//   double totalIT43;
//   double totalIT44;

//   @override
//   Widget build(BuildContext context) {
//     return BarChart(
//       BarChartData(
//           titlesData: titlesData,
//           borderData: borderData,
//           barGroups: barGroups,
//           alignment: BarChartAlignment.spaceAround,
//           maxY: totalStudents),
//     );
//     // return FutureBuilder(
//     //     future: pieProvider,
//     //     builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//     //       if (snapshot.hasError) {
//     //         return Center(
//     //           child: Text('Error: ${snapshot.error}'),
//     //         );
//     //       }
//     //       if (snapshot.hasData) {
//     //         return BarChart(
//     //           BarChartData(
//     //               titlesData: titlesData,
//     //               borderData: borderData,
//     //               barGroups: barGroups,
//     //               alignment: BarChartAlignment.spaceAround,
//     //               maxY: snapshot.data.size.toDouble()),
//     //         );
//     //       }
//     //       return const Center(
//     //         child: CircularProgressIndicator(),
//     //       );
//     //     });
//     //====================
//     // studentsTotal = double.parse(_service.fetchTotalStudents().toString());
//     // return BarChart(
//     //   BarChartData(
//     //       titlesData: titlesData,
//     //       borderData: borderData,
//     //       barGroups: barGroups,
//     //       alignment: BarChartAlignment.spaceAround,
//     //       maxY: 10),
//     // );
//   }

//   FlTitlesData get titlesData => FlTitlesData(
//         show: true,
//         bottomTitles: SideTitles(
//           showTitles: true,
//           getTextStyles: (context, value) => const TextStyle(
//             color: Color(0xff7589a2),
//             fontWeight: FontWeight.bold,
//             fontSize: 14,
//           ),
//           margin: 20,
//           getTitles: (double value) {
//             switch (value.toInt()) {
//               case 0:
//                 return 'IT 1-1';
//               case 1:
//                 return 'IT 1-2';
//               case 2:
//                 return 'IT 1-3';
//               case 3:
//                 return 'IT 1-4';
//               case 4:
//                 return 'IT 2-1';
//               case 5:
//                 return 'IT 2-2';
//               case 6:
//                 return 'IT 2-3';
//               case 7:
//                 return 'IT 2-4';
//               case 8:
//                 return 'IT 3-1';
//               case 9:
//                 return 'IT 3-2';
//               case 10:
//                 return 'IT 3-3';
//               case 11:
//                 return 'IT 3-4';
//               case 12:
//                 return 'IT 4-1';
//               case 13:
//                 return 'IT 4-2';
//               case 14:
//                 return 'IT 4-3';
//               case 15:
//                 return 'IT 4-4';
//               default:
//                 return '';
//             }
//           },
//         ),
//         leftTitles: SideTitles(showTitles: false),
//         topTitles: SideTitles(showTitles: false),
//         rightTitles: SideTitles(showTitles: false),
//       );

//   FlBorderData get borderData => FlBorderData(
//         show: false,
//       );

//   List<BarChartGroupData> get barGroups {
//     //=== 1st year
//     totalIT11 = pieProvider.totalIT11;
//     totalIT12 = pieProvider.totalIT12;
//     totalIT13 = pieProvider.totalIT13;
//     totalIT14 = pieProvider.totalIT14;
//     //=== 2nd year
//     totalIT21 = pieProvider.totalIT21;
//     totalIT22 = pieProvider.totalIT22;
//     totalIT23 = pieProvider.totalIT23;
//     totalIT24 = pieProvider.totalIT24;
//     //=== 3rd year
//     totalIT31 = pieProvider.totalIT31;
//     totalIT32 = pieProvider.totalIT32;
//     totalIT33 = pieProvider.totalIT33;
//     totalIT34 = pieProvider.totalIT34;
//     //=== 4th year
//     totalIT41 = pieProvider.totalIT41;
//     totalIT42 = pieProvider.totalIT42;
//     totalIT43 = pieProvider.totalIT43;
//     totalIT44 = pieProvider.totalIT44;

//     return [
//       //========= BSIT =========
//       //========= 1st year =========
//       BarChartGroupData(
//         x: 0,
//         barRods: [
//           BarChartRodData(
//             y: totalIT11,
//             colors: [Colors.lightBlueAccent, Colors.greenAccent],
//           ),
//         ],
//         showingTooltipIndicators: [0],
//       ),
//       BarChartGroupData(
//         x: 1,
//         barRods: [
//           BarChartRodData(
//             y: totalIT12,
//             // y: 12,
//             colors: [Colors.lightBlueAccent, Colors.greenAccent],
//           )
//         ],
//         showingTooltipIndicators: [0],
//       ),
//       BarChartGroupData(
//         x: 2,
//         barRods: [
//           BarChartRodData(
//               y: totalIT13,
//               colors: [Colors.lightBlueAccent, Colors.greenAccent])
//         ],
//         showingTooltipIndicators: [0],
//       ),
//       BarChartGroupData(
//         x: 3,
//         barRods: [
//           BarChartRodData(
//               y: totalIT14,
//               colors: [Colors.lightBlueAccent, Colors.greenAccent])
//         ],
//         showingTooltipIndicators: [0],
//       ),
//       // ========= 2nd year =========
//       BarChartGroupData(
//         x: 4,
//         barRods: [
//           BarChartRodData(
//             y: totalIT21,
//             colors: [Colors.lightBlueAccent, Colors.greenAccent],
//           )
//         ],
//         showingTooltipIndicators: [0],
//       ),
//       BarChartGroupData(
//         x: 5,
//         barRods: [
//           BarChartRodData(
//             y: totalIT22,
//             colors: [Colors.lightBlueAccent, Colors.greenAccent],
//           )
//         ],
//         showingTooltipIndicators: [0],
//       ),
//       BarChartGroupData(
//         x: 6,
//         barRods: [
//           BarChartRodData(
//             y: totalIT23,
//             colors: [Colors.lightBlueAccent, Colors.greenAccent],
//           )
//         ],
//         showingTooltipIndicators: [0],
//       ),
//       BarChartGroupData(
//         x: 7,
//         barRods: [
//           BarChartRodData(
//             y: totalIT24,
//             colors: [Colors.lightBlueAccent, Colors.greenAccent],
//           )
//         ],
//         showingTooltipIndicators: [0],
//       ),
//       //========= 3rd year =========
//       BarChartGroupData(
//         x: 8,
//         barRods: [
//           BarChartRodData(
//             y: totalIT31,
//             colors: [Colors.lightBlueAccent, Colors.greenAccent],
//           )
//         ],
//         showingTooltipIndicators: [0],
//       ),
//       BarChartGroupData(
//         x: 9,
//         barRods: [
//           BarChartRodData(
//             y: totalIT32,
//             colors: [Colors.lightBlueAccent, Colors.greenAccent],
//           )
//         ],
//         showingTooltipIndicators: [0],
//       ),
//       BarChartGroupData(
//         x: 10,
//         barRods: [
//           BarChartRodData(
//             y: totalIT33,
//             colors: [Colors.lightBlueAccent, Colors.greenAccent],
//           )
//         ],
//         showingTooltipIndicators: [0],
//       ),
//       BarChartGroupData(
//         x: 11,
//         barRods: [
//           BarChartRodData(
//             y: totalIT34,
//             colors: [Colors.lightBlueAccent, Colors.greenAccent],
//           )
//         ],
//         showingTooltipIndicators: [0],
//       ),
//       // ========= 4th year =========
//       BarChartGroupData(
//         x: 12,
//         barRods: [
//           BarChartRodData(
//             y: totalIT41,
//             colors: [Colors.lightBlueAccent, Colors.greenAccent],
//           )
//         ],
//         showingTooltipIndicators: [0],
//       ),
//       BarChartGroupData(
//         x: 13,
//         barRods: [
//           BarChartRodData(
//             y: totalIT42,
//             colors: [Colors.lightBlueAccent, Colors.greenAccent],
//           )
//         ],
//         showingTooltipIndicators: [0],
//       ),
//       BarChartGroupData(
//         x: 14,
//         barRods: [
//           BarChartRodData(
//             y: totalIT43,
//             colors: [Colors.lightBlueAccent, Colors.greenAccent],
//           )
//         ],
//         showingTooltipIndicators: [0],
//       ),
//       BarChartGroupData(
//         x: 15,
//         barRods: [
//           BarChartRodData(
//             y: totalIT44,
//             colors: [Colors.lightBlueAccent, Colors.greenAccent],
//           )
//         ],
//         showingTooltipIndicators: [0],
//       ),
//     ];
//   }
// }

// class BarChartSample3 extends StatelessWidget {
//   PieProvider pieProvider;
//   BarChartSample3({Key key, this.pieProvider}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//         future: pieProvider.getTotalCourses(),
//         builder: (BuildContext conext, snapshot) {
//           if (snapshot.hasError) {
//             return Text('Error: ${snapshot.error}');
//           }
//           if (snapshot.hasData) {
//             var totalStudents = pieProvider.totalStudents;
//             return Column(
//               children: [
//                 Container(
//                   color: const Color(0xff2c4260).withOpacity(0.8),
//                   height: MediaQuery.of(context).size.height / 2.6,
//                   width: MediaQuery.of(context).size.width / 2.4,
//                   child: Card(
//                     elevation: 0,
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(4)),
//                     color: const Color(0xff2c4260).withOpacity(0.8),
//                     child: _BarChart(
//                       totalStudents: totalStudents,
//                       pieProvider: pieProvider,
//                     ),
//                   ),
//                 ),
//               ],
//             );
//           }
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Container(
//               height: MediaQuery.of(context).size.height / 2.1,
//               width: MediaQuery.of(context).size.width / 2.5,
//               color: Colors.transparent,
//             );
//           } else {
//             return const Center(
//               child: Text('Waiting'),
//             );
//           }
//         });
//   }
// }
