import 'package:flutter/material.dart';
import 'package:getwidget/components/checkbox/gf_checkbox.dart';
import 'package:getwidget/getwidget.dart';
import 'package:provider/provider.dart';
import 'package:web_tut/2.0/responsive.dart';
import 'package:web_tut/2.0/screens/reported_forums/components/reported_info_card.dart';
import 'package:web_tut/2.0/screens/update_details_request/components/request_info_card.dart';
import 'package:web_tut/2.0/screens/update_details_request/components/selection_request.dart';
import 'package:web_tut/models/report.dart';
import 'package:web_tut/models/request.dart';
import 'package:web_tut/providers/report_provider.dart';
import 'package:web_tut/providers/request_provider.dart';

import '../../../constants.dart';

class RequestList extends StatefulWidget {
  Stream<List<Request>> streamUpdateRequests;
  RequestList({
    Key key,
    this.streamUpdateRequests,
  }) : super(key: key);

  @override
  State<RequestList> createState() => _RequestListState();
}

class _RequestListState extends State<RequestList>
    with AutomaticKeepAliveClientMixin<RequestList> {
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
    final Size _size = MediaQuery.of(context).size;
    return Column(
      children: [
        StreamBuilder<List<Request>>(
            stream: widget.streamUpdateRequests,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasData) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(Icons.report_gmailerrorred),
                    const SizedBox(
                      width: 6,
                    ),
                    Text(
                      "Update Requests:",
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    Text(' (' + snapshot.data.length.toString() + ')'),
                  ],
                );
              } else {
                return Container();
              }
            }),
        const SizedBox(height: defaultPadding),
        Responsive(
          mobile: UpdateRequestsCardGridView(
            crossAxisCount: _size.width < 650 ? 2 : 4,
            childAspectRatio: _size.width < 650 && _size.width > 350 ? 1.3 : 1,
            streamRequests: widget.streamUpdateRequests,
          ),
          tablet: UpdateRequestsCardGridView(
            streamRequests: widget.streamUpdateRequests,
          ),
          desktop: UpdateRequestsCardGridView(
            childAspectRatio: _size.width < 1400 ? 1.1 : 1.4,
            streamRequests: widget.streamUpdateRequests,
          ),
        ),
      ],
    );
  }
}

class UpdateRequestsCardGridView extends StatefulWidget {
  Stream<List<Request>> streamRequests;
  BuildContext context;
  UpdateRequestsCardGridView({
    Key key,
    this.crossAxisCount = 4,
    this.childAspectRatio = 1,
    this.streamRequests,
    this.context,
  }) : super(key: key);

  final int crossAxisCount;
  final double childAspectRatio;

  @override
  State<UpdateRequestsCardGridView> createState() =>
      _UpdateRequestsCardGridViewState();
}

class _UpdateRequestsCardGridViewState extends State<UpdateRequestsCardGridView>
    with AutomaticKeepAliveClientMixin<UpdateRequestsCardGridView> {
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
  Widget build(BuildContext contexts) {
    return StreamBuilder<List<Request>>(
        stream: widget.streamRequests,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            snapshot.data.sort((a, b) =>
                a.isAccepted.toString().compareTo(b.isAccepted.toString()));
            return GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: snapshot.data.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: widget.crossAxisCount,
                  crossAxisSpacing: defaultPadding,
                  mainAxisSpacing: defaultPadding,
                  childAspectRatio: widget.childAspectRatio,
                ),
                itemBuilder: (context, index) {
                  if (snapshot.data[index].isAccepted == false) {
                    return Stack(
                      children: [
                        GestureDetector(
                          onTap: () {
                            //set have selections to true
                            context
                                .read<SelectionRequestProvider>()
                                .haveSelections = true;
                            //set tappedReport (only one, current forum) for viewing
                            context
                                .read<RequestProvider>()
                                .changeTappedRequest = snapshot.data[index];
                            context.read<RequestProvider>().changeTappedEmail =
                                snapshot.data[index].currEmail;
                          },
                          child: RequestInfoCard(
                            info: Request(
                              currEmail: snapshot.data[index].currEmail,
                              currCollege: snapshot.data[index].currCollege,
                              currName: snapshot.data[index].currName,
                              reqSection: snapshot.data[index].reqSection,
                              reqFname: snapshot.data[index].reqFname,
                              reqMinitial: snapshot.data[index].reqMinitial,
                              reqLname: snapshot.data[index].reqLname,
                            ),
                          ),
                        ),
                        context.watch<RequestProvider>().tappedRequest ==
                                snapshot.data[index]
                            ? const Icon(Icons.check_box)
                            : Container(),
                      ],
                    );
                  } else {
                    return Container();
                  }
                });
          } else {
            return Container(
              child: const Text('No data'),
            );
          }
        });
  }
}
