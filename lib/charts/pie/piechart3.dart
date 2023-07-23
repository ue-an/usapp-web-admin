// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:web_tut/models/college.dart';
// import 'package:web_tut/providers/college_provider.dart';
// import 'package:web_tut/providers/pie_provider.dart';
// import 'package:web_tut/services/firestore_service.dart';

// class PieChartSample3 extends StatelessWidget {
//   PieProvider pieProvider;
//   PieChartSample3({Key key, this.pieProvider}) : super(key: key);

//   // final PieProvider _pieProvider = PieProvider();

//   int touchedIndex = 0;
//   double total;
//   double totalCcs;
//   //
//   double totalBsoa;
//   double totalCob;
//   //
//   double totalBsa;
//   double totalCoa;

//   List<PieChartSectionData> showingSections(int totalColleges) {
//     //====
//     // totalCob = 10;
//     totalCob = pieProvider.totalCob;
//     // totalCcs = 10;
//     totalCcs = pieProvider.totalCcs;
//     // totalCoa = 10;
//     totalCoa = pieProvider.totalCoa;
//     return List.generate(totalColleges, (i) {
//       final isTouched = i == touchedIndex;
//       final fontSize = isTouched ? 20.0 : 16.0;
//       final radius = isTouched ? 100.0 : 100.0;
//       final widgetSize = isTouched ? 55.0 : 40.0;

//       switch (i) {
//         case 0:
//           return PieChartSectionData(
//             color: const Color(0xff0293ee),
//             value: totalCob,
//             // value: 10,
//             title: 'COB\n' + totalCob.toString() + '%',
//             radius: radius,
//             titleStyle: TextStyle(
//                 fontSize: fontSize,
//                 fontWeight: FontWeight.bold,
//                 color: const Color(0xffffffff)),
//             badgeWidget: _Badge(
//               'assets/images/ic_cob-logo.png',
//               size: widgetSize,
//               borderColor: const Color(0xff0293ee),
//             ),
//             badgePositionPercentageOffset: .98,
//           );

//         case 1:
//           return PieChartSectionData(
//             color: const Color(0xfff8b250),
//             // value: (totalBsis + totalBsit),
//             value: totalCcs,
//             // value: 10,
//             title: 'CCS\n' + totalCcs.toString() + '%',
//             radius: radius,
//             titleStyle: TextStyle(
//                 fontSize: fontSize,
//                 fontWeight: FontWeight.bold,
//                 color: const Color(0xffffffff)),
//             badgeWidget: _Badge(
//               'assets/images/ic_ccs-logo.png',
//               size: widgetSize,
//               borderColor: const Color(0xfff8b250),
//             ),
//             badgePositionPercentageOffset: .98,
//           );
//         case 2:
//           return PieChartSectionData(
//             color: const Color(0xff845bef),
//             // value: totalBsa,
//             value: totalCoa,
//             // value: 10,
//             title: 'COA\n' + totalCoa.toString() + '%',
//             radius: radius,
//             titleStyle: TextStyle(
//                 fontSize: fontSize,
//                 fontWeight: FontWeight.bold,
//                 color: const Color(0xffffffff)),
//             badgeWidget: _Badge(
//               'assets/images/ic_coa-logo.png',
//               size: widgetSize,
//               borderColor: const Color(0xff845bef),
//             ),
//             badgePositionPercentageOffset: .98,
//           );
//         case 3:
//           return PieChartSectionData(
//             color: const Color(0xff13d38e),
//             value: 15,
//             title: '15%',
//             radius: radius,
//             titleStyle: TextStyle(
//                 fontSize: fontSize,
//                 fontWeight: FontWeight.bold,
//                 color: const Color(0xffffffff)),
//             badgeWidget: _Badge(
//               'assets/images/ic_coa-logo.png',
//               size: widgetSize,
//               borderColor: const Color(0xff13d38e),
//             ),
//             badgePositionPercentageOffset: .98,
//           );
//         default:
//           throw 'Oh no';
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     // return FutureBuilder(
//     //     future: pieProvider.getTotalColleges(),
//     //     builder: (BuildContext context, snapshot) {
//     //       if (snapshot.hasError) {
//     //         return Text('Error: ${snapshot.error}');
//     //       }
//     //       if (snapshot.hasData) {
//     //         var totalColleges = snapshot.data;
//     //         return Column(
//     //           children: [
//     //             Container(
//     //               // color: kPrimaryColor.withOpacity(0.6),
//     //               height: MediaQuery.of(context).size.height / 2.1,
//     //               width: MediaQuery.of(context).size.width / 2.5,
//     //               child: PieChart(
//     //                 PieChartData(
//     //                     borderData: FlBorderData(
//     //                       show: false,
//     //                     ),
//     //                     sectionsSpace: 0,
//     //                     centerSpaceRadius: 90,
//     //                     sections: showingSections(totalColleges)),
//     //               ),
//     //             ),
//     //           ],
//     //         );
//     //       }
//     //       if (snapshot.connectionState == ConnectionState.waiting) {
//     //         return Container(
//     //           height: MediaQuery.of(context).size.height / 2.1,
//     //           width: MediaQuery.of(context).size.width / 2.5,
//     //           color: Colors.transparent,
//     //         );
//     //       } else {
//     //         return const Center(
//     //           child: Text('Waiting'),
//     //         );
//     //       }
//     //     });
//     return StreamBuilder<List<College>>(
//         stream: context.watch<CollegeProvider>().colleges,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//           if (snapshot.hasData) {
//             var tot = snapshot.data.length;
//             return Column(
//               children: [
//                 Container(
//                   // color: kPrimaryColor.withOpacity(0.6),
//                   height: MediaQuery.of(context).size.height / 2.1,
//                   width: MediaQuery.of(context).size.width / 2.5,
//                   child: PieChart(
//                     PieChartData(
//                         borderData: FlBorderData(
//                           show: false,
//                         ),
//                         sectionsSpace: 0,
//                         centerSpaceRadius: 90,
//                         sections: showingSections(tot)),
//                   ),
//                 ),
//               ],
//             );
//           } else {
//             return const Center(
//               child: Text('Waiting...'),
//             );
//           }
//         });
//   }
// }

// class _Badge extends StatelessWidget {
//   final String svgAsset;
//   final double size;
//   final Color borderColor;

//   const _Badge(
//     this.svgAsset, {
//     Key key,
//     this.size,
//     this.borderColor,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedContainer(
//       duration: PieChart.defaultDuration,
//       width: size,
//       height: size,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         shape: BoxShape.circle,
//         border: Border.all(
//           color: borderColor,
//           width: 2,
//         ),
//         boxShadow: <BoxShadow>[
//           BoxShadow(
//             color: Colors.black.withOpacity(.5),
//             offset: const Offset(3, 3),
//             blurRadius: 3,
//           ),
//         ],
//       ),
//       padding: EdgeInsets.all(size * .15),
//       child: Center(
//         child: Image.asset(svgAsset),
//         // child: Icon(
//         //   Icons.account_circle,
//         //   color: kPrimaryColor,
//       ),
//       // child: Text('sd'),
//     );
//   }
// }
