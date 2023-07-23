import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:web_tut/2.0/screens/activity_log/components/admin_activities_header.dart';
import 'package:web_tut/2.0/screens/activity_log/components/adminactivities_search_provider.dart';
import 'package:web_tut/models/admin_activity.dart';
import 'package:web_tut/providers/actlog_daterange_provider.dart';
import 'package:web_tut/providers/admin_activity_provider.dart';

class AdminActivitiesList extends StatefulWidget {
  Stream<List<AdminActivity>> streamAdminActivities;
  BuildContext context;
  AdminActivitiesList({
    Key key,
    this.streamAdminActivities,
    this.context,
  }) : super(key: key);

  @override
  State<AdminActivitiesList> createState() => _AdminActivitiesListState();
}

class _AdminActivitiesListState extends State<AdminActivitiesList> {
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Column(
      children: [
        AdminActivitiesHeader(
          adminActivities: widget.context
                      .watch<AdminActivitySearchProvider>()
                      .searchText ==
                  ''
              ? widget.context
                  .read<AdminActivityProvider>()
                  .adminActivitiesResult
              : widget.context.read<AdminActivityProvider>().filteredActivities,
        ),
        StreamBuilder<List<AdminActivity>>(
          stream: widget.streamAdminActivities,
          builder: (context, snapshot) {
            // List<AdminActivity> filteredRecords = [];
            String rangeStart =
                context.read<ActivityLogDateRangeProvider>().start;
            String rangeEnd = context.read<ActivityLogDateRangeProvider>().end;
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasData) {
              snapshot.data.sort((a, b) => b.date.compareTo(a.date));
              //filter data according to date range selected (from, to)
              // (() {
              //   context.watch<AdminActivitySearchProvider>().searchText == ''
              //       ? snapshot.data.forEach((activity) {
              //           context
              //               .read<AdminActivityProvider>()
              //               .adminActivitiesResult
              //               .add(activity);
              //         })
              //       : snapshot.data.forEach((activity) {
              //           context
              //               .read<AdminActivityProvider>()
              //               .filteredActivities
              //               .add(activity);
              //         });
              // }());
              //-----
              //  context.watch<AdminActivitySearchProvider>().searchText == ''
              //       ? snapshot.data.forEach((activity) {
              //           if (context
              //               .read<AdminActivityProvider>()
              //               .adminActivitiesResult
              //               .isNotEmpty) {
              //             context
              //                 .read<AdminActivityProvider>()
              //                 .changeadminActivitiesResult = [];
              //           }
              //           context
              //               .read<AdminActivityProvider>()
              //               .adminActivitiesResult
              //               .add(activity);
              //         })
              //       : snapshot.data.forEach((activity) {
              //         if (context
              //               .read<AdminActivityProvider>()
              //               .filteredActivities
              //               .isNotEmpty) {
              //             context
              //                 .read<AdminActivityProvider>()
              //                 .changefilteredActivities = [];
              //           }
              //           context
              //               .read<AdminActivityProvider>()
              //               .filteredActivities
              //               .add(activity);

              return ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  String activityDate = DateFormat("MM-dd-yyyy")
                      .format(snapshot.data[index].date.toDate());
                  String activityTime = DateFormat("h:mma")
                      .format(snapshot.data[index].date.toDate());
                  context.watch<AdminActivitySearchProvider>().searchText == ''
                      ? context
                          .read<AdminActivityProvider>()
                          .adminActivitiesResult
                          .add(snapshot.data[index])
                      : context
                          .read<AdminActivityProvider>()
                          .filteredActivities
                          .add(snapshot.data[index]);

                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(snapshot.data[index].email),
                          Text(snapshot.data[index].activityTitle),
                          Text(activityDate.toString()),
                          Text(activityTime.toString()),
                          Container(),
                        ],
                      ),
                      const Divider(),
                    ],
                  );
                },
              );
            } else {
              return Container(
                child: Text('no data'),
              );
            }
          },
        ),
      ],
    );
  }
}
