import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_tut/2.0/constants.dart';
import 'package:web_tut/2.0/screens/activity_log/components/adminactivities_search_provider.dart';

class AdminActivitiesSearchFilter extends StatelessWidget {
  const AdminActivitiesSearchFilter({
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
        suffixIcon: context.watch<AdminActivitySearchProvider>().searchText ==
                ''
            ? InkWell(
                onTap: () {
                  context.read<AdminActivitySearchProvider>().changeSearchText =
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
                  context.read<AdminActivitySearchProvider>().changeSearchText =
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
