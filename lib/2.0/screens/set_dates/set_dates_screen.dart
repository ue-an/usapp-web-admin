import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:web_tut/2.0/constants.dart';
import 'package:web_tut/2.0/providers/localdata_provider.dart';
import 'package:web_tut/2.0/responsive.dart';
import 'package:web_tut/2.0/screens/set_dates/components/current_acadyear_dates.dart';
import 'package:web_tut/2.0/screens/set_dates/components/header.dart';
import 'package:web_tut/models/academic_year_dates.dart';
import 'package:web_tut/providers/admin_activity_provider.dart';
import 'package:web_tut/providers/ay_dates_provider.dart';
import 'package:web_tut/services/firestore_service.dart';
import 'package:web_tut/utils/constants.dart';

class SetDatesScreen extends StatefulWidget {
  const SetDatesScreen({Key key}) : super(key: key);

  @override
  State<SetDatesScreen> createState() => _SetDatesScreenState();
}

class _SetDatesScreenState extends State<SetDatesScreen>
    with AutomaticKeepAliveClientMixin<SetDatesScreen> {
  bool _isVisited = false;
  FirestoreService firestoreService = FirestoreService();
  Stream<List<AcademicYearDates>> _streamAYDates;
  Stream<List<AcademicYearDates>> _streamAYDates2;

  @override
  void initState() {
    _streamAYDates = firestoreService.getAcademicYearDates();
    _streamAYDates2 = firestoreService.getAcademicYearDates();
    setState(() {
      _isVisited = true;
    });
    super.initState();
  }

  @override
  bool get wantKeepAlive => _isVisited;
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
            StreamBuilder<List<AcademicYearDates>>(
                stream: _streamAYDates,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasData) {
                    AcademicYearDates ayDateSnap = snapshot.data[0];
                    //get acaddate 'date' only (w/o time) of AY start
                    String ayStartDateOnly = DateFormat("MM-dd-yyyy")
                        .format(ayDateSnap.ayStart.toDate());
                    //get acaddate 'date' only (w/o time) of AY end
                    String ayEndDateOnly = DateFormat("MM-dd-yyyy")
                        .format(ayDateSnap.ayEnd.toDate());
                    //get acaddate 'date' only (w/o time) of enrollment
                    String ayEnrollDateOnly = DateFormat("MM-dd-yyyy")
                        .format(ayDateSnap.enrollDate.toDate());
                    //get date now (w/o time)
                    String dateNowOnly =
                        DateFormat("MM-dd-yyyy").format(DateTime.now());

                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 5,
                          child: Container(
                            padding: EdgeInsets.only(
                              left: size.width / 50,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //set AY year START
                                Text(
                                  'Start of Academic Year:',
                                  style: TextStyle(
                                    fontSize: 21,
                                    color: kMiddleColor,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      ayDateSnap.currentYear.toString(),
                                      style: TextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                    GFButton(
                                      onPressed: () async {
                                        List years = [];
                                        for (var i = 2021; i <= 3000; i++) {
                                          years.add(i);
                                        }
                                        await showDialog(
                                          context: context,
                                          builder: (context) {
                                            final Size size =
                                                MediaQuery.of(context).size;
                                            return AlertDialog(
                                              title: Text('Select a Year'),
                                              // Changing default contentPadding to make the content looks better

                                              contentPadding:
                                                  const EdgeInsets.all(10),
                                              content: SizedBox(
                                                // Giving some size to the dialog so the gridview know its bounds

                                                height: size.height / 3,
                                                width: size.width / 2,
                                                //  Creating a grid view with 3 elements per line.
                                                child: GridView.count(
                                                  crossAxisCount: 7,
                                                  children: [
                                                    // Generating a list of 123 years starting from 2022
                                                    // Change it depending on your needs.
                                                    ...List.generate(
                                                      979,
                                                      (index) => InkWell(
                                                        onTap: () async {
                                                          // The action you want to happen when you select the year below,
                                                          print(years[index]);
                                                          // picked = years[index];
                                                          context
                                                                  .read<
                                                                      AYDatesProvider>()
                                                                  .changePickedCurrentYear =
                                                              years[index];
                                                          Future.delayed(
                                                              const Duration(
                                                                  milliseconds:
                                                                      500), () {
                                                            Navigator.pop(
                                                                context);
                                                          });
                                                        },
                                                        // This part is up to you, it's only ui elements
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Chip(
                                                            label: Container(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(5),
                                                              child: Text(
                                                                // Showing the year text, it starts from 2022 and ends in 1900 (you can modify this as you like)
                                                                (2021 + index)
                                                                    .toString(),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                        int picked = context
                                            .read<AYDatesProvider>()
                                            .pickedCurrentYear;
                                        if ((picked != null &&
                                                picked !=
                                                    ayDateSnap.currentYear) &&
                                            picked < ayDateSnap.nextYear) {
                                          context
                                              .read<AYDatesProvider>()
                                              .changePickedCurrentYear = picked;
                                          context
                                              .read<AYDatesProvider>()
                                              .setAYstartYear();
                                          //create activity
                                          String myName = await context
                                              .read<LocalDataProvider>()
                                              .getLocalAdminName();
                                          context
                                                  .read<AdminActivityProvider>()
                                                  .changeActivityTitle =
                                              'Set Start of Academic Year';
                                          context
                                              .read<AdminActivityProvider>()
                                              .changeName = myName;
                                          context
                                              .read<AdminActivityProvider>()
                                              .changeDate = DateTime.now();
                                          await context
                                              .read<AdminActivityProvider>()
                                              .addActivity();
                                        } else {
                                          if (picked == null) {
                                            null;
                                          } else {
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
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: <Widget>[
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
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
                                                                      width: 12,
                                                                    ),
                                                                    const Text(
                                                                        'Invalid Year'),
                                                                  ],
                                                                ),
                                                                const SizedBox(
                                                                  height: 21,
                                                                ),
                                                                Row(
                                                                  children: const [
                                                                    Expanded(
                                                                      child:
                                                                          Text(
                                                                        'The new Starting Academic Year should be less than the end of Academic Year and must not be the same as this year.',
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
                                                                    .all(8.0),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceEvenly,
                                                              children: <
                                                                  Widget>[
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child:
                                                                      RaisedButton(
                                                                    color:
                                                                        kPrimaryColor,
                                                                    shape: const RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.all(Radius.circular(2.0))),
                                                                    child:
                                                                        const Text(
                                                                      "Close",
                                                                      style:
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                    ),
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop();
                                                                    },
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
                                          }
                                        }
                                      },
                                      size: GFSize.SMALL,
                                      text: 'Set Date',
                                    ),
                                    Container(),
                                  ],
                                ),
                                SizedBox(
                                  height: 21,
                                ),
                                //set AY year END
                                Text(
                                  'End of Academic Year:',
                                  style: TextStyle(
                                    fontSize: 21,
                                    color: kMiddleColor,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      ayDateSnap.nextYear.toString(),
                                    ),
                                    GFButton(
                                      onPressed: () async {
                                        List years = [];
                                        for (var i = 2021; i <= 3000; i++) {
                                          years.add(i);
                                        }
                                        DateTime.now().year >
                                                ayDateSnap.nextYear
                                            ? await showDialog(
                                                context: context,
                                                builder: (context) {
                                                  final Size size =
                                                      MediaQuery.of(context)
                                                          .size;
                                                  return AlertDialog(
                                                    title:
                                                        Text('Select a Year'),
                                                    // Changing default contentPadding to make the content looks better

                                                    contentPadding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    content: SizedBox(
                                                      // Giving some size to the dialog so the gridview know its bounds

                                                      height: size.height / 3,
                                                      width: size.width / 2,
                                                      //  Creating a grid view with 3 elements per line.
                                                      child: GridView.count(
                                                        crossAxisCount: 7,
                                                        children: [
                                                          // Generating a list of 123 years starting from 2022
                                                          // Change it depending on your needs.
                                                          ...List.generate(
                                                            979,
                                                            (index) => InkWell(
                                                              onTap: () async {
                                                                // The action you want to happen when you select the year below,
                                                                print(years[
                                                                    index]);
                                                                // picked = years[index];
                                                                context
                                                                        .read<
                                                                            AYDatesProvider>()
                                                                        .changePickedNextYear =
                                                                    years[
                                                                        index];
                                                                Future.delayed(
                                                                    const Duration(
                                                                        milliseconds:
                                                                            500),
                                                                    () {
                                                                  Navigator.pop(
                                                                      context);
                                                                });
                                                              },
                                                              // This part is up to you, it's only ui elements
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child: Chip(
                                                                  label:
                                                                      Container(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(5),
                                                                    child: Text(
                                                                      // Showing the year text, it starts from 2022 and ends in 1900 (you can modify this as you like)
                                                                      (2021 + index)
                                                                          .toString(),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                },
                                              )
                                            : await showDialog(
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
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: <Widget>[
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
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
                                                                      width: 12,
                                                                    ),
                                                                    const Text(
                                                                        'Not Available Yet'),
                                                                  ],
                                                                ),
                                                                const SizedBox(
                                                                  height: 21,
                                                                ),
                                                                Row(
                                                                  children: const [
                                                                    Expanded(
                                                                      child:
                                                                          Text(
                                                                        'The current academic year has not ended yet. Updating this data isn\'t available.',
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
                                                                    .all(8.0),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceEvenly,
                                                              children: <
                                                                  Widget>[
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child:
                                                                      RaisedButton(
                                                                    color:
                                                                        kPrimaryColor,
                                                                    shape: const RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.all(Radius.circular(2.0))),
                                                                    child:
                                                                        const Text(
                                                                      "Close",
                                                                      style:
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                    ),
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop();
                                                                    },
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
                                        int picked = context
                                            .read<AYDatesProvider>()
                                            .pickedNextYear;
                                        if ((picked != null &&
                                                picked !=
                                                    ayDateSnap.nextYear) &&
                                            picked > ayDateSnap.nextYear) {
                                          context
                                              .read<AYDatesProvider>()
                                              .changePickedNextYear = picked;
                                          context
                                              .read<AYDatesProvider>()
                                              .setAYendYear();
                                          //create activity
                                          String myName = await context
                                              .read<LocalDataProvider>()
                                              .getLocalAdminName();
                                          context
                                                  .read<AdminActivityProvider>()
                                                  .changeActivityTitle =
                                              'Set End of Academic Year';
                                          context
                                              .read<AdminActivityProvider>()
                                              .changeName = myName;
                                          context
                                              .read<AdminActivityProvider>()
                                              .changeDate = DateTime.now();
                                          await context
                                              .read<AdminActivityProvider>()
                                              .addActivity();
                                          print('heyyy');
                                        } else {
                                          if (picked == null) {
                                            null;
                                          } else {
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
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: <Widget>[
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
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
                                                                      width: 12,
                                                                    ),
                                                                    const Text(
                                                                        'Invalid Year'),
                                                                  ],
                                                                ),
                                                                const SizedBox(
                                                                  height: 21,
                                                                ),
                                                                Row(
                                                                  children: const [
                                                                    Expanded(
                                                                      child:
                                                                          Text(
                                                                        'The new End of Academic Year should be greater than the previous or current year this year.',
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
                                                                    .all(8.0),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceEvenly,
                                                              children: <
                                                                  Widget>[
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child:
                                                                      RaisedButton(
                                                                    color:
                                                                        kPrimaryColor,
                                                                    shape: const RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.all(Radius.circular(2.0))),
                                                                    child:
                                                                        const Text(
                                                                      "Close",
                                                                      style:
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                    ),
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop();
                                                                    },
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
                                          }
                                        }
                                      },
                                      size: GFSize.SMALL,
                                      text: 'Set Date',
                                    ),
                                    Container(),
                                  ],
                                ),
                                SizedBox(
                                  height: 21,
                                ),
                                //set Enroll date
                                Text(
                                  'Enrollment Date:',
                                  style: TextStyle(
                                    fontSize: 21,
                                    color: kMiddleColor,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      ayEnrollDateOnly,
                                    ),
                                    GFButton(
                                      onPressed: () async {
                                        final DateTime picked =
                                            await showDatePicker(
                                          context: context,
                                          initialDate: ayDateSnap.enrollDate
                                              .toDate(), // Refer step 1
                                          firstDate: DateTime(2021),
                                          lastDate: DateTime(3000),
                                        );
                                        if (picked != null &&
                                            picked !=
                                                ayDateSnap.enrollDate
                                                    .toDate()) {
                                          context
                                              .read<AYDatesProvider>()
                                              .changePickedEnrollDate = picked;
                                        }
                                        context
                                            .read<AYDatesProvider>()
                                            .setEnrollDate();
                                        //create activity
                                        String myName = await context
                                            .read<LocalDataProvider>()
                                            .getLocalAdminName();
                                        context
                                                .read<AdminActivityProvider>()
                                                .changeActivityTitle =
                                            'Set enrollment date';
                                        context
                                            .read<AdminActivityProvider>()
                                            .changeName = myName;
                                        context
                                            .read<AdminActivityProvider>()
                                            .changeDate = DateTime.now();
                                        await context
                                            .read<AdminActivityProvider>()
                                            .addActivity();
                                      },
                                      size: GFSize.SMALL,
                                      text: 'Set Date',
                                    ),
                                    Container(),
                                  ],
                                ),

                                SizedBox(
                                  height: 21,
                                ),
                                //set SEMESTER START
                                Text(
                                  'Start of Current Semester:',
                                  style: TextStyle(
                                    fontSize: 21,
                                    color: kMiddleColor,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      ayStartDateOnly,
                                    ),
                                    GFButton(
                                      onPressed: () async {
                                        // _selectAYstartDate(context);
                                        final DateTime picked =
                                            await showDatePicker(
                                          context: context,
                                          initialDate: ayDateSnap.ayStart
                                              .toDate(), // Refer step 1
                                          firstDate: DateTime(2021),
                                          lastDate: DateTime(3000),
                                        );
                                        if (picked != null &&
                                            picked !=
                                                ayDateSnap.ayStart.toDate()) {
                                          context
                                              .read<AYDatesProvider>()
                                              .changePickedAYstartDate = picked;
                                        }
                                        context
                                            .read<AYDatesProvider>()
                                            .setAYstartSem();
                                        //create activity
                                        String myName = await context
                                            .read<LocalDataProvider>()
                                            .getLocalAdminName();
                                        context
                                                .read<AdminActivityProvider>()
                                                .changeActivityTitle =
                                            'Set Start of Semester Date';
                                        context
                                            .read<AdminActivityProvider>()
                                            .changeName = myName;
                                        context
                                            .read<AdminActivityProvider>()
                                            .changeDate = DateTime.now();
                                        await context
                                            .read<AdminActivityProvider>()
                                            .addActivity();
                                      },
                                      size: GFSize.SMALL,
                                      text: 'Set Date',
                                    ),
                                    Container(),
                                  ],
                                ),

                                SizedBox(
                                  height: 21,
                                ),
                                //set SEMESTER END
                                Text(
                                  'End of Current Semester:',
                                  style: TextStyle(
                                    fontSize: 21,
                                    color: kMiddleColor,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      ayEndDateOnly,
                                    ),
                                    GFButton(
                                      onPressed: () async {
                                        final DateTime picked =
                                            await showDatePicker(
                                          context: context,
                                          initialDate: ayDateSnap.ayEnd
                                              .toDate(), // Refer step 1
                                          firstDate: DateTime(2021),
                                          lastDate: DateTime(3000),
                                        );
                                        if (picked != null &&
                                            picked !=
                                                ayDateSnap.ayEnd.toDate()) {
                                          context
                                              .read<AYDatesProvider>()
                                              .changePickedAYendDate = picked;
                                        }
                                        context
                                            .read<AYDatesProvider>()
                                            .setAYendSem();
                                        //create activity
                                        String myName = await context
                                            .read<LocalDataProvider>()
                                            .getLocalAdminName();
                                        context
                                                .read<AdminActivityProvider>()
                                                .changeActivityTitle =
                                            'Set End of Semester Date';
                                        context
                                            .read<AdminActivityProvider>()
                                            .changeName = myName;
                                        context
                                            .read<AdminActivityProvider>()
                                            .changeDate = DateTime.now();
                                        await context
                                            .read<AdminActivityProvider>()
                                            .addActivity();
                                      },
                                      size: GFSize.SMALL,
                                      text: 'Set Date',
                                    ),
                                    Container(),
                                  ],
                                ),

                                SizedBox(
                                  height: 21,
                                ),
                              ],
                            ),
                          ),
                        ),
                        if (!Responsive.isMobile(context))
                          const SizedBox(width: defaultPadding),
                        // On Mobile means if the screen is less than 850 we dont want to show it
                        if (!Responsive.isMobile(context))
                          Expanded(
                            flex: 2,
                            //display current acad year dates on the side
                            child: CurrentAcademicYearDates(
                              ayStartDate: ayStartDateOnly,
                              ayEndDate: ayEndDateOnly,
                              ayEnrollDate: ayEnrollDateOnly,
                              ayYearNow: ayDateSnap.currentYear.toString(),
                              ayYearNext: ayDateSnap.nextYear.toString(),
                            ),
                          ),
                      ],
                    );
                  } else {
                    return Container();
                  }
                }),
          ],
        ),
      ),
    );
  }
}
