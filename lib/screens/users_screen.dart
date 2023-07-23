import 'package:flutter/material.dart';
import 'package:flutter_initicon/flutter_initicon.dart';
import 'package:provider/src/provider.dart';
import 'package:web_tut/models/student.dart';
import 'package:web_tut/providers/student_provider.dart';
import 'package:web_tut/utils/constants.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _provider = StudentProvider();
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: FutureBuilder<List<Student>>(
        future: _provider.fetchUsers(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Row(
              children: [
                Container(
                  height: double.infinity,
                  width: size.width / 1.5,
                  color: kPrimaryColor.withOpacity(0.5),
                  child: ListView.builder(
                    physics: AlwaysScrollableScrollPhysics(),
                    shrinkWrap: true,
                    // reverse: true,
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          context.read<StudentProvider>().changeTappedStudent =
                              snapshot.data[index];
                        },
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                title: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    // snapshot.data[index].photoUrl == ''
                                    //     ?
                                    //-----------------
                                    Initicon(
                                      backgroundColor: kSecondaryColor,
                                      text: snapshot.data[index].firstName +
                                          ' ' +
                                          snapshot.data[index].lastName,
                                    ),
                                    //-------------------
                                    // :
                                    // ClipRRect(
                                    //   borderRadius: const BorderRadius.all(
                                    //     Radius.circular(50),
                                    //   ),
                                    //   child: Image.network(
                                    //     snapshot.data[index].photoUrl,
                                    //     height: 40,
                                    //     width: 40,
                                    //     fit: BoxFit.cover,
                                    //   ),
                                    // ),

                                    SizedBox(
                                      width: 9,
                                    ),
                                    //------------
                                    // Column(
                                    //   crossAxisAlignment:
                                    //       CrossAxisAlignment.start,
                                    //   children: [
                                    //     Row(
                                    //       children: [
                                    //         Text(
                                    //           (snapshot.data[index].firstName +
                                    //                   ' ' +
                                    //                   snapshot
                                    //                       .data[index].lastName +
                                    //                   ', ')
                                    //               .toUpperCase(),
                                    //           style: TextStyle(
                                    //               // color: snapshot.data[index]
                                    //               //             .studentNumber ==
                                    //               //         context
                                    //               //             .read<
                                    //               //                 NotFutureDetailsProvider2>()
                                    //               //             .studentNumber
                                    //               //     ? kPrimaryColor
                                    //               //     : Colors.white,
                                    //               ),
                                    //         ),
                                    //         SizedBox(
                                    //           width: 6,
                                    //         ),
                                    //         Text(
                                    //             '(${snapshot.data[index].college})')
                                    //       ],
                                    //     ),
                                    //     Text(snapshot.data[index].yearSec),
                                    //     // (() {
                                    //     //   // print(snapshot
                                    //     //   //     .data![index].studentNumber);
                                    //     //   // print(context
                                    //     //   //     .read<
                                    //     //   //         NotFutureDetailsProvider2>()
                                    //     //   //     .studentNumber);

                                    //     //   return Container();
                                    //     // }()),
                                    //     SizedBox(
                                    //       height: 3,
                                    //     ),
                                    //   ],
                                    // ),
                                    Text(
                                      (snapshot.data[index].firstName +
                                              ' ' +
                                              snapshot.data[index].lastName)
                                          .toUpperCase(),
                                    ),
                                  ],
                                ),
                                // title: Text(''),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.width / 20),
                              child: Divider(
                                thickness: 1,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  height: double.infinity,
                  width: size.width / 5.4,
                  color: Colors.white,
                  child: ListView.builder(
                    physics: AlwaysScrollableScrollPhysics(),
                    shrinkWrap: true,
                    // reverse: true,
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          context.watch<StudentProvider>().tappedStudent == null
                              ? Container(
                                  margin:
                                      EdgeInsets.only(top: size.height / 2.2),
                                  child: Text('Choose a thread to view'),
                                )
                              : Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ListTile(
                                    title: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        // snapshot.data[index].photoUrl == ''
                                        //     ?
                                        //-----------------
                                        Initicon(
                                          size: 120,
                                          backgroundColor: kSecondaryColor,
                                          text: context
                                                  .read<StudentProvider>()
                                                  .tappedStudent
                                                  .firstName +
                                              ' ' +
                                              context
                                                  .read<StudentProvider>()
                                                  .tappedStudent
                                                  .lastName,
                                        ),
                                        //-------------------
                                        // :
                                        // ClipRRect(
                                        //   borderRadius: const BorderRadius.all(
                                        //     Radius.circular(50),
                                        //   ),
                                        //   child: Image.network(
                                        //     snapshot.data[index].photoUrl,
                                        //     height: 40,
                                        //     width: 40,
                                        //     fit: BoxFit.cover,
                                        //   ),
                                        // ),
                                        SizedBox(
                                          height: 21,
                                        ),
                                        Text(
                                          (context
                                                      .read<StudentProvider>()
                                                      .tappedStudent
                                                      .firstName +
                                                  ' ' +
                                                  context
                                                      .read<StudentProvider>()
                                                      .tappedStudent
                                                      .lastName)
                                              .toUpperCase(),
                                        ),
                                      ],
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          height: 9,
                                        ),
                                        Text(
                                          context
                                              .read<StudentProvider>()
                                              .tappedStudent
                                              .studentNumber,
                                        ),
                                        Text(
                                          context
                                              .read<StudentProvider>()
                                              .tappedStudent
                                              .yearLvl
                                              .toString(),
                                        ),
                                        Text(
                                          context
                                              .read<StudentProvider>()
                                              .tappedStudent
                                              .section
                                              .toString(),
                                        ),
                                        Text(
                                          context
                                              .read<StudentProvider>()
                                              .tappedStudent
                                              .college,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: size.width / 20),
                            child: Divider(
                              thickness: 1,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
