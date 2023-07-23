import 'package:flutter/material.dart';
import 'package:web_tut/2.0/screens/reported_forums/components/chart.dart';
import 'package:web_tut/2.0/screens/reported_forums/components/reported_forums_card.dart';
import 'package:web_tut/2.0/screens/user_accounts/components/active_user_accounts_chart.dart';
import 'package:web_tut/2.0/screens/user_accounts/components/active_user_accounts_sidecard.dart';
import 'package:web_tut/2.0/screens/user_accounts/components/disabled_user_accounts_chart.dart';
import 'package:web_tut/2.0/screens/user_accounts/components/disabled_user_accounts_sidecard.dart';
import 'package:web_tut/models/report.dart';
import 'package:web_tut/models/student.dart';
import 'package:web_tut/models/thread.dart';
import '../../../constants.dart';

class DisabledUserAccountsTotal extends StatefulWidget {
  Stream<List<Student>> streamAccounts;
  DisabledUserAccountsTotal({
    Key key,
    this.streamAccounts,
  }) : super(key: key);

  @override
  State<DisabledUserAccountsTotal> createState() =>
      _DisabledUserAccountsTotalState();
}

class _DisabledUserAccountsTotalState extends State<DisabledUserAccountsTotal>
    with AutomaticKeepAliveClientMixin<DisabledUserAccountsTotal> {
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
            List<Student> disabledAccounts = [];
            List<Student> disabledAcctsCCS = [];
            List<Student> disabledAcctsCOA = [];
            List<Student> disabledAcctsCOB = [];

            for (var account in snapshot.data) {
              if ((account.isused == true && account.isEnabled == false) &&
                  account.college == 'CCS') {
                disabledAcctsCCS.add(account);
                disabledAccounts.add(account);
              }
              if ((account.isused == true && account.isEnabled == false) &&
                  account.college == 'COA') {
                disabledAcctsCOA.add(account);
                disabledAccounts.add(account);
              }
              if ((account.isused == true && account.isEnabled == false) &&
                  account.college == 'COB') {
                disabledAcctsCOB.add(account);
                disabledAccounts.add(account);
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
                            ? "Disabled Accounts"
                            : "Disabled Account",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      const Icon(Icons.mobile_off_sharp),
                    ],
                  ),
                  const SizedBox(height: defaultPadding),
                  DisabledUserAccountsChart(
                    totalDisabledAccounts: disabledAccounts.length,
                    ccsDisabledAccounts: disabledAcctsCCS,
                    coaDisabledAccounts: disabledAcctsCOA,
                    cobDisabledAccounts: disabledAcctsCOB,
                  ),
                  DisabledUserAccountsSideCard(
                    imgSource: "assets/images/ic_coa-logo.png",
                    title: "College of Accountancy",
                    numOfFiles: disabledAcctsCOA.length,
                  ),
                  DisabledUserAccountsSideCard(
                    imgSource: "assets/images/ic_cob-logo.png",
                    title: "College of Business",
                    numOfFiles: disabledAcctsCOB.length,
                  ),
                  DisabledUserAccountsSideCard(
                    imgSource: "assets/images/ic_ccs-logo.png",
                    title: "College of Computer Studies",
                    numOfFiles: disabledAcctsCCS.length,
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
