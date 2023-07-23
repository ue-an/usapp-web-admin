// import 'package:flutter/material.dart';
// import 'package:getwidget/components/dropdown/gf_dropdown.dart';
// import 'package:web_tut/models/user_account.dart';
// import 'package:web_tut/services/firestore_service.dart';

// class SortDropDown extends StatefulWidget {
//   const SortDropDown({Key key}) : super(key: key);

//   @override
//   State<SortDropDown> createState() => _SortDropDownState();
// }

// class _SortDropDownState extends State<SortDropDown>
//     with AutomaticKeepAliveClientMixin<SortDropDown> {
//   bool _isVisited = false;
//   @override
//   bool get wantKeepAlive => _isVisited;
//   FirestoreService firestoreService = FirestoreService();
//   Stream<List<UserAccount>> _streamUserAccounts;
//   String sortDropdownValue;
//   @override
//   void initState() {
//     _streamUserAccounts = firestoreService.
//     setState(() {
//       _isVisited = true;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return DropdownButtonHideUnderline(
//       child: GFDropdown(
//         hint: const Text('College'),
//         padding: const EdgeInsets.all(15),
//         borderRadius: BorderRadius.circular(10),
//         border: const BorderSide(color: Colors.black12, width: 1),
//         dropdownButtonColor: Colors.grey[850],
//         value: sortDropdownValue,
//         onChanged: (newValue) {
//           setState(() {
//             // context.read<StudentProvider>().changeCollege =
//             //     newValue;
//             // collegeDropdownValue = newValue;
//             // print(context.read<StudentProvider>().college);
//           });
//         },
//         items: [],
//       ),
//     );
//   }
// }
