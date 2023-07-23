import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:web_tut/models/course.dart';
import 'package:web_tut/providers/course_provider.dart';
import 'package:web_tut/utils/constants.dart';

class CoursePieWidget extends StatelessWidget {
  const CoursePieWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _provider = CourseProvider();
    final _model = _provider.courseList;
    int touchedIndex = 0;

    return FutureBuilder<List<Course>>(
        future: _provider.fetchData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            int touchedIndex = 0;

            List<PieChartSectionData> showingSections(int totalCourses) {
              //====

              return List.generate(totalCourses, (i) {
                final isTouched = i == touchedIndex;
                final fontSize = isTouched ? 20.0 : 16.0;
                final radius = isTouched ? 100.0 : 100.0;
                final widgetSize = isTouched ? 55.0 : 40.0;
                //---------
                double totalBsit = 0;
                double totalBsis = 0;
                double totalBsoa = 0;
                double totalBsba = 0;
                double totalBsa = 0;
                for (var i = 0; i < snapshot.data.length; i++) {
                  if (snapshot.data[i].courseName.toUpperCase() == 'BSIT') {
                    // totalBsit = double.parse(snapshot.data.length.toString());
                    totalBsit += 1;
                    // snapshot.data.length
                  }
                  if (snapshot.data[i].courseName.toUpperCase() == 'BSIS') {
                    // totalBsit = double.parse(snapshot.data.length.toString());
                    totalBsis += 1;
                  }
                  if (snapshot.data[i].courseName.toUpperCase() == 'BSA') {
                    totalBsa += 1;
                  }
                  if (snapshot.data[i].courseName.toUpperCase() == 'BSOA') {
                    totalBsoa += 1;
                  }
                  if (snapshot.data[i].courseName.toUpperCase() == 'BSBA') {
                    totalBsba += 1;
                  }
                }

                switch (i) {
                  case 0:
                    return PieChartSectionData(
                      color: kCobColor,
                      // value: 15,
                      value: totalBsoa,
                      title: 'BSOA',
                      radius: radius,
                      titleStyle: TextStyle(
                          fontSize: fontSize,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xffffffff)),
                    );

                  case 1:
                    return PieChartSectionData(
                      color: kCobColor,
                      // value: 15,
                      value: totalBsba,
                      title: 'BSBA',
                      radius: radius,
                      titleStyle: TextStyle(
                          fontSize: fontSize,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xffffffff)),
                    );

                  case 2:
                    return PieChartSectionData(
                      color: kCcsColor,
                      value: totalBsit,
                      // title: 'COB\n' + totalCob.toString() + '%',
                      // value: 10,
                      title: 'BSIT',
                      radius: radius,
                      titleStyle: TextStyle(
                          fontSize: fontSize,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xffffffff)),
                    );

                  case 3:
                    return PieChartSectionData(
                      color: kCcsColor,
                      // value: 10,
                      value: totalBsis,
                      title: 'BSIS',
                      radius: radius,
                      titleStyle: TextStyle(
                          fontSize: fontSize,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xffffffff)),
                    );

                  case 4:
                    return PieChartSectionData(
                      color: kCoaColor,
                      // value: 10,
                      value: totalBsa,
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

            // return Center(
            //   child: Column(
            //     children: [
            //       Text('okay'),
            //       Text(snapshot.data.length.toString()),
            //     ],
            //   ),
            // );
            //---
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
                    sections: showingSections(_provider.courseList.length)),
              ),
            );
          }
          return Center(child: CircularProgressIndicator());
        });
  }
}

class _Badge extends StatelessWidget {
  final String svgAsset;
  final double size;
  final Color borderColor;

  const _Badge(
    this.svgAsset, {
    Key key,
    this.size,
    this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: PieChart.defaultDuration,
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(
          color: borderColor,
          width: 2,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(.5),
            offset: const Offset(3, 3),
            blurRadius: 3,
          ),
        ],
      ),
      padding: EdgeInsets.all(size * .15),
      child: Center(
        child: Image.asset(svgAsset),
        // child: Icon(
        //   Icons.account_circle,
        //   color: kPrimaryColor,
      ),
      // child: Text('sd'),
    );
  }
}
