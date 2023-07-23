import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:provider/src/provider.dart';
import 'package:web_tut/demo_try_paginateddatatable/customs/custom_dialog.dart';
import 'package:web_tut/demo_try_paginateddatatable/customs/custom_paginated_datatable.dart';
import 'package:web_tut/demo_try_paginateddatatable/datatable_constants.dart';
import 'package:web_tut/demo_try_paginateddatatable/datatable_source.dart';
import 'package:web_tut/demo_try_paginateddatatable/other_details.dart';
import 'package:web_tut/demo_try_paginateddatatable/userdata_notifier2.dart';
import 'package:web_tut/models/student.dart';
import 'package:web_tut/utils/constants.dart';

class InternalWidget extends StatelessWidget {
  UserDataNotifier2 userDataNotifier2;
  InternalWidget({
    Key key,
    this.userDataNotifier2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //
    // final _provider = context.watch<UserDataNotifier2>();
    // final _model = _provider.userModel;
    final _provider = userDataNotifier2;
    final List<Student> _model = [];

    if (_model.isEmpty) {
      return const SizedBox.shrink();
    }
    final _dtSource = UserDataTableSource(
      onRowSelect: (index) => _showDetails(context, _model[index]),
      userData: _model,
      context: context,
    );

    return CustomPaginatedTable(
      actions: <IconButton>[
        IconButton(
          splashColor: Colors.transparent,
          icon: const Icon(Icons.refresh),
          onPressed: () {
            _provider.fetchData();
            _showSBar(context, DataTableConstants.refresh);
          },
        ),
      ],
      dataColumns: _colGen(_dtSource, _provider),
      header: const Text(DataTableConstants.users),
      onRowChanged: (index) => _provider.rowsPerPage = index,
      rowsPerPage: _provider.rowsPerPage,
      showActions: true,
      source: _dtSource,
      sortColumnIndex: _provider.sortColumnIndex,
      sortColumnAsc: _provider.sortAscending,
      // showCheckbox: true,
    );
  }

  List<DataColumn> _colGen(
    UserDataTableSource _src,
    UserDataNotifier2 _provider,
  ) =>
      <DataColumn>[
        DataColumn(
          label: Text(DataTableConstants.colID),
          numeric: true,
          tooltip: DataTableConstants.colID,
          onSort: (colIndex, asc) {
            _sort<num>((user) => int.parse(user.studentNumber), colIndex, asc,
                _src, _provider);
          },
        ),
        // DataColumn(
        //   label: Text('Photo'),
        //   tooltip: 'Photo',
        // ),
        DataColumn(
          label: Text(DataTableConstants.colFname),
          tooltip: DataTableConstants.colFname,
          onSort: (colIndex, asc) {
            _sort<String>(
                (user) => user.firstName, colIndex, asc, _src, _provider);
          },
        ),
        DataColumn(
          label: Text(DataTableConstants.colMinitial),
          tooltip: DataTableConstants.colEmail,
          onSort: (colIndex, asc) {
            _sort<String>(
                (user) => user.mInitial, colIndex, asc, _src, _provider);
          },
        ),
        DataColumn(
          label: Text(DataTableConstants.colLname),
          tooltip: DataTableConstants.colLname,
          onSort: (colIndex, asc) {
            _sort<String>(
                (user) => user.lastName, colIndex, asc, _src, _provider);
          },
        ),
        DataColumn(
          label: Text(DataTableConstants.colEmail),
          tooltip: DataTableConstants.colEmail,
          onSort: (colIndex, asc) {
            _sort<String>((user) => user.email, colIndex, asc, _src, _provider);
          },
        ),
        DataColumn(
          label: Text(DataTableConstants.colCourse),
          tooltip: DataTableConstants.colCourse,
          onSort: (colIndex, asc) {
            _sort<String>(
                (user) => user.course, colIndex, asc, _src, _provider);
          },
        ),
        DataColumn(
          label: Text(DataTableConstants.colYearLevel),
          tooltip: DataTableConstants.colYearLevel,
          onSort: (colIndex, asc) {
            _sort<String>((user) => user.yearLvl.toString(), colIndex, asc,
                _src, _provider);
          },
        ),
        DataColumn(
          label: Text(DataTableConstants.colSection),
          tooltip: DataTableConstants.colSection,
          onSort: (colIndex, asc) {
            _sort<String>((user) => user.section.toString(), colIndex, asc,
                _src, _provider);
          },
        ),
        DataColumn(
          label: Text(DataTableConstants.colCollege),
          tooltip: DataTableConstants.colCollege,
          onSort: (colIndex, asc) {
            _sort<String>(
                (user) => user.college, colIndex, asc, _src, _provider);
          },
        ),
        DataColumn(
          label: Text(DataTableConstants.otherDetails),
          tooltip: DataTableConstants.otherDetails,
        ),
      ];

  void _sort<T>(
    Comparable<T> Function(Student user) getField,
    int colIndex,
    bool asc,
    UserDataTableSource _src,
    UserDataNotifier2 _provider,
  ) {
    _src.sort<T>(getField, asc);
    _provider.sortAscending = asc;
    _provider.sortColumnIndex = colIndex;
  }

  void _showSBar(BuildContext c, String textToShow) {
    ScaffoldMessenger.of(c).showSnackBar(
      SnackBar(
        content: Text(textToShow),
        duration: const Duration(milliseconds: 2000),
      ),
    );
  }

  void _showDetails(BuildContext context, Student data) async =>
      await showDialog<bool>(
        context: context,
        barrierDismissible: false,
        builder: (_) => CustomDialog(
          child: OtherDetails(data: data),
          studentdata: data,
        ),
      );
}
