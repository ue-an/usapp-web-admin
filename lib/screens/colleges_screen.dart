import 'package:advanced_datatable/advanced_datatable_source.dart';
import 'package:advanced_datatable/datatable.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:provider/provider.dart';
import 'package:web_tut/models/college.dart';
import 'package:web_tut/models/student.dart';
import 'package:web_tut/providers/college_provider.dart';
import 'package:web_tut/utils/constants.dart';

class CollegesScreen extends StatelessWidget {
  CollegesScreen({Key key}) : super(key: key);
  // final _formKey1 = GlobalKey<FormState>();
  // final _formKey2 = GlobalKey<FormState>();
  final collegeCtrl = TextEditingController();
  final campusCtrl = TextEditingController();
  List<Student> students;
  var rowsPerPage = AdvancedPaginatedDataTable.defaultRowsPerPage;
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   title: const Text(
      //     "Colleges",
      //     style: TextStyle(color: Colors.blue),
      //   ),
      //   elevation: 0,
      // ),
      floatingActionButton: Container(
        margin: (() {
          //large
          if (size.height > 770) {
            if (size.width > 1400) {
              return EdgeInsets.only(right: size.width / 2.25);
            }
            if (size.width > 670) {
              return EdgeInsets.only(right: size.width / 2.33);
            } else {
              return EdgeInsets.only(right: size.width / 2.5);
            }
          }
          //mid
          if (size.height > 670) {
            if (size.width > 1400) {
              return EdgeInsets.only(right: size.width / 2.25);
            }
            if (size.width > 670) {
              return EdgeInsets.only(right: size.width / 2.33);
            } else {
              return EdgeInsets.only(right: size.width / 2.5);
            }
          }
          //small
          else {
            if (size.width > 1400) {
              return EdgeInsets.only(right: size.width / 2.25);
            }
            if (size.width > 670) {
              return EdgeInsets.only(right: size.width / 2.33);
            } else {
              return EdgeInsets.only(right: size.width / 2.5);
            }
          }
        }()),
        //largest screen/full
        // size.height > 770 && size.width > 770
        //     ? EdgeInsets.only(right: size.width / 1.25)
        //     :

        //     size.height > 670 && size.width > 1540
        //         ? EdgeInsets.only(right: size.width / 1.3)
        //         : EdgeInsets.only(right: size.width / 1.5),
        child: GFButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  backgroundColor: Colors.blue,
                  contentPadding: EdgeInsets.zero,
                  titlePadding: const EdgeInsets.only(top: 12),
                  elevation: 15,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(32.0),
                    ),
                    side: BorderSide(color: Colors.blue, width: 4),
                  ),
                  title: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 18),
                        child: Text(
                          "Add College",
                          style: TextStyle(color: Colors.white),
                        ),
                      )),
                  content: Container(
                    height: size.height / 3,
                    width: size.width / 1.9,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(32),
                          bottomRight: Radius.circular(32)),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 36,
                        horizontal: 20,
                      ),
                      child: Column(
                        children: [
                          //body
                          Expanded(
                            child: Form(
                              // key: _formKey1,
                              child: Column(
                                children: [
                                  TextFormField(
                                    controller: campusCtrl,
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                      ),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 20.0, vertical: 10.0),
                                      labelText: 'URS Campus',
                                      labelStyle: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    onChanged: (String value) => context
                                        .read<CollegeProvider>()
                                        .changeCampus = value,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please provide a valid input';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 18,
                                  ),
                                  TextFormField(
                                    controller: collegeCtrl,
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                      ),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 20.0, vertical: 10.0),
                                      labelText: 'New College Name',
                                      labelStyle: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    onChanged: (String value) => context
                                        .read<CollegeProvider>()
                                        .changeCollegename = value,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please provide a valid input';
                                      }
                                      return null;
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          //bottom buttons\
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GFButton(
                                onPressed: () {
                                  // if (_formKey2.currentState.validate()) {
                                  //   context.read<CollegeProvider>()
                                  //     ..saveCollege();
                                  //   Navigator.of(context, rootNavigator: true)
                                  //       .pop();
                                  //   ScaffoldMessenger.of(context).showSnackBar(
                                  //     const SnackBar(
                                  //       duration: Duration(milliseconds: 500),
                                  //       content: Text('Successfully added!'),
                                  //     ),
                                  //   );
                                  // }
                                  collegeCtrl.clear();
                                  campusCtrl.clear();
                                },
                                child: const Text("Add"),
                              ),
                              GFButton(
                                onPressed: () {
                                  Navigator.of(context, rootNavigator: true)
                                      .pop();
                                  collegeCtrl.clear();
                                  campusCtrl.clear();
                                },
                                color: Colors.red,
                                child: const Text("Cancel"),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
          shape: GFButtonShape.pills,
          elevation: 10,
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Add College"),
          ),
        ),
      ),
      body: StreamBuilder<List<College>>(
          stream: context.watch<CollegeProvider>().colleges,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasData) {
              return Row(
                children: [
                  Container(
                    height: double.infinity,
                    width: size.width / 1.5,
                    color: kPrimaryColor.withOpacity(0.5),
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: ListTile(
                              title: Text(snapshot.data[index].collegeName
                                  .toUpperCase()),
                              subtitle: Row(
                                children: [
                                  const Text('Campus: '),
                                  Text(snapshot.data[index].campus),
                                ],
                              ),
                              trailing: IconButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          backgroundColor: Colors.blue,
                                          contentPadding: EdgeInsets.zero,
                                          titlePadding:
                                              const EdgeInsets.only(top: 12),
                                          elevation: 15,
                                          shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(32.0),
                                            ),
                                            side: BorderSide(
                                                color: Colors.blue, width: 4),
                                          ),
                                          title: const Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 15,
                                                    horizontal: 18),
                                                child: Text(
                                                  "Remove College",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              )),
                                          content: Expanded(
                                            child: Container(
                                              height: size.height / 4,
                                              width: size.width / 2.5,
                                              decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(32),
                                                    bottomRight:
                                                        Radius.circular(32)),
                                                color: Colors.white,
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  vertical: 36,
                                                  horizontal: 20,
                                                ),
                                                child: Column(
                                                  children: [
                                                    //body
                                                    const Expanded(
                                                      child: Text(
                                                          "Do you really want to remove this College?"),
                                                    ),
                                                    const SizedBox(),
                                                    //bottom buttons\
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      children: [
                                                        GFButton(
                                                          onPressed: () {
                                                            context
                                                                .read<
                                                                    CollegeProvider>()
                                                                .removeCollege(
                                                                    snapshot
                                                                        .data[
                                                                            index]
                                                                        .collegeID);
                                                            Navigator.of(
                                                                    context,
                                                                    rootNavigator:
                                                                        true)
                                                                .pop();
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                              const SnackBar(
                                                                duration: Duration(
                                                                    milliseconds:
                                                                        500),
                                                                content: Text(
                                                                    'Successfully removed!'),
                                                              ),
                                                            );
                                                            collegeCtrl.clear();
                                                            campusCtrl.clear();
                                                          },
                                                          color: Colors.red,
                                                          child: const Text(
                                                              "Remove"),
                                                        ),
                                                        GFButton(
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context,
                                                                    rootNavigator:
                                                                        true)
                                                                .pop();
                                                            collegeCtrl.clear();
                                                            campusCtrl.clear();
                                                          },
                                                          color: Colors.blue,
                                                          child: const Text(
                                                              "Cancel"),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      });
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                  Container(
                    height: double.infinity,
                    width: size.width / 5.4,
                    color: Colors.white,
                    child: Center(),
                  ),
                ],
              );
            }
            return CircularProgressIndicator();
          }),
    );
  }

  // void _sort<T>(
  //   Comparable<T> Function(Student student) getField,
  //   int colIndex,
  //   bool asc,
  //   AdvancedSource _src,
  //   UserDataNotifier _provider,
  // ) {
  //   _src.sort<T>(getField, asc);
  //   _provider.changeSortAscending = asc;
  //   _provider.changeSortColumnIndex = colIndex;
  // }
}

