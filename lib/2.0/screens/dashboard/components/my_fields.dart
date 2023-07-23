import 'package:flutter/material.dart';
import 'package:web_tut/2.0/models/my_files.dart';
import 'package:web_tut/2.0/responsive.dart';
import 'package:web_tut/models/thread.dart';

import '../../../constants.dart';
import 'file_info_card.dart';
import 'package:intl/intl.dart';

class MyFiles extends StatelessWidget {
  Stream<List<Thread>> streamThreads;
  MyFiles({
    Key key,
    this.streamThreads,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "List of All Forums",
              style: Theme.of(context).textTheme.subtitle1,
            ),
            const SizedBox(
              width: 6,
            ),
            const Icon(Icons.list_alt_outlined)
          ],
        ),
        const SizedBox(height: defaultPadding),
        Responsive(
          mobile: FileInfoCardGridView(
            crossAxisCount: _size.width < 650 ? 2 : 4,
            childAspectRatio: _size.width < 650 && _size.width > 350 ? 1.3 : 1,
            streamThreads: streamThreads,
          ),
          tablet: FileInfoCardGridView(
            streamThreads: streamThreads,
          ),
          desktop: FileInfoCardGridView(
            childAspectRatio: _size.width < 1400 ? 1.1 : 1.4,
            streamThreads: streamThreads,
          ),
        ),
      ],
    );
  }
}

class FileInfoCardGridView extends StatelessWidget {
  Stream<List<Thread>> streamThreads;
  FileInfoCardGridView({
    Key key,
    this.crossAxisCount = 4,
    this.childAspectRatio = 1,
    this.streamThreads,
  }) : super(key: key);

  final int crossAxisCount;
  final double childAspectRatio;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Thread>>(
        stream: streamThreads,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: snapshot.data.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: defaultPadding,
                  mainAxisSpacing: defaultPadding,
                  childAspectRatio: childAspectRatio,
                ),
                itemBuilder: (context, index) {
                  DateTime myDateTime = snapshot.data[index].tSdate.toDate();
                  String formattedDate =
                      DateFormat('yyyy-MM-dd – KK:mm a (EEE)')
                          .format(myDateTime);
                  return FileInfoCard(
                      info: CloudStorageInfo(
                    thrTitle: snapshot.data[index].title,
                    thrCollege: snapshot.data[index].college,
                    thrAuthor: snapshot.data[index].creatorName,
                    authorSection: snapshot.data[index].creatorSection,
                    createDate: formattedDate,
                    msgSent: snapshot.data[index].msgSent,
                    likes: snapshot.data[index].likers.length,
                    color: Colors.amber,
                  ));
                });
          } else {
            return Container(
              child: Text('No data'),
            );
          }
        });
  }
}
