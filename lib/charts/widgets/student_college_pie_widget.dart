import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:web_tut/models/student.dart';
import 'package:web_tut/providers/student_provider.dart';
import 'package:web_tut/utils/constants.dart';

class StudentCollegePieWidget extends StatelessWidget {
  const StudentCollegePieWidget({Key key}) : super(key: key);

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
            //------
            double all;
            double studentCob = 0;
            double studentCcs = 0;
            double studentCoa = 0;
            for (var i = 0; i < snapshot.data.length; i++) {
              if (snapshot.data[i].college.toUpperCase() == 'COB' &&
                  snapshot.data[i].isused == true) {
                studentCob += 1;
              }
              if (snapshot.data[i].college.toUpperCase() == 'COA' &&
                  snapshot.data[i].isused == true) {
                studentCoa += 1;
              }
              if (snapshot.data[i].college.toUpperCase() == 'CCS' &&
                  snapshot.data[i].isused == true) {
                studentCcs += 1;
              }
              all = studentCcs + studentCoa + studentCob;
            }
            print(all);

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
                      color: const Color(0xff0293ee),
                      value: studentCob,
                      // title: 'COB\n' + totalCob.toString() + '%',
                      // value: 10,
                      title: 'COB \n' + studentCob.toString() + ' user(s)',
                      radius: radius,
                      titleStyle: TextStyle(
                          fontSize: fontSize,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xffffffff)),
                    );

                  case 1:
                    return PieChartSectionData(
                      color: const Color(0xfff8b250),
                      // value: (totalBsis + totalBsit),
                      // value: 10,
                      value: studentCcs,
                      title: 'CCS: \n' + studentCcs.toString() + ' user(s)',
                      radius: radius,
                      titleStyle: TextStyle(
                          fontSize: fontSize,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xffffffff)),
                    );
                  case 2:
                    return PieChartSectionData(
                      color: const Color(0xff845bef),
                      // value: totalBsa,
                      // value: 10,
                      value: studentCoa,
                      title: 'COA: \n' + studentCoa.toString() + ' user(s)',
                      radius: radius,
                      titleStyle: TextStyle(
                          fontSize: fontSize,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xffffffff)),
                    );
                  case 3:
                    return PieChartSectionData(
                      color: const Color(0xff13d38e),
                      value: 0,
                      // title: '15%',
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
                    sections: showingSections(3)),
              ),
            );
          }
          return Center(child: CircularProgressIndicator());
        });
  }
}
