import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:web_tut/2.0/constants.dart';
import 'package:web_tut/2.0/screens/activity_log/components/useractivity_search_provider.dart';
import 'package:web_tut/2.0/screens/students/components/searched_student_page.dart';
import 'package:web_tut/2.0/screens/students/components/sfdata_search_provider.dart';

class UserActivitiesSearchFilter extends StatelessWidget {
  const UserActivitiesSearchFilter({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final searchTextCtrl = TextEditingController();
    return TextField(
      // onChanged: (value) =>
      //     context.read<SFDataSearchProvider>().changeSearchText = value,
      controller: searchTextCtrl,
      decoration: InputDecoration(
        hintText: "Filter by Email",
        fillColor: secondaryColor,
        filled: true,
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        suffixIcon: context.watch<UserActivitySearchProvider>().searchText == ''
            ? InkWell(
                onTap: () {
                  context.read<UserActivitySearchProvider>().changeSearchText =
                      searchTextCtrl.text;
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                  ),
                  margin: const EdgeInsets.symmetric(
                      horizontal: defaultPadding / 2),
                  decoration: const BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: const Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                ),
              )
            : InkWell(
                onTap: () {
                  searchTextCtrl.clear();
                  context.read<UserActivitySearchProvider>().changeSearchText =
                      '';
                },
                child: Container(
                  padding: const EdgeInsets.all(9),
                  margin: const EdgeInsets.symmetric(
                      horizontal: defaultPadding / 2),
                  decoration: const BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: const Icon(
                    Icons.clear_rounded,
                    color: Colors.white,
                  ),
                ),
              ),
      ),
    );
  }
}
