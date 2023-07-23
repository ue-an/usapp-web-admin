import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:web_tut/2.0/screens/activity_log/components/user_activities_header.dart';
import 'package:web_tut/2.0/screens/activity_log/components/useractivity_search_provider.dart';
import 'package:web_tut/models/admin_activity.dart';
import 'package:web_tut/models/user_activity.dart';
import 'package:web_tut/providers/user_activity_provider.dart';

class UserActivitiesList extends StatefulWidget {
  Stream<List<UserActivity>> streamUserActivities;
  UserActivitiesList({
    Key key,
    this.streamUserActivities,
  }) : super(key: key);

  @override
  State<UserActivitiesList> createState() => _UserActivitiesListState();
}

class _UserActivitiesListState extends State<UserActivitiesList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Column(
      children: [
        UserActivitiesHeader(
          userActivities:
              context.read<UserActivitySearchProvider>().searchText == ''
                  ? context.read<UserActivityProvider>().userActivitiesResult
                  : context.read<UserActivityProvider>().filteredActivities,
        ),
        StreamBuilder<List<UserActivity>>(
          stream: widget.streamUserActivities,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasData) {
              snapshot.data.sort((a, b) => b.date.compareTo(a.date));
              // (() {
              //   context.watch<UserActivitySearchProvider>().searchText == ''
              //       ? snapshot.data.forEach((activity) {
              //           context
              //               .read<UserActivityProvider>()
              //               .userActivitiesResult
              //               .add(activity);
              //         })
              //       : snapshot.data.forEach((activity) {
              //           context
              //               .read<UserActivityProvider>()
              //               .filteredActivities
              //               .add(activity);
              //         });
              // }());
              return ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  String activityDate = DateFormat("MM-dd-yyyy")
                      .format(snapshot.data[index].date.toDate());
                  String activityTime = DateFormat("h:mma")
                      .format(snapshot.data[index].date.toDate());
                  context.watch<UserActivitySearchProvider>().searchText == ''
                      ? context
                          .read<UserActivityProvider>()
                          .userActivitiesResult
                          .add(snapshot.data[index])
                      : context
                          .read<UserActivityProvider>()
                          .filteredActivities
                          .add(snapshot.data[index]);

                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(snapshot.data[index].owner),
                          Text(snapshot.data[index].title),
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
