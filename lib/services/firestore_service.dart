import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_tut/models/academic_year_dates.dart';
import 'package:web_tut/models/admin.dart';
import 'package:web_tut/models/admin_activity.dart';
import 'package:web_tut/models/college.dart';
import 'package:web_tut/models/course.dart';
import 'package:web_tut/models/report.dart';
import 'package:web_tut/models/request.dart';
import 'package:web_tut/models/student.dart';
import 'package:web_tut/models/thread.dart';
import 'package:web_tut/models/thread_messages.dart';
import 'package:web_tut/models/thread_reply.dart';
import 'package:web_tut/models/user_account.dart';
import 'package:web_tut/models/user_activity.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  String uid;
  String userEmail;

  //Students
  //get
  Stream<List<Student>> getStudents() {
    return _db
        .collection('students')
        // .where('is_used', isEqualTo: true)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Student.fromJson(doc.data())).toList());
  }

  updateStudentDetails({
    String updstudentnumber,
    String updfirstname,
    String updminitial,
    String updlastname,
    String updcollege,
    String updcourse,
    int updyearlvl,
    int updsection,
  }) async {
    try {
      await _db.collection('students').doc(updstudentnumber).update({
        'first_name': updfirstname,
        'middle_initial': updminitial,
        'last_name': updlastname,
        'college': updcollege,
        'course': updcourse,
        'year_level': updyearlvl,
        'section': updsection,
      });
    } on FirebaseException catch (e) {
      print('Error from updateStudentDetails' + e.message);
      return false;
    }
  }

  //get (future)
  Future<List<Student>> waitStudents() async {
    // var stream = _db.collection('students').snapshots().map((snapshot) =>
    //     snapshot.docs.map((doc) => Student.fromJson(doc.data())).toList());
    var n = getStudents();
    return await getStudents().first;
  }

  //upsert
  Future<void> setStudent(Student student) async {
    var options = SetOptions(merge: true);
    return await _db
        .collection('students')
        .doc(student.studentNumber)
        .set(student.toMap(), options);
  }

  //delete
  Future<void> removeStudent(String studentID) async {
    return await _db.collection('students').doc(studentID).delete();
  }

  //search
  Stream<List<Student>> searchStudents(String searchText) {
    return _db
        .collection('students')
        .where('last_name', isEqualTo: searchText)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Student.fromJson(doc.data())).toList());
  }

  //Colleges
  //get
  Stream<List<College>> getColleges() {
    return _db.collection('colleges').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => College.fromJson(doc.data())).toList());
  }

  //get (future)
  Future<List<College>> waitColleges() async {
    return await getColleges().first;
  }

  //upsert
  Future<void> setCollege(College college) async {
    var options = SetOptions(merge: true);

    return await _db
        .collection('colleges')
        .doc(college.collegeName)
        .set(college.toMap(), options);
  }

  //update
  updateCollegeCourses(String collegeID, String course) async {
    try {
      await _db.collection('colleges').doc(collegeID).update({
        'courses': FieldValue.arrayUnion([course]),
      });
      return true;
    } on FirebaseException catch (e) {
      print(e.message);
      return false;
    }
  }

  removeCourseInCollege(String collegeID, String course) async {
    try {
      await _db.collection('colleges').doc(collegeID).update({
        'courses': FieldValue.arrayRemove([course]),
      });
      return true;
    } on FirebaseException catch (e) {
      print(e.message);
      return false;
    }
  }

  //delete
  Future<void> removeCollege(String collegeID) {
    return _db.collection('colleges').doc(collegeID).delete();
  }

  //Courses
  //get
  Stream<List<Course>> getCourses() {
    return _db.collection('courses').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => Course.fromJson(doc.data())).toList());
  }

  //get (future)
  Future<List<Course>> waitCourses() async {
    return await getCourses().first;
  }

  //upsert
  Future<void> setCourse(Course course) async {
    var options = SetOptions(merge: true);

    return await _db
        .collection('courses')
        .doc(course.courseId)
        .set(course.toMap(), options);
  }

  //update
  updateCourse(String courseID, int years, int sections) async {
    try {
      await _db.collection('courses').doc(courseID).update({
        'years': years,
        'sections': sections,
      });
      return true;
    } on FirebaseException catch (e) {
      print(e.message);
      return false;
    }
  }

  //delete
  Future<void> removeCourse(String courseID) {
    return _db.collection('courses').doc(courseID).delete();
  }

  //auth && admin

  //signin admin
  logIn({String email, String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString('userstatus', email);
      return true;
    } on FirebaseAuthException catch (e) {
      print(e.message.toString());
      if (e.code == 'invalid-email') {
        print('invalid email');
        return false;
      } else if (e.code == 'user-disabled') {
        print('user-disabled');
        return false;
      } else if (e.code == 'user-not-found') {
        print('user-not-found');
        return false;
      } else if (e.code == 'wrong-password') {
        print('wrong password');
        return false;
      } else {
        print('object');
        return false;
      }
    }
  }

  signOut() async {
    await _firebaseAuth.signOut();
  }

  //create account/register
  Future<User> registerWithEmailPassword(
      {String email, String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      print('registered');
    } on FirebaseAuthException catch (e) {
      print(e.message.toString());
    }
    return null;
  }

  //create document to administrators collection
  setAdminAccount(Admin admin) async {
    var options = SetOptions(merge: true);
    try {
      await _db
          .collection('administrators')
          .doc(admin.email)
          .set(admin.toMap(), options);
    } on FirebaseAuthException catch (e) {
      return false;
    }
  }

  //get all administrators
  Stream<List<Admin>> getAllAdmins() {
    return _db.collection('administrators').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => Admin.fromJson(doc.data())).toList());
  }

  //get admin
  Stream<List<Admin>> getAdmins() {
    return _db
        .collection('administrators')
        .where('admin_email', isEqualTo: _firebaseAuth.currentUser.email)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Admin.fromJson(doc.data())).toList());
  }

  //get admin list
  Stream<List<Admin>> getAdminsList() {
    return _db
        .collection('administrators')
        .where('usertype', isEqualTo: 'admin')
        .where('is_enabled', isEqualTo: true)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Admin.fromJson(doc.data())).toList());
  }

  //get disabled admin list
  Stream<List<Admin>> getAdminsListDisabled() {
    return _db
        .collection('administrators')
        .where('usertype', isEqualTo: 'admin')
        .where('is_enabled', isEqualTo: false)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Admin.fromJson(doc.data())).toList());
  }

  //enable admin
  enableAdmin(String email) async {
    try {
      await _db.collection('administrators').doc(email).update({
        'is_enabled': true,
      });
      return true;
    } on FirebaseAuthException catch (e) {
      return false;
    }
  }

  //disable admin
  disableAdmin(String email) async {
    try {
      await _db.collection('administrators').doc(email).update({
        'is_enabled': false,
      });
      return true;
    } on FirebaseAuthException catch (e) {
      return false;
    }
  }

  //verify admin if is_enable == true
  getAdminEnable(String email) async {
    final snap = await _db
        .collection('administrators')
        .where('admin_email', isEqualTo: email)
        .where('is_enabled', isEqualTo: true)
        .get();
    if (snap.docs.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  //verify email in admins collection
  verifyAdminEmail(String email) async {
    final snapshot = await _db.collection('administrators').doc(email).get();
    if (snapshot.exists) {
      return true;
    } else {
      return false;
    }
  }
  //
  // final snapshot = await _db
  //       .collection('admins')
  //       .where('admin_email', isEqualTo: email)
  //       .snapshots()
  //       .map((snapshot) =>
  //           snapshot.docs.map((doc) => Admin.fromJson(doc.data())).toList());

  //get admin (future)
  Future<List<Admin>> waitAdmin() async {
    return await getAdmins().first;
  }

  //students account users
  Stream<List<Student>> getUsers() {
    return _db
        .collection('students')
        .where('is_used', isEqualTo: true)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Student.fromJson(doc.data())).toList());
  }

  //enabled students account users
  Stream<List<Student>> getAccounts() {
    return _db.collection('students').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => Student.fromJson(doc.data())).toList());
  }

  //enable user account (mobile)
  enableUserAccount(String studentNumber) async {
    try {
      await _db.collection('students').doc(studentNumber).update({
        'is_enabled': true,
      });
      return true;
    } on FirebaseAuthException catch (e) {
      return false;
    }
  }

  //disable user account (mobile)
  disableUserAccount(String studentNumber) async {
    try {
      await _db.collection('students').doc(studentNumber).update({
        'is_enabled': false,
      });
      return true;
    } on FirebaseAuthException catch (e) {
      return false;
    }
  }

  //get (future)
  Future<List<Student>> waitUsers() async {
    return await getUsers().first;
  }

  //THREADS
  //get
  Stream<List<Thread>> getThreads() {
    return _db
        .collection('threads')
        .where('is_deleted_by_owner', isEqualTo: false)
        .where('is_reported', isEqualTo: false)
        // .orderBy('create_date', descending: true)
        // .where('college', isEqualTo: thrCollege)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Thread.fromJson(doc.data())).toList());
  }

  Stream<List<Thread>> getReportedThreads() {
    return _db
        .collection('threads')
        .where('is_deleted_by_owner', isEqualTo: false)
        .where('is_reported', isEqualTo: true)
        // .orderBy('create_date', descending: true)
        // .where('college', isEqualTo: thrCollege)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Thread.fromJson(doc.data())).toList());
  }

  //get (future)
  Future<List<Thread>> waitThreads() async {
    return await getThreads().first;
  }

  //another get
  Future<List<ThreadMessage>> viewThreads(String thrID) async {
    // return
    QuerySnapshot querySnapshot = await _db
        .collection('threads')
        .doc(thrID)
        .collection('thread_messages')
        .get();
    // .get();
    final alldata = querySnapshot.docs
        .map((doc) => ThreadMessage.fromJson(doc.data()))
        .toList();
    return alldata;
  }

  Future<List<ThreadMessage>> viewThreadReplies(String thrID) async {
    // return
    QuerySnapshot querySnapshot = await _db
        .collection('threads')
        .doc(thrID)
        .collection('thread_replies')
        .get();
    // .get();
    final alldata = querySnapshot.docs
        .map((doc) => ThreadMessage.fromJson(doc.data()))
        .toList();
    return alldata;
  }

  //REPORTS
  //get
  Stream<List<Report>> getReports() {
    return _db
        .collection('reports')
        .where('report_count', isGreaterThanOrEqualTo: 3)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Report.fromJson(doc.data())).toList());
  }

  //update report approval
  updateReportApproval(String threadID) async {
    try {
      await _db.collection('reports').doc(threadID).update(
        {
          'is_approved': true,
        },
      );
      return true;
    } on FirebaseAuthException catch (e) {
      return false;
    }
  }

  //update report approval
  updateReportApproval2(String threadID) async {
    try {
      await _db.collection('reports').doc(threadID).update(
        {
          'is_approved': false,
        },
      );
      return true;
    } on FirebaseAuthException catch (e) {
      return false;
    }
  }

  //update thread is_reported
  updateThreadReportStatus(String threadID) async {
    try {
      await _db.collection('threads').doc(threadID).update(
        {
          'is_reported': true,
        },
      );
      return true;
    } on FirebaseAuthException catch (e) {
      return false;
    }
  }

  //unarchive reported forums
  updateThreadReportStatus2(String threadID) async {
    try {
      await _db.collection('threads').doc(threadID).update(
        {
          'is_reported': false,
        },
      );
      return true;
    } on FirebaseAuthException catch (e) {
      return false;
    }
  }

  //REQUESTS
  //get
  Stream<List<Request>> getRequests() {
    return _db
        .collection('requests')
        .where('is_accepted', isEqualTo: false)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Request.fromJson(doc.data())).toList());
  }

  //update thread is_reported
  updateRequestStatus(String email) async {
    try {
      await _db.collection('requests').doc(email).update(
        {
          'is_accepted': true,
          'is_sent': false,
        },
      );
      return true;
    } on FirebaseAuthException catch (e) {
      return false;
    }
  }

  //ACADEMIC YEAR DATES
  //get
  Stream<List<AcademicYearDates>> getAcademicYearDates() {
    return _db.collection('academic_year').snapshots().map((snapshot) =>
        snapshot.docs
            .map((doc) => AcademicYearDates.fromJson(doc.data()))
            .toList());
  }

  //update ay(start, end) dates
  updateAYstartSem(Timestamp newAYstart) async {
    try {
      await _db.collection('academic_year').doc('f8uwope9r6h397uATSAD').update(
        {
          'ay_start': newAYstart,
        },
      );
      return true;
    } on FirebaseAuthException catch (e) {
      return false;
    }
  }

  updateAYendSem(Timestamp newAYend) async {
    try {
      await _db.collection('academic_year').doc('f8uwope9r6h397uATSAD').update(
        {
          'ay_end': newAYend,
        },
      );
      return true;
    } on FirebaseAuthException catch (e) {
      return false;
    }
  }

  //update enroll dates
  updateEnrollDate(Timestamp enrollDate) async {
    try {
      await _db.collection('academic_year').doc('f8uwope9r6h397uATSAD').update(
        {
          'enrollment_date': enrollDate,
        },
      );
      return true;
    } on FirebaseAuthException catch (e) {
      return false;
    }
  }

  //update years
  updateAYstartYear(int current) async {
    try {
      await _db.collection('academic_year').doc('f8uwope9r6h397uATSAD').update(
        {
          'current_year': current,
        },
      );
      return true;
    } on FirebaseAuthException catch (e) {
      return false;
    }
  }

  updateAYendYear(int next) async {
    try {
      await _db.collection('academic_year').doc('f8uwope9r6h397uATSAD').update(
        {
          'next_year': next,
        },
      );
      return true;
    } on FirebaseAuthException catch (e) {
      return false;
    }
  }

  //ADD ADMIN ACTIVITY

  Future<void> setAdminActivity(AdminActivity adminActivity) async {
    var options = SetOptions(merge: false);
    return await _db
        .collection('admin_activities')
        .doc(adminActivity.id)
        .set(adminActivity.toMap(), options);
  }

  //get
  Stream<List<AdminActivity>> getAdminActivities() {
    return _db
        .collection('admin_activities')
        // .where('email', isEqualTo: _firebaseAuth.currentUser.email)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => AdminActivity.fromJson(doc.data()))
            .toList());
  }

  //get
  Stream<List<AdminActivity>> getAdminActivitiesByFilter(String email) {
    return _db
        .collection('admin_activities')
        .where('email', isEqualTo: email)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => AdminActivity.fromJson(doc.data()))
            .toList());
  }

  //get
  Stream<List<UserActivity>> getUserActivitiesByFilter(String email) {
    return _db
        .collection('activities')
        .where('activity_owner', isEqualTo: email)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => UserActivity.fromJson(doc.data()))
            .toList());
  }

  //get
  Stream<List<UserActivity>> getUserActivities() {
    return _db.collection('activities').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => UserActivity.fromJson(doc.data())).toList());
  }

  //REPLY
  Stream<List<ThreadReply>> getThreadReplyy(
      String threadID, String thrMessageID) {
    return _db
        .collection('threads')
        .doc(threadID)
        .collection('thread_replies')
        .where('comment_id', isEqualTo: thrMessageID)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => ThreadReply.fromJson(doc.data()))
            .toList());
  }

  //USER ACCOUNTS COLLECTION
  Stream<List<UserAccount>> getUserAccounts() {
    return _db.collection('accounts').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => UserAccount.fromJson(doc.data())).toList());
  }
}
