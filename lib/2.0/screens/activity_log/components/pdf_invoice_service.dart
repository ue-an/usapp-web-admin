// import 'package:flutter/material.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'dart:typed_data';
// import 'dart:html' as html;

// import 'package:web_tut/2.0/screens/activity_log/components/api/iframe_widget.dart';

// class PDFInvoiceService extends StatefulWidget {
//   @override
//   _PDFInvoiceServiceState createState() => _PDFInvoiceServiceState();
// }

// class _PDFInvoiceServiceState extends State<PDFInvoiceService> {
//   final pdf = pw.Document();
//   var anchor;

//   savePDF() async {
//     Uint8List pdfInBytes = await pdf.save();
//     final blob = html.Blob([pdfInBytes], 'application/pdf');
//     final url = html.Url.createObjectUrlFromBlob(blob);
//     anchor = html.document.createElement('a') as html.AnchorElement
//       ..href = url
//       ..style.display = 'none'
//       ..download = 'UsApp_ActivityLogsInvoice.pdf';
//     html.document.body.children.add(anchor);
//   }

//   createPDF() async {
//     pdf.addPage(pw.MultiPage(
//             build: (context) => [
//                   pw.Column(
//                     children: [
//                       pw.Row(
//                           crossAxisAlignment: pw.CrossAxisAlignment.end,
//                           mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//                           children: [
//                             pw.Column(
//                               crossAxisAlignment: pw.CrossAxisAlignment.start,
//                               children: [
//                                 pw.Text('UsApp Administrator',
//                                     style: pw.TextStyle(
//                                         fontWeight: pw.FontWeight.bold)),
//                                 pw.Text('System-Generated Activities Record'),
//                               ],
//                             )
//                           ]),
//                       pw.Text('Hello World', style: pw.TextStyle(fontSize: 40)),
//                     ],
//                   ),
//                 ])
//         // pw.Page(
//         //   build: (pw.Context context) => pw.Column(
//         //     children: [
//         //       pw.Text('Hello World', style: pw.TextStyle(fontSize: 40)),
//         //     ],
//         //   ),
//         // ),
//         );
//     savePDF();
//   }

//   @override
//   void initState() {
//     super.initState();
//     createPDF();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Colors.transparent,
//         appBar: AppBar(
//           title: Text('PDF Creator'),
//           actions: [
//             RaisedButton(
//               child: Row(
//                 children: [
//                   Icon(Icons.file_upload_outlined),
//                   Text('Export File'),
//                 ],
//               ),
//               onPressed: () {
//                 anchor.click();
//                 Navigator.pop(context);
//               },
//             ),
//           ],
//         ),
//         body: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Iframe(),
//           ],
//         ));
//   }
// }
