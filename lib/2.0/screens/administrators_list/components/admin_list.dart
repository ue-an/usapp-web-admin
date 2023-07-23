import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:provider/provider.dart';
import 'package:web_tut/2.0/constants.dart';
import 'package:web_tut/2.0/providers/localdata_provider.dart';
import 'package:web_tut/models/admin.dart';
import 'package:web_tut/providers/admin_activity_provider.dart';
import 'package:web_tut/providers/admin_provider.dart';
import 'package:web_tut/utils/constants.dart';

class AdminList extends StatefulWidget {
  Stream<List<Admin>> streamAdmins;
  Stream<List<Admin>> streamAdminsDisabled;
  AdminList({
    Key key,
    this.streamAdmins,
    this.streamAdminsDisabled,
  }) : super(key: key);

  @override
  State<AdminList> createState() => _AdminListState();
}

class _AdminListState extends State<AdminList> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        StreamBuilder<List<Admin>>(
            stream: widget.streamAdmins,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.only(
                        left: defaultPadding,
                        right: defaultPadding,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    snapshot.data[index].adminName,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      // color: kMiddleColor,
                                    ),
                                  ),
                                  // const SizedBox(height: defaultPadding),
                                  // Text(snapshot.data[index].adminName),
                                  // const SizedBox(height: defaultPadding),
                                  Row(
                                    children: [
                                      Text(
                                        'Email: ',
                                        style: TextStyle(
                                          // fontSize: 18,
                                          color: kMiddleColor,
                                        ),
                                      ),
                                      Text(snapshot.data[index].email),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'Usertype: ',
                                        style: TextStyle(
                                          // fontSize: 18,
                                          color: kMiddleColor,
                                        ),
                                      ),
                                      Text(snapshot.data[index].usertype),
                                    ],
                                  ),
                                ],
                              ),
                              const Spacer(),
                              GFButton(
                                onPressed: () async {
                                  await context
                                      .read<AdminProvider>()
                                      .disableAdmin(snapshot.data[index].email);
                                  //show snackbar
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content:
                                            Text('Administrator disabled')),
                                  );
                                  //create activity
                                  String myName = await context
                                      .read<LocalDataProvider>()
                                      .getLocalAdminName();

                                  context
                                          .read<AdminActivityProvider>()
                                          .changeActivityTitle =
                                      'Disabled an admin';
                                  context
                                      .read<AdminActivityProvider>()
                                      .changeName = myName;
                                  context
                                      .read<AdminActivityProvider>()
                                      .changeDate = DateTime.now();
                                  context
                                      .read<AdminActivityProvider>()
                                      .addActivity();
                                },
                                color: Colors.red,
                                text: 'Disable',
                              ),
                            ],
                          ),
                          Column(
                            children: const [
                              SizedBox(height: defaultPadding),
                              Divider(),
                              SizedBox(height: defaultPadding),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                );
              } else {
                return Container();
              }
            }),
        Divider(
          thickness: 2,
          color: kMiddleColor,
        ),
        SizedBox(
          height: size.height * .02,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text(
              'Disabled Admins',
              style: TextStyle(
                fontSize: 21,
                // color: kMiddleColor,
              ),
            ),
          ],
        ),
        StreamBuilder<List<Admin>>(
            stream: widget.streamAdminsDisabled,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // SizedBox(
                        //   height: size.height * .02,
                        // ),
                        // const Text(
                        //   'Disabled Admins',
                        //   style: TextStyle(
                        //     fontSize: 21,
                        //     // color: kMiddleColor,
                        //   ),
                        // ),
                        SizedBox(
                          height: size.height * .02,
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                            left: defaultPadding,
                            right: defaultPadding,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        snapshot.data[index].adminName,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          // color: kMiddleColor,
                                        ),
                                      ),
                                      // const SizedBox(height: defaultPadding),
                                      // Text(snapshot.data[index].adminName),
                                      // const SizedBox(height: defaultPadding),
                                      Row(
                                        children: [
                                          Text(
                                            'Email: ',
                                            style: TextStyle(
                                              // fontSize: 18,
                                              color: kMiddleColor,
                                            ),
                                          ),
                                          Text(snapshot.data[index].email),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'Usertype: ',
                                            style: TextStyle(
                                              // fontSize: 18,
                                              color: kMiddleColor,
                                            ),
                                          ),
                                          Text(snapshot.data[index].usertype),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  GFButton(
                                    onPressed: () async {
                                      await context
                                          .read<AdminProvider>()
                                          .enableAdmin(
                                              snapshot.data[index].email);
                                      //show snackbar
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            content:
                                                Text('Administrator enabled.')),
                                      );
                                      //create activity
                                      String myName = await context
                                          .read<LocalDataProvider>()
                                          .getLocalAdminName();
                                      context
                                              .read<AdminActivityProvider>()
                                              .changeActivityTitle =
                                          'Enabled an admin';
                                      context
                                          .read<AdminActivityProvider>()
                                          .changeName = myName;
                                      context
                                          .read<AdminActivityProvider>()
                                          .changeDate = DateTime.now();
                                      context
                                          .read<AdminActivityProvider>()
                                          .addActivity();
                                    },
                                    color: Colors.green,
                                    text: 'Enable',
                                  ),
                                ],
                              ),
                              Column(
                                children: const [
                                  SizedBox(height: defaultPadding),
                                  Divider(),
                                  // SizedBox(height: defaultPadding),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                );
              } else {
                return Container();
              }
            }),
      ],
    );
  }
}
