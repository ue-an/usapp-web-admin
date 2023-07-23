import 'package:flutter/material.dart';
import 'package:web_tut/2.0/screens/update_details_request/components/chart.dart';
import 'package:web_tut/2.0/screens/update_details_request/components/request_bycollege_card.dart';
import 'package:web_tut/models/report.dart';
import 'package:web_tut/models/request.dart';
import 'package:web_tut/models/student.dart';
import 'package:web_tut/models/thread.dart';
import '../../../constants.dart';

class RequestsTotal extends StatefulWidget {
  Stream<List<Request>> streamRequests;
  RequestsTotal({
    Key key,
    this.streamRequests,
  }) : super(key: key);

  @override
  State<RequestsTotal> createState() => _RequestsTotalState();
}

class _RequestsTotalState extends State<RequestsTotal>
    with AutomaticKeepAliveClientMixin<RequestsTotal> {
  bool _isVisited = false;
  @override
  bool get wantKeepAlive => _isVisited;
  @override
  void initState() {
    setState(() {
      _isVisited = true;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Request>>(
        stream: widget.streamRequests,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasData) {
            List<Request> ccsRequests = [];
            List<Request> cobRequests = [];
            List<Request> coaRequests = [];
            for (var request in snapshot.data) {
              if (request.currCollege == 'CCS' && request.isAccepted == false) {
                ccsRequests.add(request);
              }
              if (request.currCollege == 'COA' && request.isAccepted == false) {
                coaRequests.add(request);
              }
              if (request.currCollege == 'COB' && request.isAccepted == false) {
                cobRequests.add(request);
              }
            }
            return Container(
              padding: const EdgeInsets.all(defaultPadding),
              decoration: const BoxDecoration(
                color: secondaryColor,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        snapshot.data.length > 1
                            ? "Pending Requests"
                            : "Pending Request",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      const Icon(Icons.report_gmailerrorred),
                    ],
                  ),
                  const SizedBox(height: defaultPadding),
                  Chart(
                    totalRequests: snapshot.data.length,
                    streamedRequests: snapshot.data,
                    coaRequests: coaRequests,
                    cobRequests: cobRequests,
                    ccsRequests: ccsRequests,
                  ),
                  RequestByCollegeCard(
                    imgSource: "assets/images/ic_coa-logo.png",
                    title: "College of Accountancy",
                    numOfFiles: coaRequests.length,
                  ),
                  RequestByCollegeCard(
                    imgSource: "assets/images/ic_cob-logo.png",
                    title: "College of Business",
                    numOfFiles: cobRequests.length,
                  ),
                  RequestByCollegeCard(
                    imgSource: "assets/images/ic_ccs-logo.png",
                    title: "College of Computer Studies",
                    numOfFiles: ccsRequests.length,
                  ),
                ],
              ),
            );
          } else {
            return Container(
              child: const Text('no data'),
            );
          }
        });
  }
}
