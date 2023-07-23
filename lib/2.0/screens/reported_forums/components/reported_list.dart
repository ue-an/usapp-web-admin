import 'package:flutter/material.dart';
import 'package:getwidget/components/checkbox/gf_checkbox.dart';
import 'package:getwidget/getwidget.dart';
import 'package:provider/provider.dart';
import 'package:web_tut/2.0/responsive.dart';
import 'package:web_tut/2.0/screens/reported_forums/components/reported_info_card.dart';
import 'package:web_tut/2.0/screens/reported_forums/components/selection_reportedforums_provider.dart';
import 'package:web_tut/models/report.dart';
import 'package:web_tut/providers/report_provider.dart';

import '../../../constants.dart';

class ReportedList extends StatefulWidget {
  Stream<List<Report>> streamReportRequests;
  ReportedList({
    Key key,
    this.streamReportRequests,
  }) : super(key: key);

  @override
  State<ReportedList> createState() => _ReportedListState();
}

class _ReportedListState extends State<ReportedList>
    with AutomaticKeepAliveClientMixin<ReportedList> {
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
            stream: widget.streamReportRequests,
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
                    const Icon(Icons.report_gmailerrorred),
                    const SizedBox(
                      width: 6,
                    ),
                    Text(
                      "Reported Forums:",
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
          mobile: ReportedForumsCardGridView(
            crossAxisCount: _size.width < 650 ? 2 : 4,
            childAspectRatio: _size.width < 650 && _size.width > 350 ? 1.3 : 1,
            streamReports: widget.streamReportRequests,
          ),
          tablet: ReportedForumsCardGridView(
            streamReports: widget.streamReportRequests,
          ),
          desktop: ReportedForumsCardGridView(
            childAspectRatio: _size.width < 1400 ? 1.1 : 1.4,
            streamReports: widget.streamReportRequests,
          ),
        ),
      ],
    );
  }
}

class ReportedForumsCardGridView extends StatefulWidget {
  Stream<List<Report>> streamReports;
  BuildContext context;
  ReportedForumsCardGridView({
    Key key,
    this.crossAxisCount = 4,
    this.childAspectRatio = 1,
    this.streamReports,
    this.context,
  }) : super(key: key);

  final int crossAxisCount;
  final double childAspectRatio;

  @override
  State<ReportedForumsCardGridView> createState() =>
      _ReportedForumsCardGridViewState();
}

class _ReportedForumsCardGridViewState extends State<ReportedForumsCardGridView>
    with AutomaticKeepAliveClientMixin<ReportedForumsCardGridView> {
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
        stream: widget.streamReports,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            snapshot.data.sort((a, b) =>
                a.isAppoved.toString().compareTo(b.isAppoved.toString()));
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
                  if (snapshot.data[index].isAppoved == false) {
                    return Stack(
                      children: [
                        GestureDetector(
                          onTap: () {
                            //set have selections to true
                            context
                                .read<SelectionReportedForumsProvider>()
                                .haveSelections = true;
                            //add selected items to a 'selection' list
                            context
                                    .read<ReportProvider>()
                                    .selectedReportRequests
                                    .contains(snapshot.data[index])
                                // ? context
                                //     .read<ReportProvider>()
                                //     .removeFromSelectedList(index)
                                // : context
                                //     .read<ReportProvider>()
                                //     .addToSelectedList(index);
                                ? context
                                    .read<ReportProvider>()
                                    .selectedReportRequests
                                    .remove(snapshot.data[index])
                                : context
                                    .read<ReportProvider>()
                                    .selectedReportRequests
                                    .add(snapshot.data[index]);
                            print(context
                                .read<ReportProvider>()
                                .selectedReportRequests);
                            //set tappedReport (only one, current forum) for viewing
                            context.read<ReportProvider>().changeTappedReport =
                                snapshot.data[index];
                          },
                          child: ReportedInfoCard(
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
                                .watch<ReportProvider>()
                                .selectedReportRequests
                                .isEmpty
                            ? Container()
                            : context
                                    .watch<ReportProvider>()
                                    .selectedReportRequests
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
