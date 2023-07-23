import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:provider/provider.dart';
import 'package:web_tut/models/college.dart';
import 'package:web_tut/models/course.dart';
import 'package:web_tut/providers/student_provider.dart';
import 'package:web_tut/services/firestore_service.dart';
import 'package:web_tut/utils/constants.dart';

class UpdateCollegeCourseSectionDropDown extends StatefulWidget {
  const UpdateCollegeCourseSectionDropDown({Key key}) : super(key: key);

  @override
  State<UpdateCollegeCourseSectionDropDown> createState() =>
      _UpdateCollegeCourseSectionDropDownState();
}

class _UpdateCollegeCourseSectionDropDownState
    extends State<UpdateCollegeCourseSectionDropDown>
    with AutomaticKeepAliveClientMixin<UpdateCollegeCourseSectionDropDown> {
  bool _isVisited = false;
  @override
  bool get wantKeepAlive => _isVisited;
  FirestoreService firestoreService = FirestoreService();
  String collegeDropdownValue;
  String courseDropdownValue;
  String yearDropdownValue;
  String sectionDropdownValue;
  Stream<List<College>> _streamCollege;
  Stream<List<Course>> _streamCourse;
  // List<int> groupValue = [0];
  int groupValue = 0;
  int yearGroupValue = 0;
  int sectionGroupValue = 0;
  @override
  void initState() {
    _streamCollege = firestoreService.getColleges();
    _streamCourse = firestoreService.getCourses();
    setState(() {
      _isVisited = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StreamBuilder<List<College>>(
            stream: _streamCollege,
            builder: (context, collegeSnap) {
              if (collegeSnap.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (collegeSnap.hasData) {
                List collegeNames = [];
                List courseNames = [];
                List yearLevel = [];
                List sections = [];
                collegeSnap.data.forEach((college) {
                  collegeNames.add(college.collegeName);
                });
                collegeSnap.data.forEach((college) {
                  if (collegeDropdownValue == college.collegeName) {
                    for (var i = 0; i < college.courses.length; i++) {
                      courseNames.add(college.courses[i]);
                    }
                  }
                });

                return Column(
                  children: [
                    Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.all(20),
                      child: DropdownButtonHideUnderline(
                        child: GFDropdown(
                          hint: const Text('College'),
                          padding: const EdgeInsets.all(15),
                          borderRadius: BorderRadius.circular(10),
                          border:
                              const BorderSide(color: Colors.black12, width: 1),
                          dropdownButtonColor: Colors.grey[850],
                          value: collegeDropdownValue,
                          onChanged: (newValue) {
                            setState(() {
                              context.read<StudentProvider>().updCollege =
                                  newValue;
                              collegeDropdownValue = newValue;
                              print(context.read<StudentProvider>().college);
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
                    ),
                    collegeDropdownValue == null
                        ? Container()
                        : Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: courseNames.length,
                                    itemBuilder: (context, index) {
                                      // for (var i = 0; i < courseNames.length; i++) {
                                      //   groupValue.add(i);
                                      // }
                                      return Column(
                                        children: [
                                          Row(
                                            children: [
                                              GFRadio(
                                                size: GFSize.SMALL,
                                                value: index,
                                                groupValue: groupValue,
                                                onChanged: (value) {
                                                  setState(() {
                                                    groupValue = value;
                                                    context
                                                            .read<StudentProvider>()
                                                            .updCourse =
                                                        courseNames[index];
                                                    print(courseNames[index]);
                                                  });
                                                },
                                                inactiveIcon: null,
                                                activeBorderColor:
                                                    kPrimaryColor,
                                                radioColor: kPrimaryColor,
                                              ),
                                              const SizedBox(
                                                width: 6,
                                              ),
                                              Text(courseNames[index]),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 9,
                                          ),
                                        ],
                                      );
                                      // return Text('data');
                                    },
                                  ),
                                ),
                                //year level
                                Expanded(
                                  child: StreamBuilder<List<Course>>(
                                      stream: _streamCourse,
                                      builder: (context, courseSnap) {
                                        if (courseSnap.hasData) {
                                          courseSnap.data.forEach((course) {
                                            if (course.courseName ==
                                                context
                                                    .read<StudentProvider>()
                                                    .updCourse) {
                                              for (var i = 1;
                                                  i <= course.years;
                                                  i++) {
                                                yearLevel.add(i.toString());
                                              }
                                            }
                                          });
                                          return Column(
                                            children: [
                                              ListView.builder(
                                                shrinkWrap: true,
                                                itemCount: yearLevel.length,
                                                itemBuilder: (context, index) {
                                                  return Row(
                                                    children: [
                                                      GFRadio(
                                                        size: GFSize.SMALL,
                                                        value: index,
                                                        groupValue:
                                                            yearGroupValue,
                                                        onChanged: (value) {
                                                          setState(() {
                                                            yearGroupValue =
                                                                value;
                                                            context
                                                                    .read<
                                                                        StudentProvider>()
                                                                    .updYearLevel =
                                                                yearLevel[
                                                                    index];
                                                            print(yearLevel[
                                                                index]);
                                                          });
                                                        },
                                                        inactiveIcon: null,
                                                        activeBorderColor:
                                                            kPrimaryColor,
                                                        radioColor:
                                                            kPrimaryColor,
                                                      ),
                                                      const SizedBox(
                                                        width: 6,
                                                      ),
                                                      Text(yearLevel[index]),
                                                    ],
                                                  );
                                                },
                                              ),
                                            ],
                                          );
                                        } else {
                                          return Container();
                                        }
                                      }),
                                ),
                                //section
                                Expanded(
                                  child: StreamBuilder<List<Course>>(
                                      stream: _streamCourse,
                                      builder: (context, courseSnap1) {
                                        courseSnap1.data.forEach((course) {
                                          if (course.courseName ==
                                              context
                                                  .read<StudentProvider>()
                                                  .updCourse) {
                                            for (var i = 1;
                                                i <= course.sections;
                                                i++) {
                                              sections.add(i.toString());
                                            }
                                          }
                                        });
                                        if (courseSnap1.hasData) {
                                          return Column(
                                            children: [
                                              ListView.builder(
                                                shrinkWrap: true,
                                                itemCount: sections.length,
                                                itemBuilder: (context, index) {
                                                  return Row(
                                                    children: [
                                                      GFRadio(
                                                        size: GFSize.SMALL,
                                                        value: index,
                                                        groupValue:
                                                            sectionGroupValue,
                                                        onChanged: (value) {
                                                          setState(() {
                                                            sectionGroupValue =
                                                                value;
                                                            context
                                                                    .read<
                                                                        StudentProvider>()
                                                                    .updSection =
                                                                sections[index];
                                                            print(sections[
                                                                index]);
                                                          });
                                                        },
                                                        inactiveIcon: null,
                                                        activeBorderColor:
                                                            kPrimaryColor,
                                                        radioColor:
                                                            kPrimaryColor,
                                                      ),
                                                      const SizedBox(
                                                        width: 6,
                                                      ),
                                                      Text(sections[index]),
                                                    ],
                                                  );
                                                },
                                              ),
                                            ],
                                          );
                                        } else {
                                          return Container();
                                        }
                                      }),
                                ),
                              ],
                            ),
                          ),
                  ],
                );
              } else {
                return const Text('No data');
              }
            }),
      ],
    );
  }
}
