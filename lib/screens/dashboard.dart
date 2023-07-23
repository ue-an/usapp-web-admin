import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_tut/charts/bar/bar_bsis.dart';
import 'package:web_tut/charts/bar/bar_bsoa.dart';
import 'package:web_tut/charts/bar/barchart3.dart';
import 'package:web_tut/charts/pie/pie_courses.dart';
import 'package:web_tut/charts/pie/piechart3.dart';
import 'package:web_tut/charts/widgets/collegepie_widget.dart';
import 'package:web_tut/charts/widgets/coursepie_widget.dart';
import 'package:web_tut/charts/widgets/student_college_pie_widget.dart';
import 'package:web_tut/charts/widgets/student_course_pie.dart';
import 'package:web_tut/charts/widgets/threadpie_widget.dart';
import 'package:web_tut/models/student.dart';
import 'package:web_tut/providers/college_provider.dart';
import 'package:web_tut/providers/course_provider.dart';
import 'package:web_tut/providers/pie_provider.dart';
import 'package:web_tut/providers/student_provider.dart';
import 'package:web_tut/services/firestore_service.dart';
import 'package:web_tut/utils/constants.dart';
import 'package:web_tut/utils/routes.dart';

class Dashboard extends StatelessWidget {
  Dashboard({Key key}) : super(key: key);

