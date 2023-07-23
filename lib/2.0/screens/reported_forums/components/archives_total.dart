import 'package:flutter/material.dart';
import 'package:web_tut/2.0/screens/reported_forums/components/chart.dart';
import 'package:web_tut/2.0/screens/reported_forums/components/reported_forums_card.dart';
import 'package:web_tut/models/report.dart';
import 'package:web_tut/models/student.dart';
import 'package:web_tut/models/thread.dart';
import '../../../constants.dart';

class ArchivesTotal extends StatefulWidget {
  Stream<List<Thread>> streamForums;
  ArchivesTotal({
    Key key,
    this.streamForums,
  }) : super(key: key);

  @override
  State<ArchivesTotal> createState() => _ArchivesTotalState();
}

class _ArchivesTotalState extends State<ArchivesTotal>
    with AutomaticKeepAliveClientMixin<ArchivesTotal> {
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
    return StreamBuilder<List<Thread>>(
        stream: widget.streamForums,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasData) {
            List<Thread> ccsForums = [];
            List<Thread> cobForums = [];
            List<Thread> coaForums = [];
            for (var forum in snapshot.data) {
              if (forum.college == 'CCS' && forum.isReported == true) {
                ccsForums.add(forum);
              }
              if (forum.college == 'COA' && forum.isReported == true) {
                coaForums.add(forum);
              }
              if (forum.college == 'COB' && forum.isReported == true) {
                cobForums.add(forum);
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
                            ? "Archived Forums"
                            : "Archived Forum",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      const Icon(Icons.archive_outlined),
                    ],
                  ),
                  const SizedBox(height: defaultPadding),
                  Chart(
                    totalThreads: snapshot.data.length,
                    streamedForums: snapshot.data,
                    coaForums: coaForums,
                    cobForums: cobForums,
                    ccsForums: ccsForums,
                  ),
                  ReportedForumsCard(
                    imgSource: "assets/images/ic_coa-logo.png",
                    title: "College of Accountancy",
                    numOfFiles: coaForums.length,
                  ),
                  ReportedForumsCard(
                    imgSource: "assets/images/ic_cob-logo.png",
                    title: "College of Business",
                    numOfFiles: cobForums.length,
                  ),
                  ReportedForumsCard(
                    imgSource: "assets/images/ic_ccs-logo.png",
                    title: "College of Computer Studies",
                    numOfFiles: ccsForums.length,
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
