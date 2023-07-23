import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:provider/provider.dart';
// import 'package:url_launcher/url_launcher.dart';
import 'package:web_tut/models/thread_messages.dart';
import 'package:web_tut/providers/archive_report_provider.dart';
import 'package:intl/intl.dart';
import 'package:markdown/markdown.dart' as md;

class ViewArchiveThreadConvo extends StatefulWidget {
  const ViewArchiveThreadConvo({Key key}) : super(key: key);

  @override
  State<ViewArchiveThreadConvo> createState() => _ViewArchiveThreadConvoState();
}

class _ViewArchiveThreadConvoState extends State<ViewArchiveThreadConvo> {
  // _launchURL(String commentUrl) async {
  //   final url = commentUrl;
  //   if (await canLaunch(url)) {
  //     await launch(
  //       url,
  //       forceSafariVC: true,
  //       forceWebView: true,
  //       webOnlyWindowName: '_self',
  //     );
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey[850],
      body: FutureBuilder<List<ThreadMessage>>(
        future: context.read<ArchiveReportProvider>().viewThreads(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            // return Center(child: CircularProgressIndicator());
            return Center(child: Text('No data'));
          }
          if (snapshot.hasData) {
            List<ThreadMessage> thrList = snapshot.data;

            return ListView.builder(
                physics: AlwaysScrollableScrollPhysics(),
                // reverse: true,
                shrinkWrap: true,
                itemCount: thrList.length,
                itemBuilder: (context, index) {
                  DateTime myDateTime =
                      snapshot.data[index].messageDate.toDate();
                  String formattedDate =
                      DateFormat('yyyy-MM-dd – KK:mm a (EEE)')
                          .format(myDateTime);
                  // List thrMsg = thrList[index].thrMessages;
                  return Column(
                    children: [
                      const SizedBox(
                        height: 12,
                      ),
                      Column(
                        children: [
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(30.0),
                                child: ListTile(
                                  title: Row(
                                    children: [
                                      // ClipRRect(
                                      //   borderRadius: const BorderRadius.all(
                                      //       Radius.circular(50)),
                                      //   child: Image.network(
                                      //     thrList[index].senderPhoto,
                                      //     height: 30,
                                      //     width: 30,
                                      //     fit: BoxFit.cover,
                                      //   ),
                                      // ),
                                      const SizedBox(
                                        width: 9,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            thrList[index].senderName +
                                                ', ' +
                                                thrList[index].senderYearSec,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  // title: Text(''),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 9,
                                      ),
                                      // Text(
                                      //   thrList[index].messageContent,
                                      //   style: const TextStyle(
                                      //     // color: Colors.white60,
                                      //     // color: Colors.white,
                                      //     fontSize: 15,
                                      //   ),
                                      // ),
                                      thrList[index].threadMessagePhoto != ''
                                          ? Container(
                                              margin: const EdgeInsets.only(
                                                top: 3,
                                              ),
                                              child: Image.network(
                                                thrList[index]
                                                    .threadMessagePhoto,
                                                // height: size.height / 2,
                                                // width: size.width / 2,
                                              ),
                                            )
                                          : Padding(
                                              padding: const EdgeInsets.only(
                                                top: 5.0,
                                                // bottom: 16.0,
                                              ),
                                              child: MarkdownBody(
                                                data: _replaceMentions(
                                                  thrList[index].messageContent,
                                                ).replaceAll('\n', '\\\n'),
                                                onTapLink: (
                                                  String link,
                                                  String href,
                                                  String title,
                                                ) {
                                                  // print(
                                                  //     'Link clicked with $link')
                                                  // _launchURL(link);
                                                },
                                                // builders: {
                                                //   "coloredBox":
                                                //       ColoredBoxMarkdownElementBuilder(
                                                //           context),
                                                // },
                                                inlineSyntaxes: [
                                                  ColoredBoxInlineSyntax(),
                                                ],
                                                styleSheet: MarkdownStyleSheet
                                                    .fromTheme(
                                                  Theme.of(context).copyWith(
                                                    textTheme: Theme.of(context)
                                                        .textTheme
                                                        .apply(
                                                          bodyColor:
                                                              Colors.white,
                                                          fontSizeFactor: 1,
                                                        ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                      const SizedBox(
                                        height: 6,
                                      ),
                                      Text(
                                        formattedDate,
                                        style: const TextStyle(
                                          // color: Colors.white30,
                                          fontSize: 9,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: size.width / 4),
                                child: const Divider(
                                  thickness: 2,
                                ),
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  );
                });
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      // body: Center(
      //   child: Text(context.read<ReportProvider>().tappedReport.thrID),
      // ),
    );
  }

  String _replaceMentions(String text) {
    // otherNamesList.map((u) => u).toSet().forEach((userName) {
    //   text = text.replaceAll('@$userName', '[@$userName]');
    // });
    return text;
  }
}

class ColoredBoxInlineSyntax extends md.InlineSyntax {
  ColoredBoxInlineSyntax({
    String pattern = r'\[(.*?)\]',
  }) : super(pattern);

  @override
  bool onMatch(md.InlineParser parser, Match match) {
    /// This creates a new element with the tag name `coloredBox`
    /// The `textContent` of this new tag will be the
    /// pattern match with the @ symbol
    ///
    /// We can change how this looks by creating a custom
    /// [MarkdownElementBuilder] from the `flutter_markdown` package.
    final withoutBracket1 = match.group(0).replaceAll('[', "");
    final withoutBracket2 = withoutBracket1.replaceAll(']', "");
    md.Element mentionedElement =
        md.Element.text("coloredBox", withoutBracket2);
    print('Mentioned user ${mentionedElement.textContent}');
    parser.addNode(mentionedElement);
    return true;
  }
}