  ScrollController dashScroll = ScrollController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacementNamed(context, Routes.homepage);
        },
        child: Icon(Icons.refresh),
      ),
      backgroundColor: kPrimaryColor.withOpacity(0.3),
      body: SingleChildScrollView(
        controller: dashScroll,
        child: Column(
          children: [
            //1st half labels
            Row(
              children: [
                Expanded(
                  child: Container(
                    // height: size.height / 30,
                    // color: kPrimaryColor.withOpacity(0.6),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Text(
                          'College Pie Chart',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: size.height / 90,
                    ),
                    // height: size.height / 15,
                    // color: kPrimaryColor.withOpacity(0.6),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Text(
                          'Course Pie Chart',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            //1st half charts
            Row(
              children: [
                Expanded(
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    color: Colors.white.withOpacity(0.8),
                    elevation: 6,
                    child: Container(
                      height: size.height / 2.3,
                      child: CollegePieWidget(),
                    ),
                  ),
                ),
                Expanded(
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    color: Colors.white.withOpacity(0.8),
                    elevation: 6,
                    child: Container(
                      height: size.height / 2.3,
                      child: CoursePieWidget(),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: size.height / 21,
            ),
            Divider(
              indent: size.width / 12,
              endIndent: size.width / 12,
              thickness: 3,
              color: kMiddleColor,
            ),
            //2nd half labels
            Row(
              children: [
                Expanded(
                  child: Container(
                    // height: size.height / 30,
                    // color: kPrimaryColor.withOpacity(0.6),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'College Breakdown',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: size.height / 90,
                    ),
                    // height: size.height / 15,
                    // color: kPrimaryColor.withOpacity(0.6),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'Course Breakdown',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            //2nd half charts
            Row(
              children: [
                Expanded(
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    color: Colors.white.withOpacity(0.8),
                    elevation: 6,
                    child: Container(
                      height: size.height / 2.3,
                      child: StudentCollegePieWidget(),
                    ),
                  ),
                ),
                Expanded(
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    color: Colors.white.withOpacity(0.8),
                    elevation: 6,
                    child: Container(
                      height: size.height / 2.3,
                      child: StudentCoursePieWidget(),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: size.height / 21,
            ),
            Divider(
              indent: size.width / 12,
              endIndent: size.width / 12,
              thickness: 3,
              color: kMiddleColor,
            ),
            //3rd half labels
            // Row(
            //   children: [
            //     Expanded(
            //       child: Container(
            //         // height: size.height / 30,
            //         // color: kPrimaryColor.withOpacity(0.6),
            //         child: Column(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           children: const [
            //             Text(
            //               'BSIT SECTION BREAKDOWN',
            //               style: TextStyle(
            //                 color: Colors.white,
            //                 fontWeight: FontWeight.bold,
            //               ),
            //             ),
            //           ],
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    // height: size.height / 30,
                    // color: kPrimaryColor.withOpacity(0.6),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'Threads',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Expanded(
                //   child: Container(
                //     padding: EdgeInsets.symmetric(
                //       vertical: size.height / 90,
                //     ),
                //     // height: size.height / 15,
                //     // color: kPrimaryColor.withOpacity(0.6),
                //     child: Column(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       children: const [
                //         Text(
                //           'BSIS',
                //           style: TextStyle(
                //             color: Colors.white,
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
              ],
            ),
            //3rd half charts
            Row(
              children: [
                Expanded(
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    color: Colors.white.withOpacity(0.8),
                    elevation: 6,
                    child: Container(
                      height: size.height / 2.3,
                      child: ThreadPieWidget(),
                    ),
                  ),
                ),
                // Expanded(
                //   child: Card(
                //     shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(12)),
                //     color: Colors.white.withOpacity(0.8),
                //     elevation: 6,
                //     child: Container(
                //       height: size.height / 2.3,
                //       child: Column(
                //         children: const [
                //           // StudentCoursePieWidget(),
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
            SizedBox(
              height: size.height / 21,
            ),
            Divider(
              indent: size.width / 12,
              endIndent: size.width / 12,
              thickness: 3,
              color: kMiddleColor,
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Expanded(
            //       child: Container(
            //         color: kPrimaryColor.withOpacity(0.6),
            //         child: Padding(
            //           padding: const EdgeInsets.all(8.0),
            //           child: Column(
            //             children: [
            //               //=== CCS BARS ===
            //               Padding(
            //                 padding: const EdgeInsets.only(
            //                   top: 15,
            //                   bottom: 15,
            //                 ),
            //                 child: Row(
            //                   mainAxisAlignment: MainAxisAlignment.start,
            //                   children: const [
            //                     Text(
            //                       'College of Computer Studies',
            //                       style: TextStyle(
            //                         fontWeight: FontWeight.bold,
            //                         fontSize: 18,
            //                         color: Colors.white,
            //                       ),
            //                     ),
            //                   ],
            //                 ),
            //               ),
            //               Row(
            //                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //                 children: [
            //                   //=== BSIT BAR ===
            //                   Column(
            //                     children: const [
            //                       Padding(
            //                         padding: EdgeInsets.only(
            //                           top: 15,
            //                           bottom: 15,
            //                         ),
            //                         child: Text(
            //                           'BSIT',
            //                           style: TextStyle(
            //                             fontWeight: FontWeight.bold,
            //                             fontSize: 18,
            //                             color: Colors.white,
            //                           ),
            //                         ),
            //                       ),
            //                       // BarChartSample3(
            //                       //   pieProvider: _pieProvider,
            //                       // ),
            //                     ],
            //                   ),
            //                   //=== BSIS BAR ===
            //                   Column(
            //                     children: const [
            //                       Padding(
            //                         padding: EdgeInsets.only(
            //                           top: 15,
            //                           bottom: 15,
            //                         ),
            //                         child: Text(
            //                           'BSIS',
            //                           style: TextStyle(
            //                             fontWeight: FontWeight.bold,
            //                             fontSize: 18,
            //                             color: Colors.white,
            //                           ),
            //                         ),
            //                       ),
            //                       // BarBSIS(),
            //                     ],
            //                   ),
            //                 ],
            //               ),
            //               //=== END CCS ===
            //               //=== COB BARS ===
            //               Padding(
            //                 padding: const EdgeInsets.only(
            //                   top: 60,
            //                   bottom: 15,
            //                 ),
            //                 child: Row(
            //                   mainAxisAlignment: MainAxisAlignment.start,
            //                   children: const [
            //                     Text(
            //                       'College of Business',
            //                       style: TextStyle(
            //                         fontWeight: FontWeight.bold,
            //                         fontSize: 18,
            //                         color: Colors.white,
            //                       ),
            //                     ),
            //                   ],
            //                 ),
            //               ),
            //               //=== BSOA BAR ===
            //               Row(
            //                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //                 children: [
            //                   //=== BSIT BAR ===
            //                   Column(
            //                     children: const [
            //                       Padding(
            //                         padding: EdgeInsets.only(
            //                           top: 15,
            //                           bottom: 15,
            //                         ),
            //                         child: Text(
            //                           'BSOA',
            //                           style: TextStyle(
            //                             fontWeight: FontWeight.bold,
            //                             fontSize: 18,
            //                             color: Colors.white,
            //                           ),
            //                         ),
            //                       ),
            //                       // BarBsoa(),
            //                     ],
            //                   ),
            //                 ],
            //               ),
            //             ],
            //           ),
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
