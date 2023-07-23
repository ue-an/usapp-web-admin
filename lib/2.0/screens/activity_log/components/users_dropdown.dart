import 'package:flutter/material.dart';
import 'package:getwidget/components/dropdown/gf_dropdown.dart';
import 'package:provider/provider.dart';
import 'package:web_tut/2.0/screens/activity_log/components/adminactivities_search_provider.dart';
import 'package:web_tut/2.0/screens/activity_log/components/useractivity_search_provider.dart';
import 'package:web_tut/models/user_account.dart';
import 'package:web_tut/services/firestore_service.dart';

class UsersDropDown extends StatefulWidget {
  const UsersDropDown({Key key}) : super(key: key);

  @override
  State<UsersDropDown> createState() => _UsersDropDownState();
}

class _UsersDropDownState extends State<UsersDropDown>
    with AutomaticKeepAliveClientMixin<UsersDropDown> {
  bool _isVisited = false;
  @override
  bool get wantKeepAlive => _isVisited;
  FirestoreService firestoreService = FirestoreService();
  String emailDropdownValue;
  Stream<List<UserAccount>> _streamUserAccount;
  @override
  void initState() {
    _streamUserAccount = firestoreService.getUserAccounts();
    setState(() {
      _isVisited = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        StreamBuilder<List<UserAccount>>(
            stream: _streamUserAccount,
            builder: (context, accountsSnap) {
              if (accountsSnap.connectionState == ConnectionState.waiting) {
                return Center(
                  child: Container(),
                );
              }
              if (accountsSnap.hasData) {
                List emails = [];

                accountsSnap.data.forEach((account) {
                  emails.add(account.email);
                });

                return Column(
                  children: [
                    Container(
                      height: 50,
                      width: size.width / 3,
                      margin: const EdgeInsets.all(20),
                      child: DropdownButtonHideUnderline(
                        child: GFDropdown(
                          hint: const Text('Filter by email'),
                          padding: const EdgeInsets.all(15),
                          borderRadius: BorderRadius.circular(10),
                          border:
                              const BorderSide(color: Colors.black12, width: 1),
                          dropdownButtonColor: Colors.grey[850],
                          value: context
                                      .watch<UserActivitySearchProvider>()
                                      .searchText ==
                                  ''
                              ? null
                              : emailDropdownValue,
                          onChanged: (newValue) {
                            setState(() {
                              context
                                  .read<UserActivitySearchProvider>()
                                  .changeSearchText = newValue;
                              emailDropdownValue = newValue;
                              context
                                  .read<AdminActivitySearchProvider>()
                                  .changeSearchText = '';
                            });
                          },
                          items: emails
                              .map((value) => DropdownMenuItem(
                                    value: value,
                                    child: Text(value),
                                  ))
                              .toList(),
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return const Text('No data');
              }
            }),
      ],
    );
  }
}
