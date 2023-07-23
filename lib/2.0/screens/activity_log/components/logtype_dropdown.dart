import 'package:flutter/material.dart';
import 'package:getwidget/components/dropdown/gf_dropdown.dart';
import 'package:provider/provider.dart';
import 'package:web_tut/2.0/screens/activity_log/components/adminactivities_search_provider.dart';
import 'package:web_tut/2.0/screens/activity_log/components/logtype_provider.dart';
import 'package:web_tut/services/firestore_service.dart';

class LogTypeDropDown extends StatefulWidget {
  const LogTypeDropDown({Key key}) : super(key: key);

  @override
  State<LogTypeDropDown> createState() => _LogTypeDropDownState();
}

class _LogTypeDropDownState extends State<LogTypeDropDown>
    with AutomaticKeepAliveClientMixin<LogTypeDropDown> {
  bool _isVisited = false;
  @override
  bool get wantKeepAlive => _isVisited;
  FirestoreService firestoreService = FirestoreService();
  String logtypeDropdownValue;
  @override
  void initState() {
    setState(() {
      _isVisited = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          height: 50,
          width: size.width / 3,
          margin: const EdgeInsets.all(20),
          child: DropdownButtonHideUnderline(
            child: GFDropdown(
                hint: const Text('Choose Type'),
                padding: const EdgeInsets.all(15),
                borderRadius: BorderRadius.circular(10),
                border: const BorderSide(color: Colors.black12, width: 1),
                dropdownButtonColor: Colors.grey[850],
                value: context.watch<LogTypeProvider>().selectedLogtype == ''
                    ? null
                    : logtypeDropdownValue,
                onChanged: (newValue) {
                  setState(() {
                    context.read<LogTypeProvider>().changeSelectedLogtype =
                        newValue;
                    logtypeDropdownValue = newValue;
                  });
                },
                items: const [
                  DropdownMenuItem(
                    value: 'Administrator',
                    child: Text('Administrator'),
                  ),
                  DropdownMenuItem(
                    value: 'User',
                    child: Text('User'),
                  ),
                ]),
          ),
        ),
      ],
    );
  }
}
