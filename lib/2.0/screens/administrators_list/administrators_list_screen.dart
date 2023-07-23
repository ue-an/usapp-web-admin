import 'package:flutter/material.dart';
import 'package:web_tut/2.0/constants.dart';
import 'package:web_tut/2.0/responsive.dart';
import 'package:web_tut/2.0/screens/administrators_list/components/admin_list.dart';
import 'package:web_tut/2.0/screens/administrators_list/components/header.dart';
import 'package:web_tut/2.0/screens/administrators_list/components/logged_admin.dart';
import 'package:web_tut/models/admin.dart';
import 'package:web_tut/services/firestore_service.dart';

class AdministratorsListScreen extends StatefulWidget {
  const AdministratorsListScreen({Key key}) : super(key: key);

  @override
  State<AdministratorsListScreen> createState() =>
      _AdministratorsListScreenState();
}

class _AdministratorsListScreenState extends State<AdministratorsListScreen>
    with AutomaticKeepAliveClientMixin<AdministratorsListScreen> {
  bool _isVisited = false;
  @override
  bool get wantKeepAlive => _isVisited;
  FirestoreService firestoreService = FirestoreService();
  Stream<List<Admin>> _streamAdmins;
  Stream<List<Admin>> _streamAdminsDisabled;
  @override
  void initState() {
    _streamAdmins = firestoreService.getAdminsList();
    _streamAdminsDisabled = firestoreService.getAdminsListDisabled();
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
          const Header(),
          const SizedBox(height: defaultPadding),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 5,
                child: Column(
                  children: [
                    AdminList(
                      streamAdmins: _streamAdmins,
                      streamAdminsDisabled: _streamAdminsDisabled,
                    ),
                    const SizedBox(height: defaultPadding),
                    if (Responsive.isMobile(context))
                      const SizedBox(
                        height: defaultPadding,
                      ),
                    if (Responsive.isMobile(context))
                      AdminList(
                        streamAdmins: _streamAdmins,
                        streamAdminsDisabled: _streamAdminsDisabled,
                      ),
                  ],
                ),
              ),
              if (!Responsive.isMobile(context))
                const SizedBox(width: defaultPadding),
              // On Mobile means if the screen is less than 850 we dont want to show it
              if (!Responsive.isMobile(context))
                const Expanded(
                  flex: 2,
                  // child: AdminList(
                  //   streamAdmins: _streamAdmins,
                  // ),
                  child: LoggedAdmin(),
                ),
            ],
          ),
        ],
      ),
    ));
  }
}
