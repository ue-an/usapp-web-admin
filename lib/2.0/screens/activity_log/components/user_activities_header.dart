import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:pdf/pdf.dart';
import 'package:provider/provider.dart';
import 'package:web_tut/2.0/constants.dart';
import 'package:web_tut/2.0/controllers/menu_controller.dart';
import 'package:web_tut/2.0/providers/localdata_provider.dart';
import 'package:web_tut/2.0/responsive.dart';
import 'package:web_tut/2.0/screens/activity_log/components/api/utils.dart';
import 'package:web_tut/2.0/screens/activity_log/components/useractivities_searchfilter.dart';
import 'package:web_tut/2.0/screens/activity_log/components/useractivity_search_provider.dart';
import 'package:web_tut/2.0/screens/activity_log/components/users_dropdown.dart';
import 'package:web_tut/models/admin.dart';
import 'package:web_tut/models/user_activity.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:html' as html;

import 'package:web_tut/providers/user_activity_provider.dart';
import 'package:web_tut/utils/constants.dart';

class UserActivitiesHeader extends StatefulWidget {
  List<UserActivity> userActivities;
  // BuildContext context;
  UserActivitiesHeader({
    Key key,
    this.userActivities,
    // this.context,
  }) : super(key: key);

  @override
  State<UserActivitiesHeader> createState() => _UserActivitiesHeaderState();
}

class _UserActivitiesHeaderState extends State<UserActivitiesHeader> {
  final pdf = pw.Document();
  var anchor;

  savePDF() async {
    Uint8List pdfInBytes = await pdf.save();
    final blob = html.Blob([pdfInBytes], 'application/pdf');
    final url = html.Url.createObjectUrlFromBlob(blob);
    anchor = html.document.createElement('a') as html.AnchorElement
      ..href = url
      ..style.display = 'none'
      ..download = 'UsApp_User-Activity-Logs-Invoice' +
          DateTime.now().toString() +
          '.pdf';
    html.document.body.children.add(anchor);
  }

  createPDF() async {
    final image = (await rootBundle.load("assets/images/UsAppLogoNew1.png"))
        .buffer
        .asUint8List();
    String myName = await context.read<LocalDataProvider>().getLocalAdminName();
    String myEmail =
        await context.read<LocalDataProvider>().getLocalAdminEmail();
    String myUsertype =
        await context.read<LocalDataProvider>().getLocalAdminUsertype();
    Admin admin = Admin(
        adminName: myName,
        email: myEmail,
        usertype: myUsertype,
        isEnabled: true);

    pdf.addPage(pw.MultiPage(
        build: (context) => [
              buildHeader(admin, image),
              pw.SizedBox(height: 1 * PdfPageFormat.cm),
              buildTitle(admin),
              buildInvoice(widget.userActivities),
              // pw.Divider(),
            ]));
    savePDF();
  }

