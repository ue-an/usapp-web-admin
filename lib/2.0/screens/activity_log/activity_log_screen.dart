import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_tut/2.0/constants.dart';
import 'package:web_tut/2.0/controllers/menu_controller.dart';
import 'package:web_tut/2.0/responsive.dart';
import 'package:web_tut/2.0/screens/activity_log/components/admin_activities_list.dart';
import 'package:web_tut/2.0/screens/activity_log/components/adminactivities_search_provider.dart';
import 'package:web_tut/2.0/screens/activity_log/components/logtype_dropdown.dart';
import 'package:web_tut/2.0/screens/activity_log/components/logtype_provider.dart';
import 'package:web_tut/2.0/screens/activity_log/components/user_activities_list.dart';
import 'package:web_tut/2.0/screens/activity_log/components/useractivity_search_provider.dart';
import 'package:web_tut/models/admin_activity.dart';
import 'package:web_tut/models/user_activity.dart';
import 'package:web_tut/services/firestore_service.dart';
import 'package:web_tut/utils/constants.dart';

class ActivityLogScreen extends StatefulWidget {
  const ActivityLogScreen({Key key}) : super(key: key);

  @override
  State<ActivityLogScreen> createState() => _ActivityLogScreenState();
}

class _ActivityLogScreenState extends State<ActivityLogScreen>
    with AutomaticKeepAliveClientMixin<ActivityLogScreen> {
  bool _isVisited = false;
  @override
  bool get wantKeepAlive => _isVisited;
  FirestoreService firestoreService = FirestoreService();
  Stream<List<AdminActivity>> _streamActivities;
  Stream<List<UserActivity>> _streamActivities2;
  final scroll = ScrollController();
  final scroll2 = ScrollController();
  final scroll3 = ScrollController();
  @override
  void initState() {
    _streamActivities = firestoreService.getAdminActivities();
    _streamActivities2 = firestoreService.getUserActivities();
    setState(() {
      _isVisited = true;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          controller: scroll3,
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  if (!Responsive.isDesktop(context))
                    IconButton(
                      icon: const Icon(Icons.menu),
                      // onPressed: context.read<MenuController>().controlMenu,
                      onPressed: () {
                        context.read<MenuController>().isClicked = true;
                        context.read<MenuController>().isClicked == true
                            ? Scaffold.of(context).openDrawer()
                            : null;
                      },
                    ),
                  if (!Responsive.isMobile(context))
                    Text(
                      "List of Activities",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  if (!Responsive.isMobile(context))
                    Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
                  const LogTypeDropDown(),
                ],
              ),
              context.watch<LogTypeProvider>().selectedLogtype ==
                      'Administrator'
                  ? SingleChildScrollView(
                      controller: scroll,
                      padding: const EdgeInsets.all(defaultPadding),
                      child: Column(
                        children: [
                          const SizedBox(height: defaultPadding),
                          AdminActivitiesList(
                            streamAdminActivities: context
                                        .watch<AdminActivitySearchProvider>()
                                        .searchText ==
                                    ''
                                ? _streamActivities
                                : context
                                    .read<AdminActivitySearchProvider>()
                                    .searchedAdminActivities,
                            context: context,
                          ),
                          Container(),
                        ],
                      ),
                    )
                  : SingleChildScrollView(
                      controller: scroll2,
                      padding: const EdgeInsets.all(defaultPadding),
                      child: Column(
                        children: [
                          const SizedBox(height: defaultPadding),
                          UserActivitiesList(
                            streamUserActivities: context
                                        .watch<UserActivitySearchProvider>()
                                        .searchText ==
                                    ''
                                ? _streamActivities2
                                : context
                                    .read<UserActivitySearchProvider>()
                                    .searchedUserActivities,
                          ),
                          // Container(),
                        ],
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
