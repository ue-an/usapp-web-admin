import 'package:flutter/material.dart';
import 'package:web_tut/2.0/screens/dashboard/components/most_discussed_forum.dart';
import 'package:web_tut/2.0/screens/dashboard/components/mostliked_forum.dart';
import 'package:web_tut/2.0/screens/dashboard/components/my_fields.dart';
import 'package:web_tut/demo_try_paginateddatatable/mypaginated_datatable.dart';
import 'package:web_tut/models/student.dart';
import 'package:web_tut/models/thread.dart';
import 'package:web_tut/services/firestore_service.dart';

import '../../constants.dart';
import '../../responsive.dart';
import 'components/header.dart';

import 'components/recent_files.dart';
import 'components/student_totals.dart';

class DashboardScreen extends StatefulWidget {
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with AutomaticKeepAliveClientMixin<DashboardScreen> {
  @override
  bool get wantKeepAlive => true;
  FirestoreService firestoreService = FirestoreService();
  Stream<List<Student>> _streamMembers;
  Stream<List<Thread>> _streamThreads;
  final dashScroll = ScrollController();
  @override
  void initState() {
    _streamMembers = firestoreService.getUsers();
    _streamThreads = firestoreService.getThreads();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        controller: dashScroll,
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
                      MostLikedForum(
                        streamThreads: _streamThreads,
                      ),
                      const SizedBox(
                        height: defaultPadding,
                      ),
                      MostDiscussedForum(
                        streamThreads: _streamThreads,
                      ),
                      const SizedBox(
                        height: defaultPadding,
                      ),
                      MyFiles(
                        streamThreads: _streamThreads,
                      ),
                      // Container(
                      //   child: const Center(
                      //     child: Text(
                      //       'Working. Temporarily disabled\nto save data (forums)',
                      //       textAlign: TextAlign.center,
                      //     ),
                      //   ),
                      //   color: Colors.grey[850],
                      // ),
                      const SizedBox(height: defaultPadding),
                      if (Responsive.isMobile(context))
                        const SizedBox(
                          height: defaultPadding,
                        ),
                      if (Responsive.isMobile(context))
                        StudentTotals(
                          streamMembers: _streamMembers,
                        ),
                      // Container(
                      //   child: const Center(
                      //     child: Text(
                      //       'Working. Temporarily disabled\nto save data (students total)',
                      //       textAlign: TextAlign.center,
                      //     ),
                      //   ),
                      //   color: Colors.grey[850],
                      // ),
                    ],
                  ),
                ),
                if (!Responsive.isMobile(context))
                  const SizedBox(width: defaultPadding),
                // On Mobile means if the screen is less than 850 we dont want to show it
                if (!Responsive.isMobile(context))
                  Expanded(
                    flex: 2,
                    child: StudentTotals(
                      streamMembers: _streamMembers,
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
            )
          ],
        ),
      ),
    );
  }
}
