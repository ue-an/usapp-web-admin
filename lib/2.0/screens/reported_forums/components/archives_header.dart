import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:provider/provider.dart';
import 'package:web_tut/2.0/controllers/menu_controller.dart';
import 'package:web_tut/2.0/providers/drawerpage_provider.dart';
import 'package:web_tut/2.0/providers/localdata_provider.dart';
import 'package:web_tut/2.0/responsive.dart';
import 'package:web_tut/2.0/screens/reported_forums/components/selection_archived_forums_provider.dart';
import 'package:web_tut/2.0/screens/reported_forums/components/selection_reportedforums_provider.dart';
import 'package:web_tut/2.0/utils/routes2.dart';
import 'package:web_tut/providers/admin_activity_provider.dart';
import 'package:web_tut/providers/archive_report_provider.dart';
import 'package:web_tut/providers/report_provider.dart';

import '../../../constants.dart';

class ArchivesHeader extends StatelessWidget {
  const ArchivesHeader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
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
            "List of Archived Forums",
            style: Theme.of(context).textTheme.headline6,
          ),
        if (!Responsive.isMobile(context))
          Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
        context
                .watch<ArchiveReportProvider>()
                .selectedArchivedReports
                .isNotEmpty
            // .watch<SelectionReportedForumsProvider>().haveSelections == true
            ? Row(
                children: [
                  GFButton(
                    onPressed: () {
                      //set have selections to false
                      context
                          .read<SelectionArchivedForumsProvider>()
                          .haveSelections = false;
                      //clear selected list
                      context
                          .read<ArchiveReportProvider>()
                          .changeSelectedAchivedReports = [];
                    },
                    elevation: 9,
                    child: const Text("Cancel"),
                  ),
                  const SizedBox(
                    width: 24,
                  ),
                  GFButton(
                    onPressed: () async {
                      await context
                          .read<ArchiveReportProvider>()
                          .unApproveReportThread();
                      await context
                          .read<ArchiveReportProvider>()
                          .unApproveReport();
                      context
                          .read<SelectionArchivedForumsProvider>()
                          .haveSelections = false;
                      context
                          .read<ArchiveReportProvider>()
                          .changeSelectedAchivedReports = [];
                      //show snackbar
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Successfully unarchived.')),
                      );
                      //create activity
                      String myName = await context
                          .read<LocalDataProvider>()
                          .getLocalAdminName();
                      context
                          .read<AdminActivityProvider>()
                          .changeActivityTitle = 'Unarchived a reported forum';
                      context.read<AdminActivityProvider>().changeName = myName;
                      context.read<AdminActivityProvider>().changeDate =
                          DateTime.now();
                      await context.read<AdminActivityProvider>().addActivity();
                    },
                    elevation: 9,
                    color: Colors.red,
                    child: Row(
                      children: const [
                        Icon(Icons.unarchive_outlined),
                        SizedBox(
                          width: 12,
                        ),
                        Text("Unarchive Forum"),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 24,
                  ),
                  context
                              .watch<ArchiveReportProvider>()
                              .selectedArchivedReports
                              .length >
                          1
                      ? Container()
                      : GFButton(
                          onPressed: () async {
                            //create activity
                            String myName = await context
                                .read<LocalDataProvider>()
                                .getLocalAdminName();
                            context
                                    .read<AdminActivityProvider>()
                                    .changeActivityTitle =
                                'Viewed an archived forum';
                            context.read<AdminActivityProvider>().changeName =
                                myName;
                            context.read<AdminActivityProvider>().changeDate =
                                DateTime.now();
                            await context
                                .read<AdminActivityProvider>()
                                .addActivity();
                            Future.delayed(const Duration(milliseconds: 300),
                                () {
                              // Navigator.of(context)
                              //     .pushNamed(Routes2.viewarchiveforum);
                              context
                                  .read<DrawerPageProvider2>()
                                  .changeDrawerPageSelected = 12;
                            });
                          },
                          elevation: 9,
                          child: const Text("View Forum"),
                        )
                ],
              )
            : Container(),
      ],
    );
  }
}
