// import 'dart:io';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:pdf/widgets.dart';
// import 'package:web_tut/2.0/screens/activity_log/components/api/pdf_api.dart';
// import 'package:web_tut/2.0/screens/activity_log/components/api/utils.dart';
// import 'package:web_tut/models/admin.dart';
// import 'package:web_tut/models/user_activity.dart';

// class PdfInvoiceApi {
//   static Future<File> generate(UserActivity userActivity, Admin admin) async {
//     final pdf = Document();

//     pdf.addPage(MultiPage(
//       build: (context) => [
//         buildHeader(userActivity),
//         SizedBox(height: 3 * PdfPageFormat.cm),
//         buildTitle(userActivity),
//         buildInvoice(userActivity),
//         Divider(),
//         buildTotal(userActivity),
//       ],
//       footer: (context) => buildFooter(admin),
//     ));

//     return PdfApi.saveDocument(name: 'my_invoice.pdf', pdf: pdf);
//   }

//   static Widget buildHeader(UserActivity userActivity) => Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           SizedBox(height: 1 * PdfPageFormat.cm),
//           //App Title and description account
//           // Row(
//           //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           //   children: [
//           //     
//           //     buildSupplierAddress(userActivity.supplier),
//           //     Container(
//           //       height: 50,
//           //       width: 50,
//           //       child: BarcodeWidget(
//           //         barcode: Barcode.qrCode(),
//           //         data: userActivity.info.number,
//           //       ),
//           //     ),
//           //   ],
//           // ),
//           // SizedBox(height: 1 * PdfPageFormat.cm),
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.end,
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               buildAppInformation(),
//               buildInvoiceInfo(userActivity.info),
//             ],
//           ),
//         ],
//       );

//   static Widget buildAppInformation() => Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text('UsApp Administrator', style: TextStyle(fontWeight: FontWeight.bold)),
//           Text('System-Generated Activities Record'),
//         ],
//       );

//   static Widget buildInvoiceInfo(UserActivity userActivity) {
//     final titles = <String>[
//       'Invoice Date:',
//     ];
//     final data = <String>[
//       Utils.formatDate(userActivity.date.toDate()),
//     ];

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: List.generate(titles.length, (index) {
//         final title = titles[index];
//         final value = data[index];

//         return buildText(title: title, value: value, width: 200);
//       }),
//     );
//   }

//   static Widget buildSupplierAddress(UserActivity userActivity) => Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(userActivity.name, style: TextStyle(fontWeight: FontWeight.bold)),
//           SizedBox(height: 1 * PdfPageFormat.mm),
//           Text(userActivity.address),
//         ],
//       );

//   static Widget buildTitle(UserActivity userActivity) => Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'Activit',
//             style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//           ),
//           SizedBox(height: 0.8 * PdfPageFormat.cm),
//           Text(userActivity.info.description),
//           SizedBox(height: 0.8 * PdfPageFormat.cm),
//         ],
//       );

//   static Widget buildInvoice(UserActivity userActivity) {
//     final headers = [
//       'Description',
//       'Date',
//       'Quantity',
//       'Unit Price',
//       'VAT',
//       'Total'
//     ];
//     final data = userActivity.items.map((item) {
//       final total = item.unitPrice * item.quantity * (1 + item.vat);

//       return [
//         item.description,
//         Utils.formatDate(item.date),
//         '${item.quantity}',
//         '\$ ${item.unitPrice}',
//         '${item.vat} %',
//         '\$ ${total.toStringAsFixed(2)}',
//       ];
//     }).toList();

//     return Table.fromTextArray(
//       headers: headers,
//       data: data,
//       border: null,
//       headerStyle: TextStyle(fontWeight: FontWeight.bold),
//       headerDecoration: BoxDecoration(color: PdfColors.grey300),
//       cellHeight: 30,
//       cellAlignments: {
//         0: Alignment.centerLeft,
//         1: Alignment.centerRight,
//         2: Alignment.centerRight,
//         3: Alignment.centerRight,
//         4: Alignment.centerRight,
//         5: Alignment.centerRight,
//       },
//     );
//   }

//   static Widget buildTotal(UserActivity userActivity) {
//     final netTotal = userActivity.items
//         .map((item) => item.unitPrice * item.quantity)
//         .reduce((item1, item2) => item1 + item2);
//     final vatPercent = userActivity.items.first.vat;
//     final vat = netTotal * vatPercent;
//     final total = netTotal + vat;

//     return Container(
//       alignment: Alignment.centerRight,
//       child: Row(
//         children: [
//           Spacer(flex: 6),
//           Expanded(
//             flex: 4,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 buildText(
//                   title: 'Net total',
//                   value: Utils.formatPrice(netTotal),
//                   unite: true,
//                 ),
//                 buildText(
//                   title: 'Vat ${vatPercent * 100} %',
//                   value: Utils.formatPrice(vat),
//                   unite: true,
//                 ),
//                 Divider(),
//                 buildText(
//                   title: 'Total amount due',
//                   titleStyle: TextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.bold,
//                   ),
//                   value: Utils.formatPrice(total),
//                   unite: true,
//                 ),
//                 SizedBox(height: 2 * PdfPageFormat.mm),
//                 Container(height: 1, color: PdfColors.grey400),
//                 SizedBox(height: 0.5 * PdfPageFormat.mm),
//                 Container(height: 1, color: PdfColors.grey400),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   static Widget buildFooter(Admin admin) => Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Divider(),
//           SizedBox(height: 2 * PdfPageFormat.mm),
//           buildSimpleText(title: 'Address', value: admin.supplier.address),
//           SizedBox(height: 1 * PdfPageFormat.mm),
//           buildSimpleText(title: 'Paypal', value: admin.supplier.paymentInfo),
//         ],
//       );

//   static buildSimpleText({
//     String title,
//     String value,
//   }) {
//     final style = TextStyle(fontWeight: FontWeight.bold);

//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       crossAxisAlignment: pw.CrossAxisAlignment.end,
//       children: [
//         Text(title, style: style),
//         SizedBox(width: 2 * PdfPageFormat.mm),
//         Text(value),
//       ],
//     );
//   }

//   static buildText({
//     String title,
//     String value,
//     double width = double.infinity,
//     TextStyle titleStyle,
//     bool unite = false,
//   }) {
//     final style = titleStyle ?? TextStyle(fontWeight: FontWeight.bold);

//     return Container(
//       width: width,
//       child: Row(
//         children: [
//           Expanded(child: Text(title, style: style)),
//           Text(value, style: unite ? style : null),
//         ],
//       ),
//     );
//   }
// }
