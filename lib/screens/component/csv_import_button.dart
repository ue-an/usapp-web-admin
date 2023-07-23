import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:provider/provider.dart';
import 'package:web_tut/providers/has_import_provider.dart';
import 'package:web_tut/providers/student_provider.dart';

class CsvImportButton extends StatelessWidget {
  const CsvImportButton({
    Key key,
    this.uploadedCsv,
    this.studData,
  }) : super(key: key);

  final Uint8List uploadedCsv;
  final List<String> studData;

  @override
  Widget build(BuildContext context) {
    var chunks = [];
    int chunkSize = 8;
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

    return Column(
      children: [
        // for (var i = 0; i < chunks.length; i++) Text(chunks[i].toString()),
        context.watch<HasImportProvider>().hasImport
            ? GFButton(
                onPressed: () {
                  _csvToDB();
                },
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Add Selected CSV Import"),
                ),
                color: Colors.green,
                shape: GFButtonShape.pills)
            : Container(),
      ],
    );
  }
}
