import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:provider/provider.dart';
import 'package:web_tut/2.0/constants.dart';
import 'package:web_tut/2.0/controllers/menu_controller.dart';
import 'package:web_tut/2.0/providers/localdata_provider.dart';
import 'package:web_tut/2.0/responsive.dart';
import 'package:web_tut/2.0/screens/activity_log/components/adminactivities_search_provider.dart';
import 'package:web_tut/2.0/screens/activity_log/components/admins_dropdown.dart';
import 'package:web_tut/2.0/screens/activity_log/components/api/utils.dart';
import 'package:web_tut/2.0/screens/activity_log/components/logtype_dropdown.dart';
import 'package:web_tut/models/admin.dart';
import 'package:web_tut/models/admin_activity.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:web_tut/providers/actlog_daterange_provider.dart';
import 'dart:html' as html;

import 'package:web_tut/providers/admin_activity_provider.dart';
import 'package:web_tut/utils/constants.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class AdminActivitiesHeader extends StatefulWidget {
  List<AdminActivity> adminActivities;
  AdminActivitiesHeader({
    Key key,
    this.adminActivities,
  }) : super(key: key);

  @override
  State<AdminActivitiesHeader> createState() => _AdminActivitiesHeaderState();
}

class _AdminActivitiesHeaderState extends State<AdminActivitiesHeader> {
  final pdf = pw.Document();
  var anchor;
  String _myName = '';
  String _myEmail = '';
  String _myUsertype = '';

  savePDF() async {
    Uint8List pdfInBytes = await pdf.save();
    final blob = html.Blob([pdfInBytes], 'application/pdf');
    final url = html.Url.createObjectUrlFromBlob(blob);
    anchor = html.document.createElement('a') as html.AnchorElement
      ..href = url
      ..style.display = 'none'
      ..download = 'UsApp_Admin-Activity-Logs-Invoice_' +
          DateTime.now().toString() +
          '.pdf';
    html.document.body.children.add(anchor);
  }

  createPDF() async {
    final image = (await rootBundle.load("assets/images/UsAppLogoNew1.png"))
        .buffer
        .asUint8List();
    Admin admin = Admin(
        adminName: _myName,
        email: _myEmail,
        usertype: _myUsertype,
        isEnabled: true);

    pdf.addPage(pw.MultiPage(
        build: (context) => [
              buildHeader(admin, image),
              pw.SizedBox(height: 3 * PdfPageFormat.cm),
              buildTitle(admin),
              buildInvoice(widget.adminActivities),
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
      'Retrieval Time:',
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
            style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold),
          ),
          pw.SizedBox(height: 0.8 * PdfPageFormat.cm),
          pw.Text(
              'List of records of administrator/administrators activities.'),
          pw.SizedBox(height: 0.8 * PdfPageFormat.cm),
        ],
      );

