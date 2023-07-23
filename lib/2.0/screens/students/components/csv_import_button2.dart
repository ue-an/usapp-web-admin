import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:provider/provider.dart';
import 'package:web_tut/2.0/providers/localdata_provider.dart';
import 'package:web_tut/providers/admin_activity_provider.dart';
import 'package:web_tut/providers/has_import_provider.dart';
import 'package:web_tut/providers/student_provider.dart';

class CsvImportButton2 extends StatelessWidget {
  const CsvImportButton2({
    Key key,
    this.uploadedCsv,
    this.studData,
  }) : super(key: key);

  final Uint8List uploadedCsv;
  final List<String> studData;

  @override
  Widget build(BuildContext context) {
    var chunks = [];
    int chunkSize = 9;
    for (var i = 0; i < studData.length; i += chunkSize) {
      chunks.add(studData.sublist(i, min(i + chunkSize, studData.length)));
    }

    _csvToDB() {
      for (var i = 1; i < chunks.length; i++) {
        context.read<StudentProvider>().changeStudentNumber = chunks[i][0];
        context.read<StudentProvider>().changeFirstName = chunks[i][1];
        context.read<StudentProvider>().changeMInitial = chunks[i][2];
        context.read<StudentProvider>().changeLastName = chunks[i][3];
        context.read<StudentProvider>().changeEmail = chunks[i][4];
        context.read<StudentProvider>().changeCourse = chunks[i][5];
        context.read<StudentProvider>().changeYearLevel = chunks[i][6];
        context.read<StudentProvider>().changeSection = chunks[i][7];
        context.read<StudentProvider>().changeCollege =
            chunks[i][8].toString().trim();
        context.read<StudentProvider>().saveStudent();
        context.read<HasImportProvider>().changeHasImport = false;
      }
    }

    return GFButton(
      onPressed: () async {
        //create activity
        String myName =
            await context.read<LocalDataProvider>().getLocalAdminName();
        context.read<AdminActivityProvider>().changeActivityTitle =
            'Imported a CSV file';
        context.read<AdminActivityProvider>().changeName = myName;
        context.read<AdminActivityProvider>().changeDate = DateTime.now();
        await context.read<AdminActivityProvider>().addActivity();
        _csvToDB();
        context.read<HasImportProvider>().changeHasImport = false;
      },
      elevation: 9,
      color: Colors.green,
      child: Row(
        children: [
          Image.asset(
            'assets/images/ic_import-csv-24.png',
          ),
          const SizedBox(
            width: 12,
          ),
          const Text("Import File"),
        ],
      ),
    );
  }
}
