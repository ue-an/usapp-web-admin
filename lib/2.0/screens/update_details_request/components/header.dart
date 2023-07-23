import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:provider/provider.dart';
import 'package:web_tut/2.0/controllers/menu_controller.dart';
import 'package:web_tut/2.0/providers/drawerpage_provider.dart';
import 'package:web_tut/2.0/providers/localdata_provider.dart';
import 'package:web_tut/2.0/responsive.dart';
import 'package:web_tut/2.0/screens/update_details_request/components/selection_request.dart';
import 'package:web_tut/2.0/utils/routes2.dart';
import 'package:web_tut/models/request.dart';
import 'package:web_tut/providers/admin_activity_provider.dart';
import 'package:web_tut/providers/request_provider.dart';

import '../../../constants.dart';

class Header extends StatelessWidget {
  const Header({
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
            "List of Requests",
            style: Theme.of(context).textTheme.headline6,
          ),
        if (!Responsive.isMobile(context))
          Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
        context.watch<RequestProvider>().tappedRequest != null
            ? Row(
                children: [
                  GFButton(
                    onPressed: () {
                      context.read<RequestProvider>().changeTappedRequest =
                          null;
                    },
                    elevation: 9,
                    color: Colors.red,
                    child: const Text("Cancel"),
                  ),
                  const SizedBox(
                    width: 24,
                  ),
                  GFButton(
                    onPressed: () async {
                      await context.read<RequestProvider>().acceptRequest();
                      context.read<RequestProvider>().changeTappedRequest =
                          null;
                      //create activity
                      String myName = await context
                          .read<LocalDataProvider>()
                          .getLocalAdminName();
                      context
                          .read<AdminActivityProvider>()
                          .changeActivityTitle = 'Done update request';
                      context.read<AdminActivityProvider>().changeName = myName;
                      context.read<AdminActivityProvider>().changeDate =
                          DateTime.now();
                      await context.read<AdminActivityProvider>().addActivity();
                      //show snackbar
                      Future.delayed(const Duration(seconds: 1), () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Update done.')),
                        );
                      });
                    },
                    elevation: 9,
                    color: Colors.green,
                    child: Row(
                      children: const [
                        Icon(Icons.check),
                        SizedBox(
                          width: 12,
                        ),
                        Text("Update Done"),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 24,
                  ),
                  GFButton(
                    onPressed: () {
                      //go to students datatable
                      context
                          .read<DrawerPageProvider2>()
                          .changeDrawerPageSelected = 1;
                    },
                    elevation: 9,
                    child: const Text("Update Details Now"),
                  ),
                ],
              )
            : Container(),
      ],
    );
  }
}
