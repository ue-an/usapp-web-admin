import 'package:flutter/material.dart';
import 'package:web_tut/2.0/constants.dart';
import 'package:web_tut/2.0/responsive.dart';
import 'package:web_tut/2.0/screens/update_details_request/components/header.dart';
import 'package:web_tut/2.0/screens/update_details_request/components/request_list.dart';
import 'package:web_tut/2.0/screens/update_details_request/components/requests_total.dart';
import 'package:web_tut/models/request.dart';
import 'package:web_tut/services/firestore_service.dart';

class UpdateRequestScreen2 extends StatefulWidget {
  const UpdateRequestScreen2({Key key}) : super(key: key);

  @override
  State<UpdateRequestScreen2> createState() => _UpdateRequestScreen2State();
}

class _UpdateRequestScreen2State extends State<UpdateRequestScreen2>
    with AutomaticKeepAliveClientMixin<UpdateRequestScreen2> {
  bool _isVisited = false;
  @override
  bool get wantKeepAlive => _isVisited;
  FirestoreService firestoreService = FirestoreService();
  Stream<List<Request>> _streamRequests;
  @override
  void initState() {
    _streamRequests = firestoreService.getRequests();
    setState(() {
      _isVisited = true;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            //header
            const Header(),
            const SizedBox(height: defaultPadding),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  // child: Container(),
                  child: Column(
                    children: [
                      RequestList(
                        streamUpdateRequests: _streamRequests,
                      ),
                      if (Responsive.isMobile(context))
                        const SizedBox(
                          height: defaultPadding,
                        ),
                      if (Responsive.isMobile(context))
                        RequestsTotal(
                          streamRequests: _streamRequests,
                        ),
                    ],
                  ),
                ),
                if (!Responsive.isMobile(context))
                  const SizedBox(width: defaultPadding),
                // On Mobile means if the screen is less than 850 we dont want to show it
                if (!Responsive.isMobile(context))
                  Expanded(
                    flex: 2,
                    child: RequestsTotal(
                      streamRequests: _streamRequests,
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
