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
  }

  //=== totals ====
  double total;
  //==== end ====

  //=== IS ===
  //1st
  double totalIS11;
  double totalIS12;
  double totalIS13;
  double totalIS14;
  //2nd
  double totalIS21;
  double totalIS22;
  double totalIS23;
  double totalIS24;
  //3rd
  double totalIS31;
  double totalIS32;
  double totalIS33;
  double totalIS34;
  //4th
  double totalIS41;
  double totalIS42;
  double totalIS43;
  double totalIS44;
  //==== end ====

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FirebaseFirestore.instance.collection('colleges').get(),
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
                return 'IS 1-1';
              case 1:
                return 'IS 1-2';
              case 2:
                return 'IS 1-3';
              case 3:
                return 'IS 1-4';
              case 4:
                return 'IS 2-1';
              case 5:
                return 'IS 2-2';
              case 6:
                return 'IS 2-3';
              case 7:
                return 'IS 2-4';
              case 8:
                return 'IS 3-1';
              case 9:
                return 'IS 3-2';
              case 10:
                return 'IS 3-3';
              case 11:
                return 'IS 3-4';
              case 12:
                return 'IS 4-1';
              case 13:
                return 'IS 4-2';
              case 14:
                return 'IS 4-3';
              case 15:
                return 'IS 4-4';
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
              y: totalIS11,
              colors: [Colors.lightBlueAccent, Colors.greenAccent],
            ),
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 1,
          barRods: [
            BarChartRodData(
              y: totalIS12,
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
                y: totalIS13,
                colors: [Colors.lightBlueAccent, Colors.greenAccent])
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 3,
          barRods: [
            BarChartRodData(
                y: totalIS14,
                colors: [Colors.lightBlueAccent, Colors.greenAccent])
          ],
          showingTooltipIndicators: [0],
        ),
        //========= 2nd year =========
        BarChartGroupData(
          x: 4,
          barRods: [
            BarChartRodData(
              y: totalIS21,
              colors: [Colors.lightBlueAccent, Colors.greenAccent],
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 5,
          barRods: [
            BarChartRodData(
              y: totalIS22,
              colors: [Colors.lightBlueAccent, Colors.greenAccent],
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 6,
          barRods: [
            BarChartRodData(
              y: totalIS23,
              colors: [Colors.lightBlueAccent, Colors.greenAccent],
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 7,
          barRods: [
            BarChartRodData(
              y: totalIS24,
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
              y: totalIS31,
              colors: [Colors.lightBlueAccent, Colors.greenAccent],
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 9,
          barRods: [
            BarChartRodData(
              y: totalIS32,
              colors: [Colors.lightBlueAccent, Colors.greenAccent],
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 10,
          barRods: [
            BarChartRodData(
              y: totalIS33,
              colors: [Colors.lightBlueAccent, Colors.greenAccent],
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 11,
          barRods: [
            BarChartRodData(
              y: totalIS34,
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
              y: totalIS41,
              colors: [Colors.lightBlueAccent, Colors.greenAccent],
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 13,
          barRods: [
            BarChartRodData(
              y: totalIS42,
              colors: [Colors.lightBlueAccent, Colors.greenAccent],
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 14,
          barRods: [
            BarChartRodData(
              y: totalIS43,
              colors: [Colors.lightBlueAccent, Colors.greenAccent],
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 15,
          barRods: [
            BarChartRodData(
              y: totalIS44,
              colors: [Colors.lightBlueAccent, Colors.greenAccent],
            )
          ],
          showingTooltipIndicators: [0],
        ),
      ];
}

class BarBSIS extends StatefulWidget {
  const BarBSIS({Key key}) : super(key: key);

  @override
  _BarBSISState createState() => _BarBSISState();
}

class _BarBSISState extends State<BarBSIS> {
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
