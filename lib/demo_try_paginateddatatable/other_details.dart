import 'package:flutter/material.dart';
import 'package:web_tut/demo_try_paginateddatatable/datatable_constants.dart';
import 'package:web_tut/models/student.dart';

class OtherDetails extends StatelessWidget {
  const OtherDetails({Key key, @required this.data})
      : assert(data != null),
        super(key: key);

  final Student data;

  Iterable<MapEntry<String, String>> get _fieldValues =>
      _onGenerateFields(data).entries;

  @override
  Widget build(BuildContext context) {
    //

    final _width = MediaQuery.of(context).size.width;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        CloseButton(),
        for (final _fieldValue in _fieldValues) ...[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  width: _width * 0.1,
                  child: Text(_fieldValue.key),
                ),
                SizedBox(
                  width: 18,
                ),
                SizedBox(
                  width: _width / 6,
                  child: Text(
                    _fieldValue.value,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
        ],
      ],
    );
  }

  Map<String, String> _onGenerateFields(Student data) {
    final _fieldValues = {
      DataTableConstants.colID: data.studentNumber.toString(),
      DataTableConstants.colFname: data.firstName,
      DataTableConstants.colMinitial: data.mInitial,
      DataTableConstants.colLname: data.lastName,
      DataTableConstants.colEmail: data.email,
      DataTableConstants.colCollege: data.college,
      DataTableConstants.colCourse: data.course,
      DataTableConstants.colYearLevel: data.yearLvl,
      DataTableConstants.colSection: data.section,
    };

    return _fieldValues;
  }
}