typedef SelectedCallBack = Function(String id, bool newSelectState);

class AdvancedSource extends AdvancedDataTableSource<Student> {
  final List<Student> students;
  String lastSearchTerm = '';

  AdvancedSource(this.students);

//======= unang sample
  @override
  DataRow getRow(int index) {
    // final currentRowData = lastDetails.rows[index];
    assert(index >= 0);

    if (index >= students.length) {
      return null;
    }
    return DataRow.byIndex(cells: [
      DataCell(
        Text(students[index].studentNumber),
        onTap: () {
          print(students[index].studentNumber);
        },
      ),
      DataCell(
        Text(students[index].firstName),
        onTap: () {
          print(students[index].firstName);
        },
      ),
      DataCell(
        Text(students[index].mInitial),
        onTap: () {
          print(students[index].mInitial);
        },
      ),
      DataCell(
        Text(students[index].lastName),
        onTap: () {
          print(students[index].lastName);
        },
      ),
      DataCell(
        Text(students[index].course),
        onTap: () {
          print(students[index].course);
        },
      ),
      DataCell(
        Text(students[index].yearLvl.toString()),
        onTap: () {
          print(students[index].yearLvl);
        },
      ),
      DataCell(
        Text(students[index].section.toString()),
        onTap: () {
          print(students[index].section);
        },
      ),
      DataCell(
        Text(students[index].email),
        onTap: () {
          print(students[index].email);
        },
      ),
      DataCell(
        Text(students[index].college),
        onTap: () {
          print(students[index].college);
        },
      ),
    ], index: index);
  }
//======= end

//=======
  @override
  int get selectedRowCount => 0;
//============

  @override
  Future<RemoteDataSourceDetails<Student>> getNextPage(
      NextPageRequest pageRequest) async {
    return RemoteDataSourceDetails(
      students.length,
      students
          .skip(pageRequest.offset)
          .take(pageRequest.pageSize)
          .toList(), //again in a real world example you would only get the right amount of rows
      // filteredRows: students.length,
    );
  }

  sort<T>(Comparable<T> Function(Student s) getField, bool ascending) {
    students.sort((a, b) {
      final aValue = getField(a);
      final bValue = getField(b);
      return ascending
          ? Comparable.compare(aValue, bValue)
          : Comparable.compare(bValue, aValue);
    });
    notifyListeners();
  }

  void filterServerSide(String filterQuery) {
    lastSearchTerm = filterQuery.toLowerCase().trim();
    setNextView();
  }
}
