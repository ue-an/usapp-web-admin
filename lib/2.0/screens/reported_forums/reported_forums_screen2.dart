import 'package:flutter/material.dart';
import 'package:web_tut/2.0/constants.dart';
import 'package:web_tut/2.0/responsive.dart';
import 'package:web_tut/2.0/screens/reported_forums/components/archives_header.dart';
import 'package:web_tut/2.0/screens/reported_forums/components/archives_list.dart';
import 'package:web_tut/2.0/screens/reported_forums/components/archives_total.dart';
import 'package:web_tut/2.0/screens/reported_forums/components/header.dart';
import 'package:web_tut/2.0/screens/reported_forums/components/reported_list.dart';
import 'package:web_tut/2.0/screens/reported_forums/components/reports_total.dart';
import 'package:web_tut/models/report.dart';
import 'package:web_tut/models/thread.dart';
import 'package:web_tut/services/firestore_service.dart';
import 'package:web_tut/utils/constants.dart';

class ReportedForumsScreen2 extends StatefulWidget {
  const ReportedForumsScreen2({Key key}) : super(key: key);

  @override
  State<ReportedForumsScreen2> createState() => _ReportedForumsScreen2State();
}

class _ReportedForumsScreen2State extends State<ReportedForumsScreen2>
    with AutomaticKeepAliveClientMixin<ReportedForumsScreen2> {
  bool _isVisited = false;
  @override
  bool get wantKeepAlive => _isVisited;
  FirestoreService firestoreService = FirestoreService();
  Stream<List<Report>> _streamReports;
  Stream<List<Thread>> _streamThreads;
  Stream<List<Report>> _streamReports2;
  Stream<List<Thread>> _streamThreads2;
  @override
  void initState() {
    _streamReports = firestoreService.getReports();
    _streamThreads = firestoreService.getReportedThreads();
    _streamReports2 = firestoreService.getReports();
    _streamThreads2 = firestoreService.getReportedThreads();
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
                  'Report Requests',
                ),
              ),
              Container(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  'Archives',
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
                    const Header(),
                    const SizedBox(height: defaultPadding),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 5,
                          child: Column(
                            children: [
                              ReportedList(
                                streamReportRequests: _streamReports,
                              ),
                              const SizedBox(height: defaultPadding),
                              if (Responsive.isMobile(context))
                                const SizedBox(
                                  height: defaultPadding,
                                ),
                              if (Responsive.isMobile(context))
                                ReportsTotal(
                                  streamForums: _streamThreads,
                                ),
                            ],
                          ),
                        ),
                        if (!Responsive.isMobile(context))
                          const SizedBox(width: defaultPadding),
                        // On Mobile means if the screen is less than 850 we dont want to show it
                        if (!Responsive.isMobile(context))
                          Expanded(
                            flex: 2,
                            child: ReportsTotal(
                              streamForums: _streamThreads,
                            ),
                            // child: Container(
                            //   child: const Center(
                            //     child: Text(
                            //       'Working. Temporarily disabled\nto save data (students total)',
                            //       textAlign: TextAlign.center,
                            //     ),
                            //   ),
                            //   color: Colors.grey[850],
                            // ),
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
                    const ArchivesHeader(),
                    const SizedBox(height: defaultPadding),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 5,
                          child: Column(
                            children: [
                              ArchivesList(
                                streamArchivedReports: _streamReports2,
                              ),
                              const SizedBox(height: defaultPadding),
                              if (Responsive.isMobile(context))
                                const SizedBox(
                                  height: defaultPadding,
                                ),
                              if (Responsive.isMobile(context))
                                ArchivesTotal(
                                  streamForums: _streamThreads2,
                                ),
                            ],
                          ),
                        ),
                        if (!Responsive.isMobile(context))
                          const SizedBox(width: defaultPadding),
                        // On Mobile means if the screen is less than 850 we dont want to show it
                        if (!Responsive.isMobile(context))
                          Expanded(
                            flex: 2,
                            child: ArchivesTotal(
                              streamForums: _streamThreads2,
                            ),
                            // child: Container(
                            //   child: const Center(
                            //     child: Text(
                            //       'Working. Temporarily disabled\nto save data (students total)',
                            //       textAlign: TextAlign.center,
                            //     ),
                            //   ),
                            //   color: Colors.grey[850],
                            // ),
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
