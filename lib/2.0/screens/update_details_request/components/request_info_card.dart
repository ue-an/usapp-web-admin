import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:web_tut/2.0/models/my_files.dart';
import 'package:web_tut/models/report.dart';
import 'package:web_tut/models/request.dart';
import 'package:web_tut/models/thread.dart';
import 'package:web_tut/utils/constants.dart';

import '../../../constants.dart';

class RequestInfoCard extends StatelessWidget {
  const RequestInfoCard({
    Key key,
    this.info,
  }) : super(key: key);

  final Request info;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      decoration: const BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 18),
              child: Text(
                info.currName.toUpperCase(),
                // style: TextStyle(
                //   color: kMiddleColor,
                // ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 18),
              child: Text(
                info.currCollege,
                style: const TextStyle(
                  fontSize: 12,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Divider(),
            //====================
            // Text(
            //   info.reportCount.toString(),
            //   style: const TextStyle(
            //     color: Colors.white54,
            //     fontSize: 12,
            //   ),
            //   maxLines: 1,
            //   overflow: TextOverflow.ellipsis,
            // ),
            //=======================
            Text(
              'Requested update(s):',
              style: TextStyle(
                color: kMiddleColor,
                fontSize: 12,
              ),
              maxLines: 9,
              overflow: TextOverflow.fade,
            ),
            Row(
              children: [
                const Text(
                  ' first name: ',
                  style: TextStyle(
                    color: Colors.white54,
                    fontSize: 12,
                  ),
                  maxLines: 9,
                  overflow: TextOverflow.fade,
                ),
                Text(
                  info.reqFname,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                  maxLines: 9,
                  overflow: TextOverflow.fade,
                ),
              ],
            ),
            Row(
              children: [
                const Text(
                  ' middle initial: ',
                  style: TextStyle(
                    color: Colors.white54,
                    fontSize: 12,
                  ),
                  maxLines: 9,
                  overflow: TextOverflow.fade,
                ),
                Text(
                  info.reqMinitial,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),
                  maxLines: 9,
                  overflow: TextOverflow.fade,
                ),
              ],
            ),
            Row(
              children: [
                const Text(
                  ' last name: ',
                  style: TextStyle(
                    color: Colors.white54,
                    fontSize: 12,
                  ),
                  maxLines: 9,
                  overflow: TextOverflow.fade,
                ),
                Text(
                  info.reqLname,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),
                  maxLines: 9,
                  overflow: TextOverflow.fade,
                ),
              ],
            ),
            Row(
              children: [
                const Text(
                  ' section: ',
                  style: TextStyle(
                    color: Colors.white54,
                    fontSize: 12,
                  ),
                  maxLines: 9,
                  overflow: TextOverflow.fade,
                ),
                Text(
                  info.reqSection,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),
                  maxLines: 9,
                  overflow: TextOverflow.fade,
                ),
              ],
            ),
            //==========================
          ],
        ),
      ),
    );
  }
}

class ProgressLine extends StatelessWidget {
  const ProgressLine({
    Key key,
    this.color = primaryColor,
    this.percentage,
  }) : super(key: key);

  final Color color;
  final int percentage;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 5,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        LayoutBuilder(
          builder: (context, constraints) => Container(
            width: constraints.maxWidth * (percentage / 100),
            height: 5,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
        ),
      ],
    );
  }
}