  static pw.Widget buildHeader(admin, image) => pw.Column(
        children: [
          //app info
          pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.end,
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              buildAppInformation(image),
              //invoice info
              buildInvoiceInfo(admin),
            ],
          ),
        ],
      );

  static pw.Widget buildAppInformation(Uint8List image) => pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Image(
            pw.MemoryImage(image),
            width: 150,
            height: 150,
          ),
          pw.Text('UsApp Administrator',
              style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
          pw.Text('System-Generated User Activity Records'),
        ],
      );

  static pw.Widget buildInvoiceInfo(Admin admin) {
    final titles = <String>[
      'Invoice Date:',
      'Retrieved By:',
      'Retrieval Time:'
    ];
    final data = <String>[
      Utils.formatDate(DateTime.now()),
      admin.adminName,
      Utils.formatTime(DateTime.now()),
    ];

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: List.generate(titles.length, (index) {
        final title = titles[index];
        final value = data[index];

        return buildText(title: title, value: value, width: 200);
      }),
    );
  }

  static buildText({
    String title,
    String value,
    double width = double.infinity,
    TextStyle titleStyle,
    bool unite = false,
  }) {
    final style = titleStyle ?? pw.TextStyle(fontWeight: pw.FontWeight.bold);

    return pw.Container(
      width: width,
      child: pw.Row(
        children: [
          pw.Expanded(child: pw.Text(title, style: style)),
          pw.Text(value, style: unite ? style : null),
        ],
      ),
    );
  }

  static pw.Widget buildTitle(admin) => pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            'User Activities Invoice',
            style: pw.TextStyle(fontSize: 21, fontWeight: pw.FontWeight.bold),
          ),
          pw.SizedBox(height: 0.8 * PdfPageFormat.cm),
          pw.Text(
              'List of records of user/users activities to UsApp mobile usage.'),
          pw.SizedBox(height: 0.8 * PdfPageFormat.cm),
        ],
      );

  static pw.Widget buildInvoice(List<UserActivity> userActivity) {
    // return
    return pw.Table(children: [
      pw.TableRow(children: [
        pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            mainAxisAlignment: pw.MainAxisAlignment.center,
            children: [
              pw.Text('Email', style: pw.TextStyle(fontSize: 15)),
              pw.Divider(thickness: 1)
            ]),
        pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            mainAxisAlignment: pw.MainAxisAlignment.center,
            children: [
              pw.Text('Activity', style: pw.TextStyle(fontSize: 15)),
              pw.Divider(thickness: 1)
            ]),
        pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            mainAxisAlignment: pw.MainAxisAlignment.center,
            children: [
              pw.Text('Date', style: pw.TextStyle(fontSize: 15)),
              pw.Divider(thickness: 1)
            ]),
        pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            mainAxisAlignment: pw.MainAxisAlignment.center,
            children: [
              pw.Text('Time', style: pw.TextStyle(fontSize: 15)),
              pw.Divider(thickness: 1)
            ]),
      ]),
      for (var i = 0; i < userActivity.length; i++)
        pw.TableRow(children: [
          pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              mainAxisAlignment: pw.MainAxisAlignment.center,
              children: [
                pw.Text(userActivity[i].owner,
                    style: pw.TextStyle(fontSize: 6)),
                pw.Divider(thickness: 1)
              ]),
          pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              mainAxisAlignment: pw.MainAxisAlignment.center,
              children: [
                pw.Text(userActivity[i].title,
                    style: pw.TextStyle(fontSize: 6)),
                pw.Divider(thickness: 1)
              ]),
          pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              mainAxisAlignment: pw.MainAxisAlignment.center,
              children: [
                pw.Text(Utils.formatDate(userActivity[i].date.toDate()),
                    style: pw.TextStyle(fontSize: 6)),
                pw.Divider(thickness: 1)
              ]),
          pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              mainAxisAlignment: pw.MainAxisAlignment.center,
              children: [
                pw.Text(Utils.formatTime(userActivity[i].date.toDate()),
                    style: pw.TextStyle(fontSize: 6)),
                pw.Divider(thickness: 1)
              ]),
        ])
    ]);
  }

  @override
  void initState() {
    super.initState();
    // createPDF();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // if (!Responsive.isDesktop(context))
            //   IconButton(
            //     icon: const Icon(Icons.menu),
            //     // onPressed: context.read<MenuController>().controlMenu,
            //     onPressed: () {
            //       widget.context.read<MenuController>().isClicked = true;
            //       widget.context.read<MenuController>().isClicked == true
            //           ? Scaffold.of(context).openDrawer()
            //           : null;
            //     },
            //   ),
            // if (!Responsive.isMobile(context))
            //   Text(
            //     "List of Activities",
            //     style: Theme.of(context).textTheme.headline6,
            //   ),
            // if (!Responsive.isMobile(context))
            //   Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
            // SortDropDown(),
            // const Expanded(child: UserActivitiesSearchFilter()),
            context.watch<UserActivitySearchProvider>().searchText == ''
                ? InkWell(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                      ),
                      margin: const EdgeInsets.symmetric(
                          horizontal: defaultPadding / 2),
                      decoration: const BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: const Icon(
                        Icons.clear_rounded,
                        color: Colors.white54,
                      ),
                    ),
                  )
                : InkWell(
                    onTap: () {
                      context
                          .read<UserActivitySearchProvider>()
                          .changeSearchText = '';
                    },
                    child: Container(
                      padding: const EdgeInsets.all(9),
                      margin: const EdgeInsets.symmetric(
                          horizontal: defaultPadding / 2),
                      decoration: const BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: const Icon(
                        Icons.clear_rounded,
                        color: Colors.white,
                      ),
                    ),
                  ),
            const UsersDropDown(),
            context.watch<UserActivityProvider>().isGenerated == false
                ? GFButton(
                    onPressed: () async {
                      await createPDF();
                      context.read<UserActivityProvider>().generatedPDF(true);
                      setState(() {});
                    },
                    color: Colors.redAccent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: const [
                        Icon(Icons.picture_as_pdf_outlined),
                        Text('Generate PDF')
                      ],
                    ),
                  )
                : GFButton(
                    onPressed: () async {
                      //download
                      await anchor.click();
                      context.read<UserActivityProvider>().generatedPDF(false);
                      setState(() {});
                    },
                    color: kPrimaryColor,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: const [
                        Icon(Icons.upload_file_outlined),
                        Text('Export PDF')
                      ],
                    ),
                  ),
            const SizedBox(width: defaultPadding),
          ],
        ),
        const SizedBox(
          height: 21,
        ),
      ],
    );
  }
}
