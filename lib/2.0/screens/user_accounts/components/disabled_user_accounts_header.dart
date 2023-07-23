import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:provider/provider.dart';
import 'package:web_tut/2.0/controllers/menu_controller.dart';
import 'package:web_tut/2.0/providers/localdata_provider.dart';
import 'package:web_tut/2.0/responsive.dart';
import 'package:web_tut/providers/admin_activity_provider.dart';
import 'package:web_tut/providers/admin_provider.dart';
import 'package:web_tut/providers/user_account_provider.dart';

class DisabledUserAccountsHeader extends StatelessWidget {
  const DisabledUserAccountsHeader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
            "List of Disabled Client User Accounts",
            style: Theme.of(context).textTheme.headline6,
          ),
        if (!Responsive.isMobile(context))
          Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
        context.watch<UserAccountProvider>().tappedDisabledAccount == null
            ? Container()
            : GFButton(
                onPressed: () async {
                  await context.read<UserAccountProvider>().enableUserAccount();
                  //show snackbar
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Account enabled.')),
                  );
                  context
                      .read<UserAccountProvider>()
                      .changeTappedDisabledAccount = null;
                  //create activity
                  String myName = await context
                      .read<LocalDataProvider>()
                      .getLocalAdminName();
                  context.read<AdminActivityProvider>().changeActivityTitle =
                      'Enabled a user account';
                  context.read<AdminActivityProvider>().changeName = myName;
                  context.read<AdminActivityProvider>().changeDate =
                      DateTime.now();
                  context.read<AdminActivityProvider>().addActivity();
                },
                color: Colors.green,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    Icon(Icons.mobile_friendly_sharp),
                    Text('Enable Account')
                  ],
                ),
              ),
      ],
    );
  }
}
