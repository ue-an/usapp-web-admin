import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:provider/provider.dart';
import 'package:web_tut/models/student.dart';
import 'package:web_tut/providers/student_provider.dart';

class ListStudNumbers extends StatefulWidget {
  const ListStudNumbers({
    Key key,
    this.studnumCtrl,
  }) : super(key: key);

  final TextEditingController studnumCtrl;

  @override
  State<ListStudNumbers> createState() => _ListStudNumbersState();
}

class _ListStudNumbersState extends State<ListStudNumbers> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Student>>(
      stream: context.watch<StudentProvider>().students,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data.length,
            // itemCount: 3,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  title: Text(snapshot.data[index].studentNumber),
                  subtitle: Text(snapshot.data[index].firstName +
                      " " +
                      snapshot.data[index].mInitial +
                      " " +
                      snapshot.data[index].lastName),
                  trailing: IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              backgroundColor: Colors.blue,
                              contentPadding: EdgeInsets.zero,
                              titlePadding: const EdgeInsets.only(top: 12),
                              elevation: 15,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(32.0),
                                ),
                                side: BorderSide(color: Colors.blue, width: 4),
                              ),
                              title: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 15, horizontal: 18),
                                    child: Text(
                                      "Remove Student Number",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  )),
                              content: Expanded(
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height / 4,
                                  width:
                                      MediaQuery.of(context).size.width / 2.5,
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(32),
                                        bottomRight: Radius.circular(32)),
                                    color: Colors.white,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 36,
                                      horizontal: 20,
                                    ),
                                    child: Column(
                                      children: [
                                        //body
                                        const Expanded(
                                          child: Text(
                                              "Do you really want to remove this Student Number?"),
                                        ),
                                        const SizedBox(),
                                        //bottom buttons\
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            GFButton(
                                              onPressed: () {
                                                context
                                                    .read<StudentProvider>()
                                                    .removeStudent(snapshot
                                                        .data[index]
                                                        .studentNumber);
                                                Navigator.of(context,
                                                        rootNavigator: true)
                                                    .pop();
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  const SnackBar(
                                                    duration: Duration(
                                                        milliseconds: 800),
                                                    content: Text(
                                                        'Successfully removed!'),
                                                  ),
                                                );
                                                widget.studnumCtrl.clear();
                                              },
                                              color: Colors.red,
                                              child: const Text("Remove"),
                                            ),
                                            GFButton(
                                              onPressed: () {
                                                Navigator.of(context,
                                                        rootNavigator: true)
                                                    .pop();
                                                widget.studnumCtrl.clear();
                                              },
                                              color: Colors.blue,
                                              child: const Text("Cancel"),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          });
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  ),
                  // title: Text("Hello"),
                ),
              );
            });
      },
    );
  }
}
