import 'package:flutter/material.dart';
import 'package:web_tut/demo_try_paginateddatatable/customs/custom_dialog.dart';
import 'package:web_tut/demo_try_paginateddatatable/datatable_source.dart';
import 'package:web_tut/demo_try_paginateddatatable/internal_widget.dart';
import 'package:web_tut/demo_try_paginateddatatable/other_details.dart';
import 'package:web_tut/demo_try_paginateddatatable/userdata_notifier2.dart';
import 'package:web_tut/models/student.dart';

class MyPaginatedDataTable extends StatefulWidget {
  UserDataNotifier2 userDataNotifier2;
  MyPaginatedDataTable({Key key, this.userDataNotifier2}) : super(key: key);
  @override
  _MyPaginatedDataTableState createState() => _MyPaginatedDataTableState();
}

class _MyPaginatedDataTableState extends State<MyPaginatedDataTable> {
  @override
  Widget build(BuildContext context) {
    //----
    void _showDetails(BuildContext c, Student data) async =>
        await showDialog<bool>(
          context: c,
          builder: (_) => CustomDialog(
            showPadding: false,
            child: OtherDetails(data: data),
          ),
        );
    //----
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

    ScrollController advScroll = ScrollController();
    return Scaffold(
      body: SingleChildScrollView(
        controller: advScroll,
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: InternalWidget(
            userDataNotifier2: widget.userDataNotifier2,
          ),
        ),
      ),
    );
  }
}
