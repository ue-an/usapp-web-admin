import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:web_tut/models/student.dart';
import 'package:web_tut/models/thread.dart';
import 'package:web_tut/providers/student_provider.dart';
import 'package:web_tut/providers/thread_provider.dart';
import 'package:web_tut/utils/constants.dart';

class ThreadPieWidget extends StatelessWidget {
  const ThreadPieWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _provider = ThreadProvider();
    final _model = _provider.threadList;
    int touchedIndex = 0;

    return FutureBuilder<List<Thread>>(
        future: _provider.fetchData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            int touchedIndex = 0;
            //------
            double all;
            double threadCob = 0;
            double threadCcs = 0;
            double threadCoa = 0;
            for (var i = 0; i < snapshot.data.length; i++) {
              if (snapshot.data[i].college.toUpperCase() == 'COB') {
                threadCob += 1;
              }
              if (snapshot.data[i].college.toUpperCase() == 'COA') {
                threadCoa += 1;
              }
              if (snapshot.data[i].college.toUpperCase() == 'CCS') {
                threadCcs += 1;
              }
              all = threadCcs + threadCoa + threadCob;
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
                      value: threadCob,
                      // title: 'COB\n' + totalCob.toString() + '%',
                      // value: 10,
                      title: 'COB: \n' + threadCob.toString() + ' thread(s)',
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
                      value: threadCcs,
                      title: 'CCS: \n' + threadCcs.toString() + ' thread(s)',
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
                      value: threadCoa,
                      title: 'COA: \n' + threadCoa.toString() + ' thread(s)',
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
