import 'package:flutter/material.dart';

import '../constants.dart';

class CloudStorageInfo {
  final String thrTitle, thrCollege, thrAuthor, authorSection, createDate;
  final int msgSent, likes;
  final Color color;

  CloudStorageInfo({
    this.thrTitle,
    this.thrCollege,
    this.thrAuthor,
    this.authorSection,
    this.createDate,
    this.msgSent,
    this.likes,
    this.color,
  });
}

// List demoMyFiles = [
//   CloudStorageInfo(
//     title: "Documents",
//     numOfFiles: 1328,
//     svgSrc: "",
//     totalStorage: "1.9GB",
//     color: primaryColor,
//     percentage: 35,
//   ),
//   CloudStorageInfo(
//     title: "Google Drive",
//     numOfFiles: 1328,
//     svgSrc: "",
//     totalStorage: "2.9GB",
//     color: Color(0xFFFFA113),
//     percentage: 35,
//   ),
//   CloudStorageInfo(
//     title: "One Drive",
//     numOfFiles: 1328,
//     svgSrc: "",
//     totalStorage: "1GB",
//     color: Color(0xFFA4CDFF),
//     percentage: 10,
//   ),
//   CloudStorageInfo(
//     title: "Documents",
//     numOfFiles: 5328,
//     svgSrc: "",
//     totalStorage: "7.3GB",
//     color: Color(0xFF007EE5),
//     percentage: 78,
//   ),
// ];
