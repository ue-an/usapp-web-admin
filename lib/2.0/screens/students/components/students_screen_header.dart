import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_tut/2.0/controllers/menu_controller.dart';
import 'package:web_tut/2.0/responsive.dart';
import 'package:web_tut/2.0/screens/students/components/selection_provider.dart';
import 'package:web_tut/2.0/screens/students/components/sfdata_search.dart';

class StudentsScreenHeader extends StatelessWidget {
  const StudentsScreenHeader({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (!Responsive.isDesktop(context))
          IconButton(
            icon: const Icon(Icons.menu),
            // onPressed: context.read<MenuController>().controlMenu,
            onPressed: () {
              context.read<MenuController>().isClicked =
                  !context.read<MenuController>().isClicked;
            },
          ),
        if (!Responsive.isMobile(context))
          Text(
            "Students",
            style: Theme.of(context).textTheme.headline6,
          ),
        if (!Responsive.isMobile(context))
          Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
        Expanded(
            child: context.watch<SelectionProvider>().haveSelections
                ? Container()
                : const SFDataSearchField()),
      ],
    );
  }
}
