import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:web_tut/2.0/models/my_files.dart';
import 'package:web_tut/models/report.dart';
import 'package:web_tut/models/thread.dart';
import 'package:web_tut/utils/constants.dart';

import '../../../constants.dart';

class ReportedInfoCard extends StatelessWidget {
  const ReportedInfoCard({
    Key key,
    this.info,
  }) : super(key: key);

  final Report info;

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
                info.thrTitle.toUpperCase(),
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
                info.thrCreatorName,
                style: const TextStyle(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 18),
                  child: Text(
                    "${info.reportCount} Reports",
                    style: Theme.of(context)
                        .textTheme
                        .caption
                        .copyWith(color: Colors.white70),
                  ),
                ),
                const Spacer(),
              ],
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
              'reported by: \n' + info.reporters.toString(),
              style: const TextStyle(
                color: Colors.white54,
                fontSize: 12,
              ),
              maxLines: 9,
              overflow: TextOverflow.fade,
            ),
            Divider(),
            Text(
              'claimed violations: \n' + info.reasons.toString(),
              style: const TextStyle(
                color: Colors.white54,
                fontSize: 12,
              ),
              maxLines: 9,
              overflow: TextOverflow.fade,
            ),
            //======================
            // ProgressLine(
            //   color: info.color,
            //   percentage: info.msgSent,
            // ),

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
