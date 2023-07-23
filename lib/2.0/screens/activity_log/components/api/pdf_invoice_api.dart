import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';
import 'package:web_tut/2.0/screens/activity_log/components/api/pdf_api.dart';
import 'package:web_tut/2.0/screens/activity_log/components/api/utils.dart';
import 'package:web_tut/models/admin.dart';
import 'package:web_tut/models/user_activity.dart';

class PdfInvoiceApi {
  static Future<File> generate(
      List<UserActivity> userActivities, Admin admin) async {
    final pdf = Document();

    pdf.addPage(MultiPage(
      build: (context) => [
        buildHeader(admin),
        SizedBox(height: 3 * PdfPageFormat.cm),
        buildTitle(admin),
        buildInvoice(userActivities),
        Divider(),
      ],
      footer: (context) => buildFooter(admin),
    ));

    return PdfApi.saveDocument(name: 'my_invoice.pdf', pdf: pdf);
  }

  static Widget buildHeader(admin) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 1 * PdfPageFormat.cm),
          //App Title and description account
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //
          //     buildSupplierAddress(userActivity.supplier),
          //     Container(
          //       height: 50,
          //       width: 50,
          //       child: BarcodeWidget(
          //         barcode: Barcode.qrCode(),
          //         data: userActivity.info.number,
          //       ),
          //     ),
          //   ],
          // ),
          // SizedBox(height: 1 * PdfPageFormat.cm),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildAppInformation(),
              buildInvoiceInfo(admin),
            ],
          ),
        ],
      );

  static Widget buildAppInformation() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('UsApp Administrator',
              style: TextStyle(fontWeight: FontWeight.bold)),
          Text('System-Generated Activities Record'),
        ],
      );

  static Widget buildInvoiceInfo(UserActivity userActivity) {
    final titles = <String>[
      'Invoice Date:',
    ];
    final data = <String>[
      Utils.formatDate(userActivity.date.toDate()),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(titles.length, (index) {
        final title = titles[index];
        final value = data[index];

        return buildText(title: title, value: value, width: 200);
      }),
    );
  }

  static Widget buildSupplierAddress(UserActivity userActivity) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(userActivity.owner,
              style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 1 * PdfPageFormat.mm),
          Text(userActivity.title),
        ],
      );

  static Widget buildTitle(admin) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'User Activities Invoice',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 0.8 * PdfPageFormat.cm),
          Text(
              'List of records of user/users activities to UsApp mobile usage.'),
          SizedBox(height: 0.8 * PdfPageFormat.cm),
        ],
      );

  static Widget buildInvoice(List<UserActivity> userActivity) {
    final headers = [
      'User Account Email',
      'Activity',
      'Date',
    ];
    final data = [];

    userActivity.forEach((userActivity) {
      data.add([
        userActivity.owner,
        userActivity.title,
        Utils.formatDate(userActivity.date.toDate()),
      ]);
    });

    return Table.fromTextArray(
      headers: headers,
      data: data,
      border: null,
      headerStyle: TextStyle(fontWeight: FontWeight.bold),
      headerDecoration: const BoxDecoration(color: PdfColors.grey300),
      cellHeight: 30,
      cellAlignments: {
        0: Alignment.centerLeft,
        1: Alignment.centerRight,
        2: Alignment.centerRight,
      },
    );
  }

  static Widget buildFooter(Admin admin) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Divider(),
          SizedBox(height: 2 * PdfPageFormat.mm),
          buildSimpleText(title: 'Admin', value: admin.adminName),
          SizedBox(height: 1 * PdfPageFormat.mm),
          buildSimpleText(title: '???', value: admin.usertype),
        ],
      );

  static buildSimpleText({
    String title,
    String value,
  }) {
    final style = TextStyle(fontWeight: FontWeight.bold);

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      children: [
        Text(title, style: style),
        SizedBox(width: 2 * PdfPageFormat.mm),
        Text(value),
      ],
    );
  }

  static buildText({
    String title,
    String value,
    double width = double.infinity,
    TextStyle titleStyle,
    bool unite = false,
  }) {
    final style = titleStyle ?? TextStyle(fontWeight: FontWeight.bold);

    return Container(
      width: width,
      child: Row(
        children: [
          Expanded(child: Text(title, style: style)),
          Text(value, style: unite ? style : null),
        ],
      ),
    );
  }
}
