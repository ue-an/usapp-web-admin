import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:web_tut/2.0/constants.dart';
import 'package:web_tut/models/academic_year_dates.dart';

class CurrentAcademicYearDates extends StatefulWidget {
  String ayStartDate;
  String ayEndDate;
  String ayEnrollDate;
  String ayYearNow;
  String ayYearNext;
  CurrentAcademicYearDates({
    Key key,
    this.ayStartDate,
    this.ayEndDate,
    this.ayEnrollDate,
    this.ayYearNow,
    this.ayYearNext,
  }) : super(key: key);

  @override
  State<CurrentAcademicYearDates> createState() =>
      _CurrentAcademicYearDatesState();
}

class _CurrentAcademicYearDatesState extends State<CurrentAcademicYearDates>
    with AutomaticKeepAliveClientMixin<CurrentAcademicYearDates> {
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
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      decoration: const BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        children: [
          Image.asset(
            "assets/images/urs_logo-2.png",
            height: size.height / 3,
            width: size.width / 3,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Academic Year',
                style: TextStyle(
                  fontSize: 21,
                ),
              ),
              Text(
                widget.ayYearNow + '-' + widget.ayYearNext,
              ),
              SizedBox(
                height: 9,
              ),
              Text(
                'Enrollment Date',
                style: TextStyle(
                  fontSize: 21,
                ),
              ),
              Text(
                widget.ayEnrollDate,
              ),
              SizedBox(
                height: 9,
              ),
              Text(
                'Start of Semester',
                style: TextStyle(
                  fontSize: 21,
                ),
              ),
              Text(
                widget.ayStartDate,
              ),
              SizedBox(
                height: 9,
              ),
              Text(
                'End of Semester',
                style: TextStyle(
                  fontSize: 21,
                ),
              ),
              Text(
                widget.ayEndDate,
              ),
              SizedBox(
                height: size.height / 12,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