  static pw.Widget buildInvoice(List<AdminActivity> adminActivity) {
    // return
    return pw.Table(children: [
      pw.TableRow(children: [
        pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            mainAxisAlignment: pw.MainAxisAlignment.center,
            children: [
              pw.Text('Email', style: const pw.TextStyle(fontSize: 15)),
              pw.Divider(thickness: 1)
            ]),
        pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            mainAxisAlignment: pw.MainAxisAlignment.center,
            children: [
              pw.Text('Activity', style: const pw.TextStyle(fontSize: 15)),
              pw.Divider(thickness: 1)
            ]),
        pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            mainAxisAlignment: pw.MainAxisAlignment.center,
            children: [
              pw.Text('Date', style: const pw.TextStyle(fontSize: 15)),
              pw.Divider(thickness: 1)
            ]),
        pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            mainAxisAlignment: pw.MainAxisAlignment.center,
            children: [
              pw.Text('Time', style: const pw.TextStyle(fontSize: 15)),
              pw.Divider(thickness: 1)
            ]),
      ]),
      for (var i = 0; i < adminActivity.length; i++)
        pw.TableRow(children: [
          pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              mainAxisAlignment: pw.MainAxisAlignment.center,
              children: [
                pw.Text(adminActivity[i].email,
                    style: const pw.TextStyle(fontSize: 6)),
                pw.Divider(thickness: 1)
              ]),
          pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              mainAxisAlignment: pw.MainAxisAlignment.center,
              children: [
                pw.Text(adminActivity[i].activityTitle,
                    style: const pw.TextStyle(fontSize: 6)),
                pw.Divider(thickness: 1)
              ]),
          pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              mainAxisAlignment: pw.MainAxisAlignment.center,
              children: [
                pw.Text(Utils.formatDate(adminActivity[i].date.toDate()),
                    style: const pw.TextStyle(fontSize: 6)),
                pw.Divider(thickness: 1)
              ]),
          pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              mainAxisAlignment: pw.MainAxisAlignment.center,
              children: [
                pw.Text(Utils.formatTime(adminActivity[i].date.toDate()),
                    style: const pw.TextStyle(fontSize: 6)),
                pw.Divider(thickness: 1)
              ]),
        ])
    ]);
  }

  getLocalAdminDetails() async {
    String myName = await context.read<LocalDataProvider>().getLocalAdminName();
    String myEmail =
        await context.read<LocalDataProvider>().getLocalAdminEmail();
    String myUsertype =
        await context.read<LocalDataProvider>().getLocalAdminUsertype();
    setState(() {
      _myName = myName;
      _myEmail = myEmail;
      _myUsertype = myUsertype;
    });
  }

  String _selectedDate = '';
  String _dateCount = '';
  String _range = '';
  String _rangeCount = '';

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      if (args.value is PickerDateRange) {
        _range = '${DateFormat('MM/dd/yyyy').format(args.value.startDate)} -'
            // ignore: lines_longer_than_80_chars
            ' ${DateFormat('MM/dd/yyyy').format(args.value.endDate ?? args.value.startDate)}';
        //change/update date range on provider
        //change start
        context.read<ActivityLogDateRangeProvider>().changeStart =
            DateFormat('MM/dd/yyyy').format(args.value.startDate);
        context.read<ActivityLogDateRangeProvider>().changeStartDt =
            args.value.startDate;
        //change end
        context.read<ActivityLogDateRangeProvider>().changeEnd =
            DateFormat('MM/dd/yyyy')
                .format(args.value.endDate ?? args.value.startDate);
        context.read<ActivityLogDateRangeProvider>().changeEndDt =
            args.value.endDate ?? args.value.startDate;
      } else if (args.value is DateTime) {
        _selectedDate = args.value.toString();
      } else if (args.value is List<DateTime>) {
        _dateCount = args.value.length.toString();
      } else {
        _rangeCount = args.value.length.toString();
      }
    });
  }

  @override
  void initState() {
    getLocalAdminDetails();
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
            //       context.read<MenuController>().isClicked = true;
            //       context.read<MenuController>().isClicked == true
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
            // const Expanded(child: AdminActivitiesSearchFilter()),
            context.watch<AdminActivitySearchProvider>().searchText == ''
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
                          .read<AdminActivitySearchProvider>()
                          .changeSearchText = '';
                      setState(() {});
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
            const AdminsDropDown(),
            context.watch<AdminActivityProvider>().isGenerated == false
                ? GFButton(
                    onPressed: () async {
                      await createPDF();
                      context.read<AdminActivityProvider>().generatedPDF(true);
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
                      context.read<AdminActivityProvider>().generatedPDF(false);
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
        // const SizedBox(
        //   height: 16,
        // ),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.start,
        //   children: [
        //     GFButton(
        //       onPressed: () async {
        //         showDialog(
        //             barrierDismissible: false,
        //             context: context,
        //             builder: (BuildContext context) {
        //               return Stack(children: [
        //                 SingleChildScrollView(
        //                   child: AlertDialog(
        //                     content: Container(
        //                       width: double.maxFinite,
        //                       child: Column(
        //                         children: [
        //                           SfDateRangePicker(
        //                             onSelectionChanged: _onSelectionChanged,
        //                             selectionMode:
        //                                 DateRangePickerSelectionMode.range,
        //                             initialSelectedRange: PickerDateRange(
        //                                 DateTime.now()
        //                                     .subtract(const Duration(days: 4)),
        //                                 DateTime.now()
        //                                     .add(const Duration(days: 3))),
        //                           ),
        //                           GFButton(
        //                             onPressed: () {
        //                               Navigator.of(context).pop();
        //                             },
        //                             child: const Text('Save'),
        //                           )
        //                         ],
        //                       ),
        //                     ),
        //                   ),
        //                 ),
        //                 Positioned(
        //                   // right: -40.0,
        //                   right: size.width * .02,
        //                   top: 3,
        //                   child: GestureDetector(
        //                     onTap: () {
        //                       Navigator.of(context).pop();
        //                     },
        //                     child: const CircleAvatar(
        //                       child: Icon(
        //                         Icons.close,
        //                         color: Colors.white,
        //                       ),
        //                       backgroundColor: Colors.red,
        //                     ),
        //                   ),
        //                 ),
        //               ]);
        //             });
        //       },
        //       child: const Text('Select date'),
        //     ),
        //     const SizedBox(
        //       width: 12,
        //     ),
        //     Text('Range: ' + _range),
        //   ],
        // ),
        const SizedBox(
          height: 21,
        ),
      ],
    );
  }
}
