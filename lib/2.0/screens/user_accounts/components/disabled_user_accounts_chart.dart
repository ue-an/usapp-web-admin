import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:web_tut/models/report.dart';
import 'package:web_tut/models/student.dart';
import 'package:web_tut/models/thread.dart';

import '../../../constants.dart';

class DisabledUserAccountsChart extends StatelessWidget {
  int totalDisabledAccounts;
  List<Student> ccsDisabledAccounts;
  List<Student> cobDisabledAccounts;
  List<Student> coaDisabledAccounts;
  DisabledUserAccountsChart({
    Key key,
    this.totalDisabledAccounts,
    this.ccsDisabledAccounts,
    this.coaDisabledAccounts,
    this.cobDisabledAccounts,
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
                  value: double.parse(coaDisabledAccounts.length.toString()),
                  // value: 20,
                  showTitle: false,
                  radius: 25,
                ),
                PieChartSectionData(
                  color: const Color(0xFF26E5FF),
                  value: double.parse(cobDisabledAccounts.length.toString()),
                  // value: 20,
                  showTitle: false,
                  radius: 22,
                ),
                PieChartSectionData(
                  color: const Color(0xFFFFCF26),
                  value: double.parse(ccsDisabledAccounts.length.toString()),
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
                  totalDisabledAccounts.toString(),
                  style: Theme.of(context).textTheme.headline4.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        height: 0.5,
                      ),
                ),
                totalDisabledAccounts > 1
                    ? const Text("Disabled Accounts")
                    : const Text("Disabled Account"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
