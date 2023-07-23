// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';
// import 'package:web_tut/charts/pie/piechart3.dart';
// import 'package:web_tut/providers/pie_provider.dart';
// import 'package:web_tut/services/firestore_service.dart';

// class PieCourses extends StatelessWidget {
//   PieProvider pieProvider;
//   PieCourses({Key key, this.pieProvider}) : super(key: key);

//   int touchedIndex = 0;

//   double totalBsit;
//   double totalBsis;
//   double totalBsoa;
//   double totalBsa;

//   List<PieChartSectionData> showingSections(int totalCourses) {
//     totalBsit = pieProvider.totalBsit;
//     totalBsis = pieProvider.totalBsis;
//     totalBsoa = pieProvider.totalBsoa;
//     totalBsa = pieProvider.totalBsa;
//     return List.generate(totalCourses, (i) {
//       final isTouched = i == touchedIndex;
//       final fontSize = isTouched ? 20.0 : 16.0;
//       final radius = isTouched ? 100.0 : 100.0;

//       switch (i) {
//         case 0:
//           return PieChartSectionData(
//             color: const Color(0xff0293ee),
//             value: totalBsoa,
//             // value: 10,
//             title: 'BSOA\n' + totalBsoa.toString(),
//             radius: radius,
//             titleStyle: TextStyle(
//                 fontSize: fontSize,
//                 fontWeight: FontWeight.bold,
//                 color: const Color(0xffffffff)),
//           );
//         case 1:
//           return PieChartSectionData(
//             color: const Color(0xfff8b250),
//             value: totalBsis,
//             // value: 10,
//             title: 'BSIS\n' + totalBsis.toString(),
//             radius: radius,
//             titleStyle: TextStyle(
//                 fontSize: fontSize,
//                 fontWeight: FontWeight.bold,
//                 color: const Color(0xffffffff)),
//           );
//         case 2:
//           return PieChartSectionData(
//             color: const Color(0xff845bef),
//             value: totalBsit,
//             title: 'BSIT\n' + totalBsit.toString(),
//             radius: radius,
//             titleStyle: TextStyle(
//                 fontSize: fontSize,
//                 fontWeight: FontWeight.bold,
//                 color: const Color(0xffffffff)),
//           );
//         case 3:
//           return PieChartSectionData(
//             color: const Color(0xff13d38e),
//             value: totalBsa,
//             title: 'BSA\n' + totalBsa.toString(),
//             radius: radius,
//             titleStyle: TextStyle(
//                 fontSize: fontSize,
//                 fontWeight: FontWeight.bold,
//                 color: const Color(0xffffffff)),
//           );
//         default:
//           throw 'Oh no';
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//         future: pieProvider.getTotalCourses(),
//         builder: (BuildContext context, snapshot) {
//           if (snapshot.hasError) {
//             return Text('Error: ${snapshot.error}');
//           }
//           if (snapshot.hasData) {
//             var totalCourses = snapshot.data;
//             return Column(
//               children: [
//                 Container(
//                   height: MediaQuery.of(context).size.height / 2.1,
//                   width: MediaQuery.of(context).size.width / 2.5,
//                   child: PieChart(
//                     PieChartData(
//                         borderData: FlBorderData(
//                           show: false,
//                         ),
//                         sectionsSpace: 0,
//                         centerSpaceRadius: 90,
//                         sections: showingSections(totalCourses)),
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
