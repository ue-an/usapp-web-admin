import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:web_tut/2.0/models/my_files.dart';
import 'package:web_tut/models/report.dart';
import 'package:web_tut/models/student.dart';
import 'package:web_tut/models/thread.dart';
import 'package:web_tut/utils/constants.dart';

import '../../../constants.dart';

class UserAccountCard extends StatelessWidget {
  const UserAccountCard({
    Key key,
    this.info,
  }) : super(key: key);

  final Student info;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      decoration: const BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            // padding: const EdgeInsets.only(left: 18),
            child: Text(
              info.firstName.toUpperCase() + ' ' + info.lastName.toUpperCase(),
              // style: TextStyle(
              //   color: kMiddleColor,
              // ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Container(
            // padding: const EdgeInsets.only(left: 18),
            child: Text(
              info.studentNumber,
              style: Theme.of(context)
                  .textTheme
                  .caption
                  .copyWith(color: Colors.white70),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Container(
            child: Text(
              info.course.toUpperCase() +
                  ' ' +
                  info.yearLvl.toString() +
                  '-' +
                  info.section.toString(),
              style: Theme.of(context)
                  .textTheme
                  .caption
                  .copyWith(color: Colors.white70),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Container(
            // padding: const EdgeInsets.only(left: 18),
            child: Text(
              info.email,
              // style: TextStyle(
              //   color: kMiddleColor,
              // ),
              style: Theme.of(context)
                  .textTheme
                  .caption
                  .copyWith(color: Colors.white70),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const Divider(),
        ],
      ),
    );
  }
}

// class ProgressLine extends StatelessWidget {
//   const ProgressLine({
//     Key key,
//     this.color = primaryColor,
//     this.percentage,
//   }) : super(key: key);

//   final Color color;
//   final int percentage;

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         Container(
//           width: double.infinity,
//           height: 5,
//           decoration: BoxDecoration(
//             color: color.withOpacity(0.1),
//             borderRadius: BorderRadius.all(Radius.circular(10)),
//           ),
//         ),
//         LayoutBuilder(
//           builder: (context, constraints) => Container(
//             width: constraints.maxWidth * (percentage / 100),
//             height: 5,
//             decoration: BoxDecoration(
//               color: color,
//               borderRadius: BorderRadius.all(Radius.circular(10)),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
