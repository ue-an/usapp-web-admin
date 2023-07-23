import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:web_tut/2.0/screens/thread_reply/thread_reply_provider.dart';
import 'package:web_tut/models/replyer.dart';
import 'package:web_tut/models/thread_reply.dart';
import 'package:web_tut/services/firestore_service.dart';
import 'package:web_tut/utils/constants.dart';

class ThreadReplyWidget extends StatefulWidget {
  String commentID;
  String myFullName;
  String myEmail;
  String myDeviceToken;
  String myStudentNumber;
  String mySection;
  String commentContent;
  String commenterToken;
  List<String> othersNames;
  String threadID;
  String threadTitle;
  String threadDescription;
  String formattedDate;
  String threadCreatorID;
  String creatorSection;
  String creatorName;
  List likersTokens;
  String authorToken;

  ThreadReplyWidget({
    Key key,
    this.commentID,
    this.commentContent,
    this.commenterToken,
    this.myDeviceToken,
    this.myEmail,
    this.myFullName,
    this.myStudentNumber,
    this.mySection,
    this.othersNames,
    this.threadID,
    this.threadTitle,
    this.threadDescription,
    this.formattedDate,
    this.threadCreatorID,
    this.creatorSection,
    this.creatorName,
    this.likersTokens,
    this.authorToken,
  }) : super(key: key);

  @override
  State<ThreadReplyWidget> createState() => _ThreadReplyWidgetState();
}

class _ThreadReplyWidgetState extends State<ThreadReplyWidget>
    with AutomaticKeepAliveClientMixin<ThreadReplyWidget> {
  bool _isVisited = false;
  @override
  bool get wantKeepAlive => _isVisited;

  FirestoreService firestoreService = FirestoreService();
  Stream<List<ThreadReply>> _streamThreadReply;
  final replyCtrl = TextEditingController();
  final threadReplyScroll = ScrollController();

  @override
  void initState() {
    _streamThreadReply = context.read<ThreadReplyProvider>().getThreadReplyy;
    setState(() {
      _isVisited = true;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return StreamBuilder<List<ThreadReply>>(
      stream: _streamThreadReply,
      builder: (context, replySnap) {
        // if (replySnap.connectionState == ConnectionState.waiting) {
        //   return const Center(
        //     child: CircularProgressIndicator(),
        //   );
        // }
        if (replySnap.hasData) {
          replySnap.data.sort((a, b) => a.replyDate.compareTo(b.replyDate));
          return ListView.builder(
            controller: threadReplyScroll,
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            itemCount: replySnap.data.length,
            itemBuilder: (context, index) {
              ThreadReply reply;
              reply = replySnap.data[index];
              Replyer replyer = reply.replyBy;
              DateTime myDateTime = reply.replyDate.toDate();
              String formattedDate =
                  DateFormat('yyyy-MM-dd – KK:mm a (EEE)').format(myDateTime);
              print(reply.toMap());
              return IntrinsicHeight(
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: size.width * .1,
                      ),
                      child: const VerticalDivider(
                        color: Colors.grey,
                        thickness: 1,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        // padding: EdgeInsets.only(
                        //   left: size.width * .1,
                        // ),
                        child: ListTile(
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                replyer.name,
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                replyer.section,
                                style: const TextStyle(
                                  color: Colors.white30,
                                  fontSize: 9,
                                ),
                              ),
                              Container(
                                // padding: EdgeInsets.only(
                                //   left: size.width * .02,
                                // ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Text(
                                    //   reply.content,
                                    //   style: const TextStyle(
                                    //     color: Colors.white,
                                    //   ),
                                    // ),
                                    reply.photo != ''
                                        ? Image.network(
                                            reply.photo,
                                            // height: size.height,
                                            width: size.width,
                                          )
                                        : Padding(
                                            padding: const EdgeInsets.only(
                                                // top: 5.0,
                                                // bottom: 16.0,
                                                ),
                                            child: Text(reply.content),
                                          ),
                                    Text(
                                      'Replied • ' + formattedDate,
                                      style: const TextStyle(
                                        color: Colors.white30,
                                        fontSize: 9,
                                      ),
                                    ),

                                    const Divider(
                                      thickness: 1,
                                      color: Colors.white30,
                                      // endIndent: size.width * .13,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        } else {
          // return const Center(
          //   child: CircularProgressIndicator(),
          // );
          return Container();
        }
      },
    );
  }

  ///Wrapping mentioned users with brackets to identify them easily
  String _replaceMentions(String text) {
    widget.othersNames.map((u) => u).toSet().forEach((userName) {
      text = text.replaceAll('@$userName', '[@$userName]');
    });
    return text;
  }
}
