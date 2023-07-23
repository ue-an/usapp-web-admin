import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:web_tut/2.0/models/my_files.dart';
import 'package:web_tut/utils/constants.dart';

import '../../../constants.dart';

class FileInfoCard extends StatelessWidget {
  const FileInfoCard({
    Key key,
    this.info,
  }) : super(key: key);

  final CloudStorageInfo info;

  @override
  Widget build(BuildContext context) {
    // List ccsThreads = [];
    // List coaThreads = [];
    // List cobThreads = [];

    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      decoration: const BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Container(
          //       padding: const EdgeInsets.all(defaultPadding * 0.75),
          //       height: 40,
          //       width: 40,
          //       decoration: BoxDecoration(
          //         color: info.color.withOpacity(0.1),
          //         borderRadius: const BorderRadius.all(Radius.circular(10)),
          //       ),
          //       child: SvgPicture.asset(
          //         info.svgSrc,
          //         color: info.color,
          //       ),
          //     ),
          //     const Icon(Icons.more_vert, color: Colors.white54)
          //   ],
          // ),
          Text(
            info.thrTitle,
            // style: TextStyle(
            //   color: kMiddleColor,
            // ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            info.thrCollege,
            style: const TextStyle(),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            info.thrAuthor,
            style: const TextStyle(
              color: Colors.white54,
              fontSize: 12,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            info.authorSection,
            style: const TextStyle(
              color: Colors.white54,
              fontSize: 12,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          // ProgressLine(
          //   color: info.color,
          //   percentage: info.msgSent,
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "${info.msgSent} Messages",
                style: Theme.of(context)
                    .textTheme
                    .caption
                    .copyWith(color: Colors.white70),
              ),
              const Spacer(),
              const Icon(
                Icons.thumb_up_alt,
                color: Colors.white,
                size: 15,
              ),
              const SizedBox(
                width: 12,
              ),
              Text(
                info.likes.toString(),
                style: Theme.of(context)
                    .textTheme
                    .caption
                    .copyWith(color: Colors.white),
              ),
            ],
          )
        ],
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
