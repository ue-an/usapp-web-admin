import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:web_tut/2.0/controllers/menu_controller.dart';
import 'package:web_tut/2.0/providers/drawerpage_provider.dart';
import 'package:web_tut/2.0/providers/localdata_provider.dart';
import 'package:web_tut/2.0/responsive.dart';
import 'package:web_tut/2.0/utils/routes2.dart';

import '../../../constants.dart';

class Header extends StatefulWidget {
  const Header({
    Key key,
  }) : super(key: key);

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  String _myUsertype;
  getUsertype() async {
    String myUsertype =
        await context.read<LocalDataProvider>().getLocalAdminUsertype();
    setState(() {
      _myUsertype = myUsertype;
    });
  }

  @override
  void initState() {
    getUsertype();
    super.initState();
  }

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
            "Dashboard",
            style: Theme.of(context).textTheme.headline6,
          ),
        if (!Responsive.isMobile(context))
          Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
        // const Expanded(child: SearchField()),
        ProfileCard(
          userType: _myUsertype,
        ),
      ],
    );
  }
}

class ProfileCard extends StatelessWidget {
  String userType;
  ProfileCard({
    Key key,
    this.userType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: defaultPadding),
      padding: const EdgeInsets.symmetric(
        horizontal: defaultPadding,
        vertical: defaultPadding / 2,
      ),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        children: [
          if (!Responsive.isMobile(context))
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
              child: FutureBuilder<String>(
                future: context.read<LocalDataProvider>().getLocalAdminName(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return GestureDetector(
                      onTap: () {
                        // userType == 'superadmin'
                        //     ? context
                        //         .read<DrawerPageProvider2>()
                        //         .changeDrawerPageSelected = 8
                        //     :
                        context
                            .read<DrawerPageProvider2>()
                            .changeDrawerPageSelected = 10;
                      },
                      child: Text(snapshot.data),
                    );
                  } else {
                    return Text('No Name');
                  }
                },

                // child: Text("Angelina Jolie")
              ),
            ),
        ],
      ),
    );
  }
}

class SearchField extends StatelessWidget {
  const SearchField({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: "Search",
        fillColor: secondaryColor,
        filled: true,
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        suffixIcon: InkWell(
          onTap: () {},
          child: Container(
            padding: const EdgeInsets.all(defaultPadding * 0.75),
            margin: const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
            decoration: const BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: const Icon(
              Icons.search,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
