import 'package:flutter/material.dart';
import 'package:getwidget/components/checkbox/gf_checkbox.dart';
import 'package:getwidget/getwidget.dart';
import 'package:provider/provider.dart';
import 'package:web_tut/2.0/responsive.dart';
import 'package:web_tut/2.0/screens/reported_forums/components/archives_info_card.dart';
import 'package:web_tut/2.0/screens/reported_forums/components/selection_archived_forums_provider.dart';
import 'package:web_tut/models/report.dart';
import 'package:web_tut/providers/archive_report_provider.dart';

import '../../../constants.dart';

class ArchivesList extends StatefulWidget {
  Stream<List<Report>> streamArchivedReports;
  ArchivesList({
    Key key,
    this.streamArchivedReports,
  }) : super(key: key);

  @override
  State<ArchivesList> createState() => _ArchivesListState();
}

class _ArchivesListState extends State<ArchivesList>
    with AutomaticKeepAliveClientMixin<ArchivesList> {
  bool _isVisited = false;
  @override
  bool get wantKeepAlive => _isVisited;
  @override
  void initState() {
    setState(() {
      _isVisited = true;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Column(
      children: [
        StreamBuilder<List<Report>>(
            stream: widget.streamArchivedReports,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasData) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(Icons.archive_outlined),
                    const SizedBox(
                      width: 6,
                    ),
                    Text(
                      "Archived Forums:",
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    // Text(' (' + snapshot.data.length.toString() + ')'),
                  ],
                );
              } else {
                return Container();
              }
            }),
        const SizedBox(height: defaultPadding),
        Responsive(
          mobile: ReportedForums2CardGridView(
            crossAxisCount: _size.width < 650 ? 2 : 4,
            childAspectRatio: _size.width < 650 && _size.width > 350 ? 1.3 : 1,
            streamArchivedReports: widget.streamArchivedReports,
          ),
          tablet: ReportedForums2CardGridView(
            streamArchivedReports: widget.streamArchivedReports,
          ),
          desktop: ReportedForums2CardGridView(
            childAspectRatio: _size.width < 1400 ? 1.1 : 1.4,
            streamArchivedReports: widget.streamArchivedReports,
          ),
        ),
      ],
    );
  }
}

class ReportedForums2CardGridView extends StatefulWidget {
  Stream<List<Report>> streamArchivedReports;
  BuildContext context;
  ReportedForums2CardGridView({
    Key key,
    this.crossAxisCount = 4,
    this.childAspectRatio = 1,
    this.streamArchivedReports,
    this.context,
  }) : super(key: key);

  final int crossAxisCount;
  final double childAspectRatio;

  @override
  State<ReportedForums2CardGridView> createState() =>
      _ReportedForums2CardGridViewState();
}

class _ReportedForums2CardGridViewState
    extends State<ReportedForums2CardGridView>
    with AutomaticKeepAliveClientMixin<ReportedForums2CardGridView> {
  bool _isVisited = false;
  @override
  bool get wantKeepAlive => _isVisited;
  @override
  void initState() {
    setState(() {
      _isVisited = true;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext contexts) {
    return StreamBuilder<List<Report>>(
        stream: widget.streamArchivedReports,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            snapshot.data.sort((a, b) =>
                b.isAppoved.toString().compareTo(a.isAppoved.toString()));
            return GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: snapshot.data.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: widget.crossAxisCount,
                  crossAxisSpacing: defaultPadding,
                  mainAxisSpacing: defaultPadding,
                  childAspectRatio: widget.childAspectRatio,
                ),
                itemBuilder: (context, index) {
                  if (snapshot.data[index].isAppoved == true) {
                    return Stack(
                      children: [
                        GestureDetector(
                          onTap: () {
                            //set have selections to true
                            context
                                .read<SelectionArchivedForumsProvider>()
                                .haveSelections = true;
                            //add selected items to a 'selection' list
                            context
                                    .read<ArchiveReportProvider>()
                                    .selectedArchivedReports
                                    .contains(snapshot.data[index])
                                // ? context
                                //     .read<ReportProvider>()
                                //     .removeFromSelectedList(index)
                                // : context
                                //     .read<ReportProvider>()
                                //     .addToSelectedList(index);
                                ? context
                                    .read<ArchiveReportProvider>()
                                    .selectedArchivedReports
                                    .remove(snapshot.data[index])
                                : context
                                    .read<ArchiveReportProvider>()
                                    .selectedArchivedReports
                                    .add(snapshot.data[index]);
                            print(context
                                .read<ArchiveReportProvider>()
                                .selectedArchivedReports);
                            //set tappedReport (only one, current forum) for viewing
                            context
                                .read<ArchiveReportProvider>()
                                .changeTappedReport = snapshot.data[index];
                          },
                          child: ArchivesInfoCard(
                            info: Report(
                              isAppoved: snapshot.data[index].isAppoved,
                              reporters: snapshot.data[index].reporters,
                              reasons: snapshot.data[index].reasons,
                              thrCreatorName:
                                  snapshot.data[index].thrCreatorName,
                              reportCount: snapshot.data[index].reportCount,
                              thrID: snapshot.data[index].thrID,
                              thrCreatorID: snapshot.data[index].thrCreatorID,
                              reportDate: snapshot.data[index].reportDate,
                              thrTitle: snapshot.data[index].thrTitle,
                            ),
                          ),
                        ),
                        context
                                .watch<ArchiveReportProvider>()
                                .selectedArchivedReports
                                .isEmpty
                            ? Container()
                            : context
                                    .watch<ArchiveReportProvider>()
                                    .selectedArchivedReports
                                    .contains(snapshot.data[index])
                                ? const Icon(Icons.check_box)
                                : const Icon(Icons.check_box_outline_blank),
                      ],
                    );
                  } else {
                    return Container();
                  }
                });
          } else {
            return Container(
              child: const Text('No data'),
            );
          }
        });
  }
}
