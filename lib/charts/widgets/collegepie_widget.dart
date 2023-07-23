import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:web_tut/demo_try_paginateddatatable/userdata_notifier2.dart';
import 'package:web_tut/models/college.dart';
import 'package:web_tut/providers/college_provider.dart';
import 'package:web_tut/providers/course_provider.dart';
import 'package:web_tut/utils/constants.dart';

class CollegePieWidget extends StatelessWidget {
  const CollegePieWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _provider = CollegeProvider();
    final _model = _provider.collegeList;
    int touchedIndex = 0;

    return FutureBuilder<List<College>>(
        future: _provider.fetchData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            int touchedIndex = 0;
            //--------
            double all;
            double totalCob = 0;
            double totalCcs = 0;
            double totalCoa = 0;
            for (var i = 0; i < snapshot.data.length; i++) {
              if (snapshot.data[i].collegeName.toUpperCase() == 'COB') {
                totalCob += 1;
              }
              if (snapshot.data[i].collegeName.toUpperCase() == 'COA') {
                totalCoa += 1;
              }
              if (snapshot.data[i].collegeName.toUpperCase() == 'CCS') {
                totalCcs += 1;
              }
              all = totalCcs + totalCoa + totalCob;
            }

            List<PieChartSectionData> showingSections(int totalColleges) {
              //====

              return List.generate(totalColleges, (i) {
                final isTouched = i == touchedIndex;
                final fontSize = isTouched ? 20.0 : 16.0;
                final radius = isTouched ? 100.0 : 100.0;
                final widgetSize = isTouched ? 55.0 : 40.0;

                switch (i) {
                  case 0:
                    return PieChartSectionData(
                      color: kCobColor,
                      value: totalCob,
                      // title: 'COB\n' + totalCob.toString() + '%',
                      // value: 10,
                      title: 'COB',
                      radius: radius,
                      titleStyle: TextStyle(
                          fontSize: fontSize,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xffffffff)),
                      badgeWidget: _Badge(
                        'assets/images/ic_cob-logo.png',
                        size: widgetSize,
                        borderColor: const Color(0xff0293ee),
                      ),
                      badgePositionPercentageOffset: .98,
                    );

                  case 1:
                    return PieChartSectionData(
                      color: kCcsColor,
                      // value: (totalBsis + totalBsit),
                      // value: 10,
                      value: totalCcs,
                      title: 'CCS',
                      radius: radius,
                      titleStyle: TextStyle(
                          fontSize: fontSize,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xffffffff)),
                      badgeWidget: _Badge(
                        'assets/images/ic_ccs-logo.png',
                        size: widgetSize,
                        borderColor: const Color(0xfff8b250),
                      ),
                      badgePositionPercentageOffset: .98,
                    );
                  case 2:
                    return PieChartSectionData(
                      color: kCoaColor,
                      // value: totalBsa,
                      // value: 10,
                      value: totalCoa,
                      title: 'COA',
                      radius: radius,
                      titleStyle: TextStyle(
                          fontSize: fontSize,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xffffffff)),
                      badgeWidget: _Badge(
                        'assets/images/ic_coa-logo.png',
                        size: widgetSize,
                        borderColor: const Color(0xff845bef),
                      ),
                      badgePositionPercentageOffset: .98,
                    );
                  case 3:
                    return PieChartSectionData(
                      color: const Color(0xff13d38e),
                      value: 15,
                      title: '15%',
                      radius: radius,
                      titleStyle: TextStyle(
                          fontSize: fontSize,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xffffffff)),
                      badgeWidget: _Badge(
                        'assets/images/ic_coa-logo.png',
                        size: widgetSize,
                        borderColor: const Color(0xff13d38e),
                      ),
                      badgePositionPercentageOffset: .98,
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
                    sections: showingSections(all.toInt())),
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
