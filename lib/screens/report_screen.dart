import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:provider/src/provider.dart';
import 'package:web_tut/models/report.dart';
import 'package:web_tut/models/thread.dart';
import 'package:web_tut/providers/report_provider.dart';
import 'package:web_tut/utils/constants.dart';
import 'package:intl/intl.dart';
import 'package:web_tut/utils/routes.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final reportProvider = ReportProvider();
    return Scaffold(
      body: StreamBuilder<List<Report>>(
        stream: reportProvider.reports,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            int pendingsTotal;
            return Row(
              children: [
                Container(
                  height: double.infinity,
                  width: size.width / 1.5,
                  color: kPrimaryColor.withOpacity(0.5),
                  child: ListView.builder(
                      physics: AlwaysScrollableScrollPhysics(),
                      shrinkWrap: true,
                      // reverse: true,
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        if (snapshot.data[index].isAppoved == false &&
                            snapshot.data[index].thrTitle != '') {
                          pendingsTotal = snapshot.data.length;
                          DateTime myDateTime =
                              snapshot.data[index].reportDate.toDate();
                          String formattedDate =
                              DateFormat('yyyy-MM-dd (EEE)').format(myDateTime);
                          //----------
                          context
                              .read<ReportProvider>()
                              .pendingReports
                              .add(snapshot.data[index]);
                          context.read<ReportProvider>().changeReportsTotal =
                              context
                                  .read<ReportProvider>()
                                  .pendingReports
                                  .length;

                          return GestureDetector(
                            onTap: () {
                              // context
                              //     .read<ReportProvider>()
                              //     .changeTappedReport = snapshot.data[index];
                            },
                            child: Column(
                              children: [
                                ListTile(
                                  title: Text(
                                    snapshot.data[index].thrTitle.toUpperCase(),
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  // title: Text(''),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 9,
                                      ),
                                      Text(
                                        'Report count: ' +
                                            snapshot.data[index].reportCount
                                                .toString(),
                                        style: TextStyle(
                                          color: Colors.white60,
                                        ),
                                      ),
                                      Text(
                                        'Date reported: ' + formattedDate,
                                        style: TextStyle(
                                          color: Colors.white60,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Divider(
                                  indent: size.width / 10,
                                  endIndent: size.width / 10,
                                  thickness: 1,
                                ),
                              ],
                            ),
                          );
                        } else {
                          if (snapshot.data.isNotEmpty == true) {
                            return Container();
                          }
                          return Column(
                            children: [
                              ListView(
                                shrinkWrap: true,
                                children: [
                                  ListTile(
                                    title: Text(
                                      'ヾ( ⌒_⌒ )ノ',
                                      textAlign: TextAlign.center,
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Woohoo! No reported threads',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
                        }
                      }),
                ),
                Container(
                  height: double.infinity,
                  width: size.width / 5.4,
                  color: Colors.white,
                  child: Center(
                    child: ListView.builder(
                        physics: AlwaysScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: context
                                    .read<ReportProvider>()
                                    .pendingReports
                                    .length ==
                                0
                            ? 1
                            : 1,
                        itemBuilder: (context, index) {
                          if (context
                                  .watch<ReportProvider>()
                                  .pendingReports
                                  .length ==
                              0) {
                            return Column(
                              children: [
                                ListView(
                                  shrinkWrap: true,
                                  children: [
                                    ListTile(
                                      title: Text(
                                        'ヾ( ⌒_⌒ )ノ',
                                        textAlign: TextAlign.center,
                                      ),
                                      subtitle: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Woohoo! No reported threads',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          } else {
                            return Column(children: [
                              SizedBox(
                                height: size.height / 40,
                              ),
                              context.watch<ReportProvider>().tappedReport ==
                                      null
                                  ? Text('Choose a thread to view')
                                  : ListView(
                                      shrinkWrap: true,
                                      children: [
                                        ListTile(
                                          title: Text(context
                                              .read<ReportProvider>()
                                              .tappedReport
                                              .thrTitle
                                              .toUpperCase()),
                                          subtitle: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text('thread by: ' +
                                                  context
                                                      .read<ReportProvider>()
                                                      .tappedReport
                                                      .thrCreatorName +
                                                  '\n'),
                                              Text(
                                                'Users who reported',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  left: 12,
                                                ),
                                                child: Text(context
                                                        .read<ReportProvider>()
                                                        .tappedReport
                                                        .reporters
                                                        .toString() +
                                                    '\n'),
                                              ),
                                              Text(
                                                'Reported violations',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  left: 12,
                                                ),
                                                child: Text(context
                                                    .read<ReportProvider>()
                                                    .tappedReport
                                                    .reasons
                                                    .toString()),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                            top: size.height / 4,
                                            left: size.width / 30,
                                            right: size.width / 30,
                                          ),
                                          child: GFButton(
                                            onPressed: () async {
                                              await context
                                                  .read<ReportProvider>()
                                                  .approveReport();
                                              await context
                                                  .read<ReportProvider>()
                                                  .reportThread();
                                            },
                                            child: Text('Approve report'),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                            left: size.width / 30,
                                            right: size.width / 30,
                                          ),
                                          child: GFButton(
                                            onPressed: () {
                                              Navigator.of(context)
                                                  .pushNamed(Routes.viewthread);
                                              // print(context
                                              //     .read<ReportProvider>()
                                              //     .tappedReport
                                              //     .thrID);
                                              // showDialog(
                                              //     context: context,
                                              //     barrierDismissible: false,
                                              //     builder:
                                              //         (BuildContext context) {
                                              //       return AlertDialog(
                                              //         shape: RoundedRectangleBorder(
                                              //             borderRadius:
                                              //                 BorderRadius.all(
                                              //                     Radius.circular(
                                              //                         20.0))),
                                              //         content: Padding(
                                              //           padding:
                                              //               const EdgeInsets
                                              //                   .all(8.0),
                                              //           child: Column(
                                              //             mainAxisSize:
                                              //                 MainAxisSize.min,
                                              //             children: <Widget>[
                                              //               Padding(
                                              //                 padding:
                                              //                     const EdgeInsets
                                              //                         .all(8.0),
                                              //                 child:
                                              //               ),
                                              //               Padding(
                                              //                 padding:
                                              //                     const EdgeInsets
                                              //                         .all(8.0),
                                              //                 child: Row(
                                              //                   mainAxisAlignment:
                                              //                       MainAxisAlignment
                                              //                           .spaceEvenly,
                                              //                   children: <
                                              //                       Widget>[
                                              //                     Padding(
                                              //                       padding:
                                              //                           const EdgeInsets.all(
                                              //                               8.0),
                                              //                       child:
                                              //                           RaisedButton(
                                              //                         color:
                                              //                             kPrimaryColor,
                                              //                         shape: RoundedRectangleBorder(
                                              //                             borderRadius:
                                              //                                 BorderRadius.all(Radius.circular(2.0))),
                                              //                         child:
                                              //                             Text(
                                              //                           "Close",
                                              //                           style:
                                              //                               TextStyle(
                                              //                             color:
                                              //                                 Colors.white,
                                              //                           ),
                                              //                         ),
                                              //                         onPressed:
                                              //                             () {
                                              //                           Navigator.of(context)
                                              //                               .pop();
                                              //                         },
                                              //                       ),
                                              //                     ),
                                              //                   ],
                                              //                 ),
                                              //               ),
                                              //             ],
                                              //           ),
                                              //         ),
                                              //       );
                                              //     });
                                            },
                                            child: Text('View thread'),
                                          ),
                                        ),
                                      ],
                                    )
                            ]);
                          }

                          // }
                          // return const Center(
                          //   child: Text(''),
                          // );
                        }),
                  ),
                ),
              ],
            );
          }
          if (!snapshot.hasData) {
            return Center(
              child: Text('look at me'),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Center(
              child: Text('no data'),
            );
          }
        },
      ),
    );
  }
}
