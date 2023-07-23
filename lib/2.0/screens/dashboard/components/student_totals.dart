import 'package:flutter/material.dart';
import 'package:web_tut/models/student.dart';
import '../../../constants.dart';
import 'chart.dart';
import 'storage_info_card.dart';

class StudentTotals extends StatefulWidget {
  Stream<List<Student>> streamMembers;
  StudentTotals({
    Key key,
    this.streamMembers,
  }) : super(key: key);

  @override
  State<StudentTotals> createState() => _StudentTotalsState();
}

class _StudentTotalsState extends State<StudentTotals>
    with AutomaticKeepAliveClientMixin<StudentTotals> {
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
        stream: widget.streamMembers,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasData) {
            List<Student> ccsStudents = [];
            List<Student> cobStudents = [];
            List<Student> coaStudents = [];
            for (var student in snapshot.data) {
              if (student.college == 'CCS') {
                ccsStudents.add(student);
              }
              if (student.college == 'COA') {
                coaStudents.add(student);
              }
              if (student.college == 'COB') {
                cobStudents.add(student);
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
                    children: const [
                      Text(
                        "UsApp Users",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Icon(Icons.group),
                    ],
                  ),
                  const SizedBox(height: defaultPadding),
                  Chart(
                    totalUsers: snapshot.data.length,
                    streamedStudents: snapshot.data,
                  ),
                  StorageInfoCard(
                    imgSource: "assets/images/ic_coa-logo.png",
                    title: "College of Accountancy",
                    numOfFiles: coaStudents.length,
                  ),
                  StorageInfoCard(
                    imgSource: "assets/images/ic_cob-logo.png",
                    title: "College of Business",
                    numOfFiles: cobStudents.length,
                  ),
                  StorageInfoCard(
                    imgSource: "assets/images/ic_ccs-logo.png",
                    title: "College of Computer Studies",
                    numOfFiles: ccsStudents.length,
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
