import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:provider/provider.dart';
import 'package:web_tut/models/college.dart';
import 'package:web_tut/providers/college_provider.dart';
import 'package:web_tut/providers/course_provider.dart';
import 'package:web_tut/services/firestore_service.dart';

class CollegeDropdown extends StatefulWidget {
  const CollegeDropdown({Key key}) : super(key: key);

  @override
  State<CollegeDropdown> createState() => _CollegeDropdownState();
}

class _CollegeDropdownState extends State<CollegeDropdown>
    with AutomaticKeepAliveClientMixin<CollegeDropdown> {
  bool _isVisited = false;
  @override
  bool get wantKeepAlive => _isVisited;
  FirestoreService firestoreService = FirestoreService();
  Stream<List<College>> _streamCollege;
  String collegeDropdownValue;
  @override
  void initState() {
    _streamCollege = firestoreService.getColleges();
    setState(() {
      _isVisited = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _streamCollege,
      builder: (context, collegeSnap) {
        if (collegeSnap.hasData) {
          List collegeNames = [];
          collegeSnap.data.forEach((college) {
            collegeNames.add(college.collegeName);
          });
          return Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.all(20),
            child: DropdownButtonHideUnderline(
              child: GFDropdown(
                hint: const Text('College'),
                padding: const EdgeInsets.all(15),
                borderRadius: BorderRadius.circular(10),
                border: const BorderSide(color: Colors.black12, width: 1),
                dropdownButtonColor: Colors.grey[850],
                value: collegeDropdownValue,
                onChanged: (newValue) {
                  setState(() {
                    collegeDropdownValue = newValue;
                    context.read<CollegeProvider>().changeCollegename =
                        newValue;
                    context.read<CourseProvider>().changeCollege = newValue;
                  });
                },
                items: collegeNames
                    .map((value) => DropdownMenuItem(
                          value: value,
                          child: Text(value),
                        ))
                    .toList(),
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
