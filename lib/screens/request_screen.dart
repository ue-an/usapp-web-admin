import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:provider/src/provider.dart';
import 'package:web_tut/models/request.dart';
import 'package:web_tut/providers/report_provider.dart';
import 'package:web_tut/providers/request_provider.dart';
import 'package:web_tut/utils/constants.dart';
import 'package:web_tut/utils/routes.dart';

class RequestScreen extends StatelessWidget {
  const RequestScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final requestProvider = RequestProvider();
    return Scaffold(
      body: StreamBuilder<List<Request>>(
        stream: requestProvider.requests,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasData) {
            int pendingsTotal;
            return Row(
              children: [
                Container(
                  height: double.infinity,
                  width: size.width / 1.5,
                  color: kPrimaryColor.withOpacity(0.5),
                  child: ListView.builder(
                      physics: AlwaysScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        if (snapshot.data[index].isAccepted == false) {
                          pendingsTotal = snapshot.data.length;

                          context
                              .read<RequestProvider>()
                              .pendingRequests
                              .add(snapshot.data[index]);

                          context.read<RequestProvider>().changeRequestsTotal =
                              context
                                  .read<RequestProvider>()
                                  .pendingRequests
                                  .length;
                          return GestureDetector(
                            onTap: () {
                              context
                                  .read<RequestProvider>()
                                  .changeTappedRequest = snapshot.data[index];
                              context
                                      .read<RequestProvider>()
                                      .changeTappedEmail =
                                  snapshot.data[index].currEmail;
                            },
                            child: Column(
                              children: [
                                ListTile(
                                  title: Text(
                                    snapshot.data[index].currName,
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  subtitle:
                                      Text('Sent a profile update request'),
                                ),
                                Divider(
                                  indent: size.width / 10,
                                  endIndent: size.width / 10,
                                  thickness: 1,
                                ),
                              ],
                            ),
                          );
                        } else {
                          return Column(
                            children: [
                              ListView(
                                shrinkWrap: true,
                                children: [
                                  ListTile(
                                    title: const Text(
                                      'ヾ( ⌒_⌒ )ノ',
                                      textAlign: TextAlign.center,
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: const [
                                        Text(
                                          'Woohoo! No update requests',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
                        }
                      }),
                ),
                Container(
                  height: double.infinity,
                  width: size.width / 5.4,
                  color: Colors.white,
                  child: Center(
                    child: ListView.builder(
                        physics: const AlwaysScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: context
                                    .read<RequestProvider>()
                                    .pendingRequests
                                    .length ==
                                0
                            ? 1
                            : 1,
                        itemBuilder: (context, index) {
                          if (context
                                  .watch<RequestProvider>()
                                  .pendingRequests
                                  .length ==
                              0) {
                            return Column(
                              children: [
                                ListView(
                                  shrinkWrap: true,
                                  children: [
                                    ListTile(
                                      title: const Text(
                                        'ヾ( ⌒_⌒ )ノ',
                                        textAlign: TextAlign.center,
                                      ),
                                      subtitle: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: const [
                                          Text(
                                            'Woohoo! No update requests',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          } else {
                            return Column(
                              children: [
                                SizedBox(
                                  height: size.height / 40,
                                ),
                                context
                                            .watch<RequestProvider>()
                                            .tappedRequest ==
                                        null
                                    ? const Text('Select a request to view')
                                    : ListView(
                                        shrinkWrap: true,
                                        children: [
                                          ListTile(
                                            title: Text(context
                                                .read<RequestProvider>()
                                                .tappedRequest
                                                .currName
                                                .toUpperCase()),
                                            subtitle: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(context
                                                        .read<RequestProvider>()
                                                        .tappedRequest
                                                        .currEmail +
                                                    '\n'),
                                                const Text(
                                                  'Requested an update: ',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                const Padding(
                                                  padding: EdgeInsets.only(
                                                    left: 12,
                                                  ),
                                                  child: Text(
                                                    'First Name:',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    left: 24,
                                                  ),
                                                  child: Text(context
                                                          .read<
                                                              RequestProvider>()
                                                          .tappedRequest
                                                          .reqFname +
                                                      '\n'),
                                                ),
                                                const Padding(
                                                  padding: EdgeInsets.only(
                                                    left: 12,
                                                  ),
                                                  child: Text(
                                                    'Middle Initial:',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    left: 24,
                                                  ),
                                                  child: Text(context
                                                          .read<
                                                              RequestProvider>()
                                                          .tappedRequest
                                                          .reqMinitial +
                                                      '\n'),
                                                ),
                                                const Padding(
                                                  padding: EdgeInsets.only(
                                                    left: 12,
                                                  ),
                                                  child: Text(
                                                    'Last Name:',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    left: 24,
                                                  ),
                                                  child: Text(context
                                                          .read<
                                                              RequestProvider>()
                                                          .tappedRequest
                                                          .reqLname +
                                                      '\n'),
                                                ),
                                                const Padding(
                                                  padding: EdgeInsets.only(
                                                    left: 12,
                                                  ),
                                                  child: Text(
                                                    'College:',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                                const Padding(
                                                  padding: EdgeInsets.only(
                                                    left: 12,
                                                  ),
                                                  child: Text(
                                                    'Course:',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                                const Padding(
                                                  padding: EdgeInsets.only(
                                                    left: 12,
                                                  ),
                                                  child: Text(
                                                    'Section:',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    left: 24,
                                                  ),
                                                  child: Text(context
                                                          .read<
                                                              RequestProvider>()
                                                          .tappedRequest
                                                          .reqSection +
                                                      '\n'),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                              top: size.height / 4,
                                              left: size.width / 30,
                                              right: size.width / 30,
                                            ),
                                            child: GFButton(
                                              onPressed: () async {
                                                Navigator.of(context).pushNamed(
                                                    Routes.studentscreen);
                                              },
                                              child: const Text('Update now'),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                              left: size.width / 30,
                                              right: size.width / 30,
                                            ),
                                            child: GFButton(
                                              onPressed: () async {
                                                showDialog(
                                                    context: context,
                                                    barrierDismissible: false,
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertDialog(
                                                        shape: const RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius.all(
                                                                    Radius.circular(
                                                                        20.0))),
                                                        content: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            children: <Widget>[
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child: ListBody(
                                                                  children: <
                                                                      Widget>[
                                                                    Row(
                                                                      children: [
                                                                        Icon(
                                                                          Icons
                                                                              .warning_rounded,
                                                                          color:
                                                                              kPrimaryColor,
                                                                        ),
                                                                        const SizedBox(
                                                                          width:
                                                                              12,
                                                                        ),
                                                                        const Text(
                                                                            'Confirmation'),
                                                                      ],
                                                                    ),
                                                                    const SizedBox(
                                                                      height:
                                                                          21,
                                                                    ),
                                                                    Row(
                                                                      children: const [
                                                                        Expanded(
                                                                          child:
                                                                              Text(
                                                                            'Are you done checking updating the student\'s details?',
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceEvenly,
                                                                  children: <
                                                                      Widget>[
                                                                    Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              8.0),
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          RaisedButton(
                                                                            color:
                                                                                kPrimaryColor,
                                                                            shape:
                                                                                const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(2.0))),
                                                                            child:
                                                                                const Text(
                                                                              "Cancel",
                                                                              style: TextStyle(
                                                                                color: Colors.white,
                                                                              ),
                                                                            ),
                                                                            onPressed:
                                                                                () {
                                                                              Navigator.of(context).pop();
                                                                            },
                                                                          ),
                                                                          const SizedBox(
                                                                            width:
                                                                                12,
                                                                          ),
                                                                          RaisedButton(
                                                                            color:
                                                                                kPrimaryColor,
                                                                            shape:
                                                                                RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(2.0))),
                                                                            child:
                                                                                const Text(
                                                                              "Confirm",
                                                                              style: TextStyle(
                                                                                color: Colors.white,
                                                                              ),
                                                                            ),
                                                                            onPressed:
                                                                                () async {
                                                                              await context.read<RequestProvider>().acceptRequest();
                                                                              Navigator.of(context).pop();
                                                                            },
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      );
                                                    });
                                              },
                                              child: const Text('Done'),
                                            ),
                                          ),
                                        ],
                                      )
                              ],
                            );
                          }
                        }),
                  ),
                ),
              ],
            );
          } else {
            return Center(
              child: Text('no data'),
            );
          }
        },
      ),
    );
  }
}
