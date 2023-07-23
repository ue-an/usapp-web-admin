import 'package:flutter/material.dart';
import 'package:web_tut/2.0/screens/reported_forums/components/chart.dart';
import 'package:web_tut/2.0/screens/reported_forums/components/reported_forums_card.dart';
import 'package:web_tut/2.0/screens/user_accounts/components/active_user_accounts_chart.dart';
import 'package:web_tut/2.0/screens/user_accounts/components/active_user_accounts_sidecard.dart';
import 'package:web_tut/models/report.dart';
import 'package:web_tut/models/student.dart';
import 'package:web_tut/models/thread.dart';
import '../../../constants.dart';

class ActiveUserAccountsTotal extends StatefulWidget {
  Stream<List<Student>> streamAccounts;
  ActiveUserAccountsTotal({
    Key key,
    this.streamAccounts,
  }) : super(key: key);

  @override
  State<ActiveUserAccountsTotal> createState() =>
      _ActiveUserAccountsTotalState();
}

class _ActiveUserAccountsTotalState extends State<ActiveUserAccountsTotal>
    with AutomaticKeepAliveClientMixin<ActiveUserAccountsTotal> {
  bool _isVisited = false;
  @override
  bool get wantKeepAlive => _isVisited;
  @override
  void initState() {
    setState(() {
      _isVisited = true;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Student>>(
        stream: widget.streamAccounts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasData) {
            List<Student> activeAccounts = [];
            List<Student> activeAcctsCCS = [];
            List<Student> activeAcctsCOA = [];
            List<Student> activeAcctsCOB = [];

            for (var account in snapshot.data) {
              if ((account.isused == true && account.isEnabled == true) &&
                  account.college == 'CCS') {
                activeAcctsCCS.add(account);
                activeAccounts.add(account);
              }
              if ((account.isused == true && account.isEnabled == true) &&
                  account.college == 'COA') {
                activeAcctsCOA.add(account);
                activeAccounts.add(account);
              }
              if ((account.isused == true && account.isEnabled == true) &&
                  account.college == 'COB') {
                activeAcctsCOB.add(account);
                activeAccounts.add(account);
              }
            }
            return Container(
              padding: const EdgeInsets.all(defaultPadding),
              decoration: const BoxDecoration(
                color: secondaryColor,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        snapshot.data.length > 1
                            ? "Active Accounts"
                            : "Active Account",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      const Icon(Icons.mobile_friendly_sharp),
                    ],
                  ),
                  const SizedBox(height: defaultPadding),
                  ActiveUserAccountsChart(
                    totalActiveAccounts: activeAccounts.length,
                    ccsActiveAccounts: activeAcctsCCS,
                    coaActiveAccounts: activeAcctsCOA,
                    cobActiveAccounts: activeAcctsCOB,
                  ),
                  ActiveUserAccountsSideCard(
                    imgSource: "assets/images/ic_coa-logo.png",
                    title: "College of Accountancy",
                    numOfFiles: activeAcctsCOA.length,
                  ),
                  ActiveUserAccountsSideCard(
                    imgSource: "assets/images/ic_cob-logo.png",
                    title: "College of Business",
                    numOfFiles: activeAcctsCOB.length,
                  ),
                  ActiveUserAccountsSideCard(
                    imgSource: "assets/images/ic_ccs-logo.png",
                    title: "College of Computer Studies",
                    numOfFiles: activeAcctsCCS.length,
                  ),
                ],
              ),
            );
          } else {
            return Container(
              child: const Text('no data'),
            );
          }
        });
  }
}
