import 'package:flutter/material.dart';
import 'package:flutter_initicon/flutter_initicon.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/getwidget.dart';
import 'package:provider/provider.dart';
import 'package:web_tut/demo_try_paginateddatatable/customs/custom_dialog.dart';
import 'package:web_tut/demo_try_paginateddatatable/other_details.dart';
import 'package:web_tut/models/student.dart';
import 'package:web_tut/providers/student_provider.dart';
import 'package:web_tut/utils/constants.dart';

typedef OnRowSelect = void Function(int index);

class UserDataTableSource extends DataTableSource {
  UserDataTableSource({
    @required List<Student> userData,
    @required this.onRowSelect,
    @required this.context,
  })  : _userData = userData,
        assert(userData != null);

  final List<Student> _userData;
  final OnRowSelect onRowSelect;
  List selectedStudents = [];
  //
  BuildContext context;

  @override
  DataRow getRow(int index) {
    assert(index >= 0);

    if (index >= _userData.length) {
      return null;
    }
    final _user = _userData[index];

    return DataRow.byIndex(
      selected: selectedStudents.contains(_user),
      // onSelectChanged: (isSelected) {
      //   final isAdding = isSelected != null && isSelected;

      //   isAdding ? selectedStudents.add(_user) : selectedStudents.remove(_user);
      // },
      index: index, // DONT MISS THIS
      cells: <DataCell>[
        DataCell(Text(_user.studentNumber)),
        // DataCell(_user.photoUrl != ''
        //     ? CircleAvatar(
        //         child: ClipRRect(
        //           borderRadius: const BorderRadius.all(Radius.circular(50)),
        //           child: Image.network(
        //             _user.photoUrl,
        //             height: 90,
        //             width: 90,
        //             fit: BoxFit.cover,
        //           ),
        //         ),
        //       )
        //     : Initicon(
        //         text: _user.firstName + ' ' + _user.lastName,
        //       )),
        DataCell(Text(_user.firstName)),
        DataCell(
          Container(
            child: Text(_user.mInitial),
            width: 6,
          ),
        ),
        DataCell(Text(_user.lastName)),
        DataCell(Text(_user.email)),
        DataCell(Text(_user.course)),
        DataCell(Text(_user.yearLvl.toString())),
        DataCell(Text(_user.section.toString())),
        DataCell(Text(_user.college)),
        DataCell(
          Row(
            children: [
              IconButton(
                hoverColor: kMiddleColor.withOpacity(.3),
                splashColor: Colors.transparent,
                icon: Icon(
                  Icons.edit,
                  color: kPrimaryColor,
                ),
                onPressed: () => onRowSelect(index),
              ),
              SizedBox(
                width: 18,
              ),
              IconButton(
                  hoverColor: Colors.red.withOpacity(.3),
                  splashColor: Colors.transparent,
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: MediaQuery.of(context).size.height > 770
                                ? 32
                                : MediaQuery.of(context).size.height > 670
                                    ? 16
                                    : 8,
                            horizontal: MediaQuery.of(context).size.width > 770
                                ? 16
                                : MediaQuery.of(context).size.width > 670
                                    ? 8
                                    : 4,
                          ),
                          child: Center(
                            child: Card(
                              elevation: 9,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  color: kPrimaryColor,
                                  width: 6,
                                ),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(25),
                                ),
                              ),
                              child: AnimatedContainer(
                                decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25)),
                                  color: Colors.white,
                                ),
                                duration: const Duration(milliseconds: 200),
                                height: MediaQuery.of(context).size.height *
                                    (MediaQuery.of(context).size.height > 770
                                        ? 0.3
                                        : MediaQuery.of(context).size.height >
                                                670
                                            ? 0.36
                                            : 0.5),
                                width: 500,
                                child: AlertDialog(
                                  elevation: 0,
                                  title: Row(
                                    children: const [
                                      Icon(
                                        Icons.warning,
                                        color: Colors.red,
                                      ),
                                      SizedBox(
                                        width: 6,
                                      ),
                                      Text('Remove Student'),
                                    ],
                                  ),
                                  content: SingleChildScrollView(
                                    child: ListBody(
                                      children: const <Widget>[
                                        Text(
                                            'Do you really want to remove this student record?'),
                                      ],
                                    ),
                                  ),
                                  actions: <Widget>[
                                    GFButton(
                                      onPressed: () async {
                                        StudentProvider studentProvider =
                                            StudentProvider();
                                        await studentProvider
                                            .removeStudent(_user.studentNumber);
                                        Navigator.of(context).pop();
                                        const SnackBar(
                                          content: Text('Successfully Removed'),
                                        );
                                      },
                                      child: Text('Yes'),
                                      color: Colors.red,
                                    ),
                                    SizedBox(
                                      width: 9,
                                    ),
                                    TextButton(
                                      child: const Text('Close'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                ),
                                //------
                              ),
                            ),
                          ),
                        );
                      },
                    );
                    //remove from db
                    // StudentProvider studentProvider = StudentProvider();
                    // studentProvider.removeStudent(_user.studentNumber);
                  }),
            ],
          ),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _userData.length;

  @override
  int get selectedRowCount => 0;

  /*
   *
   * Sorts this list according to the order specified by the [compare] function.

    The [compare] function must act as a [Comparator].

    List<String> numbers = ['two', 'three', 'four'];
// Sort from shortest to longest.
    numbers.sort((a, b) => a.length.compareTo(b.length));
    print(numbers);  // [two, four, three]
    The default List implementations use [Comparable.compare] if [compare] is omitted.

    List<int> nums = [13, 2, -11];
    nums.sort();
    print(nums);  // [-11, 2, 13] 
   */
  void sort<T>(Comparable<T> Function(Student d) getField, bool ascending) {
    _userData.sort((a, b) {
      final aValue = getField(a);
      final bValue = getField(b);
      return ascending
          ? Comparable.compare(aValue, bValue)
          : Comparable.compare(bValue, aValue);
    });

    notifyListeners();
  }
}
