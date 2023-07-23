import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:web_tut/2.0/models/recent_file.dart';
import 'package:web_tut/2.0/screens/dashboard/components/students_datatable_source.dart';
import 'package:web_tut/models/student.dart';

import '../../../constants.dart';

class RecentFiles extends StatefulWidget {
  Stream<List<Student>> streamStudents;
  RecentFiles({
    Key key,
    this.streamStudents,
  }) : super(key: key);

  @override
  State<RecentFiles> createState() => _RecentFilesState();
}

class _RecentFilesState extends State<RecentFiles> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      decoration: const BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: StreamBuilder<List<Student>>(
          stream: widget.streamStudents,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasData) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Students Records",
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      const Icon(Icons.assignment_ind),
                    ],
                  ),
                  // SizedBox(
                  //   width: double.infinity,
                  //   child: DataTable2(
                  //     columnSpacing: defaultPadding,
                  //     minWidth: 600,
                  //     columns: const [
                  //       DataColumn(
                  //         label: Text("File Name"),
                  //       ),
                  //       DataColumn(
                  //         label: Text("Date"),
                  //       ),
                  //       DataColumn(
                  //         label: Text("Size"),
                  //       ),
                  //     ],
                  //     rows: List.generate(
                  //       demoRecentFiles.length,
                  //       (index) => recentFileDataRow(demoRecentFiles[index]),
                  //     ),
                  //   ),
                  // ),
                ],
              );
            } else {
              return Container(
                child: Text('no data'),
              );
            }
          }),
    );
  }
}

DataRow recentFileDataRow(RecentFile fileInfo) {
  return DataRow(
    cells: [
      DataCell(
        Row(
          children: [
            Image.asset(
              fileInfo.icon,
              height: 30,
              width: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Text(fileInfo.title),
            ),
          ],
        ),
      ),
      DataCell(Text(fileInfo.date)),
      DataCell(Text(fileInfo.size)),
    ],
  );
}
