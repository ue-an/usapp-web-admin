import 'package:flutter/material.dart';
import 'package:web_tut/2.0/constants.dart';
import 'package:web_tut/2.0/responsive.dart';
import 'package:web_tut/2.0/screens/user_accounts/components/active_user_accounts_total.dart';
import 'package:web_tut/2.0/screens/user_accounts/components/active_user_accounts_header.dart';
import 'package:web_tut/2.0/screens/user_accounts/components/active_user_accounts_list.dart';
import 'package:web_tut/2.0/screens/user_accounts/components/disabled_user_accounts_header.dart';
import 'package:web_tut/2.0/screens/user_accounts/components/disabled_user_accounts_list.dart';
import 'package:web_tut/2.0/screens/user_accounts/components/disabled_user_accounts_total.dart';
import 'package:web_tut/models/student.dart';
import 'package:web_tut/services/firestore_service.dart';
import 'package:web_tut/utils/constants.dart';

class MobileUserAccountsScreen extends StatefulWidget {
  const MobileUserAccountsScreen({Key key}) : super(key: key);

  @override
  State<MobileUserAccountsScreen> createState() =>
      _MobileUserAccountsScreenState();
}

class _MobileUserAccountsScreenState extends State<MobileUserAccountsScreen>
    with AutomaticKeepAliveClientMixin<MobileUserAccountsScreen> {
  bool _isVisited = false;
  @override
  bool get wantKeepAlive => _isVisited;
  FirestoreService firestoreService = FirestoreService();
  Stream<List<Student>> _streamAccounts;
  Stream<List<Student>> _streamAccounts2;
  final useracctScroll = ScrollController();
  @override
  void initState() {
    _streamAccounts = firestoreService.getAccounts();
    _streamAccounts2 = firestoreService.getAccounts();
    setState(() {
      _isVisited = true;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: TabBar(
            indicatorColor: kMiddleColor,
            tabs: [
              // Add Tabs here
              Container(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  'Active User Accounts',
                ),
              ),
              Container(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  'Disabled User Accounts',
                ),
              ),
            ],
          ),
          body: TabBarView(
            children: [
              SingleChildScrollView(
                padding: const EdgeInsets.all(defaultPadding),
                child: Column(
                  children: [
                    const ActiveUserAccountsHeader(),
                    const SizedBox(height: defaultPadding),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 5,
                          child: Column(
                            children: [
                              ActiveUserAccountsList(
                                streamAccounts: _streamAccounts,
                              ),
                              const SizedBox(height: defaultPadding),
                              if (Responsive.isMobile(context))
                                const SizedBox(
                                  height: defaultPadding,
                                ),
                              if (Responsive.isMobile(context))
                                ActiveUserAccountsList(
                                  streamAccounts: _streamAccounts,
                                ),
                            ],
                          ),
                        ),
                        if (!Responsive.isMobile(context))
                          const SizedBox(width: defaultPadding),
                        if (!Responsive.isMobile(context))
                          Expanded(
                            flex: 2,
                            child: ActiveUserAccountsTotal(
                              streamAccounts: _streamAccounts,
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(
                padding: const EdgeInsets.all(defaultPadding),
                child: Column(
                  children: [
                    const DisabledUserAccountsHeader(),
                    const SizedBox(height: defaultPadding),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 5,
                          child: Column(
                            children: [
                              DisabledUserAccountsList(
                                streamAccounts: _streamAccounts2,
                              ),
                              const SizedBox(height: defaultPadding),
                              if (Responsive.isMobile(context))
                                const SizedBox(
                                  height: defaultPadding,
                                ),
                              if (Responsive.isMobile(context))
                                DisabledUserAccountsList(
                                  streamAccounts: _streamAccounts2,
                                ),
                            ],
                          ),
                        ),
                        if (!Responsive.isMobile(context))
                          const SizedBox(width: defaultPadding),
                        if (!Responsive.isMobile(context))
                          Expanded(
                            flex: 2,
                            child: DisabledUserAccountsTotal(
                              streamAccounts: _streamAccounts2,
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
