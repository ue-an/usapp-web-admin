import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:web_tut/models/report.dart';
import 'package:web_tut/models/student.dart';
import 'package:web_tut/models/thread.dart';

import '../../../constants.dart';

class ActiveUserAccountsChart extends StatelessWidget {
  int totalActiveAccounts;
  List<Student> ccsActiveAccounts;
  List<Student> cobActiveAccounts;
  List<Student> coaActiveAccounts;
  ActiveUserAccountsChart({
    Key key,
    this.totalActiveAccounts,
    this.ccsActiveAccounts,
    this.coaActiveAccounts,
    this.cobActiveAccounts,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Stack(
        children: [
          PieChart(
            PieChartData(
              sectionsSpace: 0,
              centerSpaceRadius: 70,
              startDegreeOffset: -90,
              sections: [
                PieChartSectionData(
                  color: primaryColor,
                  value: double.parse(coaActiveAccounts.length.toString()),
                  // value: 20,
                  showTitle: false,
                  radius: 25,
                ),
                PieChartSectionData(
                  color: const Color(0xFF26E5FF),
                  value: double.parse(cobActiveAccounts.length.toString()),
                  // value: 20,
                  showTitle: false,
                  radius: 22,
                ),
                PieChartSectionData(
                  color: const Color(0xFFFFCF26),
                  value: double.parse(ccsActiveAccounts.length.toString()),
                  // value: 20,
                  showTitle: false,
                  radius: 19,
                ),
              ],
            ),
          ),
          Positioned.fill(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: defaultPadding),
                Text(
                  totalActiveAccounts.toString(),
                  style: Theme.of(context).textTheme.headline4.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        height: 0.5,
                      ),
                ),
                totalActiveAccounts > 1
                    ? const Text("Active Accounts")
                    : const Text("Active Account"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
