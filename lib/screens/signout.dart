// import 'package:flutter/material.dart';
// import 'package:getwidget/components/button/gf_button.dart';
// import 'package:provider/src/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:web_tut/providers/auth_provider.dart';
// import 'package:web_tut/utils/routes.dart';

// class Signout extends StatelessWidget {
//   Signout({Key key}) : super(key: key);

//   SharedPreferences logindata;

//   @override
//   Widget build(BuildContext context) {
//     // return Scaffold(
//     //   body: Container(
//     //     color: Colors.amber,
//     //     child: Center(
//     //       child: ElevatedButton(
//     //           onPressed: () {
//     //             context.read<AuthProvider>().signOutAdmin();
//     //           },
//     //           child: const Text('Signout')),
//     //     ),
//     //   ),
//     // );
//     return AlertDialog(
//       backgroundColor: Colors.blue,
//       contentPadding: EdgeInsets.zero,
//       titlePadding: const EdgeInsets.only(top: 12),
//       elevation: 15,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.all(
//           Radius.circular(32.0),
//         ),
//         side: BorderSide(color: Colors.blue, width: 4),
//       ),
//       title: const Padding(
//           padding: EdgeInsets.all(8.0),
//           child: Padding(
//             padding: EdgeInsets.symmetric(vertical: 15, horizontal: 18),
//             child: Text(
//               "Confirm Signout",
//               style: TextStyle(color: Colors.white),
//             ),
//           )),
//       content: Container(
//         height: MediaQuery.of(context).size.height / 4,
//         width: MediaQuery.of(context).size.width / 3,
//         decoration: const BoxDecoration(
//           borderRadius: BorderRadius.only(
//               bottomLeft: Radius.circular(32),
//               bottomRight: Radius.circular(32)),
//           color: Colors.white,
//         ),
//         child: Padding(
//           padding: const EdgeInsets.symmetric(
//             vertical: 36,
//             horizontal: 20,
//           ),
//           child: Column(
//             children: [
//               //body
//               Expanded(
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: const [
//                     Text(
//                       'You are about to leave the admin panel.\nConfirm signout?',
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         fontWeight: FontWeight.w500,
//                         fontSize: 20,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               //bottom buttons\
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   GFButton(
//                     onPressed: () {
//                       context.read<AuthProvider>().signOutAdmin();
//                       logindata.setBool('loggedIn', false);
//                       Navigator.pushNamed(context, Routes.splash);
//                     },
//                     child: const Text("Confirm"),
//                   ),
//                   // GFButton(
//                   //   onPressed: () {
//                   //     Navigator.pop(context);
//                   //   },
//                   //   color: Colors.red,
//                   //   child: const Text("Cancel"),
//                   // ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
