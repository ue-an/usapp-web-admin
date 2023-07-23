import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:web_tut/2.0/controllers/menu_controller.dart';
import 'package:web_tut/2.0/responsive.dart';

class Header extends StatelessWidget {
  const Header({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //get date now (w/o time)
    String dateNowOnly = DateFormat("MM-dd-yyyy").format(DateTime.now());
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
            "Academic Year Dates",
            style: Theme.of(context).textTheme.headline6,
          ),
        if (!Responsive.isMobile(context))
          Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
        Row(
          children: [
            IconButton(
              onPressed: () {
                showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2021), // required
                  lastDate: DateTime(3000), // required
                );
              },
              icon: Icon(Icons.calendar_today),
            ),
            SizedBox(
              width: 12,
            ),
            Column(
              children: [
                Text('Today'),
                Text(dateNowOnly),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
