import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:web_tut/models/student.dart';
import 'package:web_tut/providers/student_provider.dart';
import 'package:web_tut/utils/constants.dart';

class StudentCoursePieWidget extends StatelessWidget {
  const StudentCoursePieWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _provider = StudentProvider();
    final _model = _provider.studentList;
    int touchedIndex = 0;

    return FutureBuilder<List<Student>>(
        future: _provider.fetchData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            int touchedIndex = 0;
            double all;
            //----
            double studentBsit = 0;
            double studentBsis = 0;
            double studentBsa = 0;
            double studentBsoa = 0;
            double studentBsba = 0;
            //--
            for (var i = 0; i < snapshot.data.length; i++) {
              if (snapshot.data[i].course.toUpperCase() == 'BSIT' &&
                  snapshot.data[i].isused == true) {
                studentBsit += 1;
              }
              if (snapshot.data[i].course.toUpperCase() == 'BSIS' &&
                  snapshot.data[i].isused == true) {
                studentBsis += 1;
              }
              if (snapshot.data[i].course.toUpperCase() == 'BSA' &&
                  snapshot.data[i].isused == true) {
                studentBsa += 1;
              }
              if (snapshot.data[i].course.toUpperCase() == 'BSOA' &&
                  snapshot.data[i].isused == true) {
                studentBsoa += 1;
              }
              if (snapshot.data[i].course.toUpperCase() == 'BSBA' &&
                  snapshot.data[i].isused == true) {
                studentBsa += 1;
              }
              all = studentBsit +
                  studentBsis +
                  studentBsa +
                  studentBsba +
                  studentBsoa;
            }

            List<PieChartSectionData> showingSections(int totalColleges) {
              //====

              return List.generate(totalColleges, (i) {
                final isTouched = i == touchedIndex;
                final fontSize = isTouched ? 20.0 : 16.0;
                final radius = isTouched ? 100.0 : 100.0;
                final widgetSize = isTouched ? 55.0 : 40.0;
                //---------

                switch (i) {
                  case 0:
                    return PieChartSectionData(
                      color: const Color(0xff13d38e),
                      value: studentBsoa,
                      title: 'BSOA',
                      radius: radius,
                      titleStyle: TextStyle(
                          fontSize: fontSize,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xffffffff)),
                    );

                  case 1:
                    return PieChartSectionData(
                      color: const Color(0xff13d38e),
                      value: studentBsba,
                      title: 'BSBA',
                      radius: radius,
                      titleStyle: TextStyle(
                          fontSize: fontSize,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xffffffff)),
                    );

                  case 2:
                    return PieChartSectionData(
                      color: const Color(0xff0293ee),
                      value: studentBsit,
                      // title: 'COB\n' + totalCob.toString() + '%',
                      // value: 10,
                      title: 'BSIT: \n' + studentBsit.toString() + ' users(s)',
                      radius: radius,
                      titleStyle: TextStyle(
                          fontSize: fontSize,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xffffffff)),
                    );

                  case 3:
                    return PieChartSectionData(
                      color: const Color(0xfff8b250),
                      // value: (totalBsis + totalBsit),
                      // value: 10,
                      value: studentBsis,
                      title: 'BSIS: \n' + studentBsis.toString() + ' user(s)',
                      radius: radius,
                      titleStyle: TextStyle(
                          fontSize: fontSize,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xffffffff)),
                    );

                  case 4:
                    return PieChartSectionData(
                      color: const Color(0xff845bef),
                      // value: totalBsa,
                      // value: 10,
                      value: studentBsa,
                      title: 'BSA',
                      radius: radius,
                      titleStyle: TextStyle(
                          fontSize: fontSize,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xffffffff)),
                    );

                  case 5:
                    return PieChartSectionData(
                      color: const Color(0xff845bef),
                      // value: totalBsa,
                      // value: 10,
                      value: studentBsa,
                      title: 'BSA',
                      radius: radius,
                      titleStyle: TextStyle(
                          fontSize: fontSize,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xffffffff)),
                    );

                  case 6:
                    return PieChartSectionData(
                      color: const Color(0xff845bef),
                      // value: totalBsa,
                      // value: 10,
                      value: studentBsa,
                      title: 'BSA',
                      radius: radius,
                      titleStyle: TextStyle(
                          fontSize: fontSize,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xffffffff)),
                    );

                  default:
                    throw 'Oh no';
                }
              });
            }

            return Container(
              height: MediaQuery.of(context).size.height / 15,
              // width: MediaQuery.of(context).size.width / 4,
              child: PieChart(
                PieChartData(
                  borderData: FlBorderData(
                    show: false,
                  ),
                  sectionsSpace: 0,
                  centerSpaceRadius: MediaQuery.of(context).size.height > 770
                      ? 80
                      : MediaQuery.of(context).size.height > 670
                          ? 50
                          : 0,
                  sections: showingSections(all.toInt()),
                ),
              ),
            );
          }
          return Center(child: CircularProgressIndicator());
        });
  }
}
