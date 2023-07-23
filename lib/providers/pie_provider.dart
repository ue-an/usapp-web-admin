// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';

// class PieProvider with ChangeNotifier {
//   final FirebaseFirestore _firebase = FirebaseFirestore.instance;
//   double _totalStudents = 0;
//   double _totalColleges = 0;
//   double _totalCourses = 0;
//   //
//   double _totalIT11 = 0;
//   double _totalIT12 = 0;
//   double _totalIT13 = 0;
//   double _totalIT14 = 0;
//   //
//   double _totalIT21 = 0;
//   double _totalIT22 = 0;
//   double _totalIT23 = 0;
//   double _totalIT24 = 0;
//   //
//   double _totalIT31 = 0;
//   double _totalIT32 = 0;
//   double _totalIT33 = 0;
//   double _totalIT34 = 0;
//   //
//   double _totalIT41 = 0;
//   double _totalIT42 = 0;
//   double _totalIT43 = 0;
//   double _totalIT44 = 0;
//   //
//   double _totalIS11 = 0;
//   double _totalIS12 = 0;
//   double _totalIS13 = 0;
//   double _totalIS14 = 0;
//   //
//   double _totalIS21 = 0;
//   double _totalIS22 = 0;
//   double _totalIS23 = 0;
//   double _totalIS24 = 0;
//   //
//   double _totalIS31 = 0;
//   double _totalIS32 = 0;
//   double _totalIS33 = 0;
//   double _totalIS34 = 0;
//   //
//   double _totalIS41 = 0;
//   double _totalIS42 = 0;
//   double _totalIS43 = 0;
//   double _totalIS44 = 0;
//   //
//   //==================
//   double _totalBsis = 0;
//   double _totalBsit = 0;
//   double _totalCcs;
//   //
//   double _totalBsoa;
//   double _totalCob;
//   //
//   double _totalBsa = 0;
//   double _totalCoa = 0;

//   //get
//   //=== Totals
//   double get totalStudents => _totalStudents;
//   // double get totalColleges => _totalColleges;
//   double get totalCcs => _totalCcs;
//   double get totalCob => _totalCob;
//   double get totalCoa => _totalCoa;

//   //=== Courses
//   double get totalBsit => _totalBsit;
//   double get totalBsis => _totalBsis;
//   double get totalBsoa => _totalBsoa;
//   double get totalBsa => _totalBsa;

//   //=== BSIT
//   //=== sections ===
//   //=== 1st year
//   double get totalIT11 => _totalIT11;
//   double get totalIT12 => _totalIT12;
//   double get totalIT13 => _totalIT13;
//   double get totalIT14 => _totalIT14;
//   //=== 2nd year
//   double get totalIT21 => _totalIT21;
//   double get totalIT22 => _totalIT22;
//   double get totalIT23 => _totalIT23;
//   double get totalIT24 => _totalIT24;
//   //=== 3rd year
//   double get totalIT31 => _totalIT31;
//   double get totalIT32 => _totalIT32;
//   double get totalIT33 => _totalIT33;
//   double get totalIT34 => _totalIT34;
//   //=== 4th year
//   double get totalIT41 => _totalIT41;
//   double get totalIT42 => _totalIT42;
//   double get totalIT43 => _totalIT43;
//   double get totalIT44 => _totalIT44;

//   //functions
//   getTotalStudents() async {
//     QuerySnapshot studentCollection =
//         await _firebase.collection('students').get();
//     _totalStudents = studentCollection.size.toDouble();
//     return _totalStudents;
//   }

//   getTotalCourses() async {
//     QuerySnapshot coursesCollection =
//         await _firebase.collection('courses').get();
//     _totalCourses = coursesCollection.size.toDouble();
//     return _totalCourses;
//   }

//   getTotalColleges() async {
//     QuerySnapshot collegesCollection =
//         await _firebase.collection('colleges').get();
//     _totalColleges = collegesCollection.size.toDouble();
//     return _totalColleges;
//   }
//   //=================================

//   getTotalBSOA() async {
//     QuerySnapshot bsoa = await _firebase
//         .collection('students')
//         .where('course', isEqualTo: 'BSOA')
//         .get();

//     _totalBsoa = bsoa.size.toDouble();
//     _totalCob = _totalBsoa;
//     // print(_totalBsoa);
//     return _totalBsoa;
//   }

//   getTotalBSIT() async {
//     QuerySnapshot bsit = await _firebase
//         .collection('students')
//         .where('course', isEqualTo: 'BSIT')
//         .get();

//     _totalBsit = bsit.size.toDouble();
//     return _totalBsit;
//   }

//   getTotalBSIS() async {
//     QuerySnapshot bsis = await _firebase
//         .collection('students')
//         .where('course', isEqualTo: 'BSIS')
//         .get();
//     _totalBsis = bsis.size.toDouble();
//     _totalCcs = _totalBsit + _totalBsis;
//     return _totalBsis;
//   }

//   getTotalBSA() async {
//     QuerySnapshot bsa = await _firebase
//         .collection('students')
//         .where('course', isEqualTo: 'BSA')
//         .get();
//     _totalBsa = bsa.size.toDouble();
//     _totalCoa = _totalBsa;
//     return _totalBsa;
//   }

//   //=========================================
//   getTotalIT11() async {
//     QuerySnapshot it11 = await _firebase
//         .collection('students')
//         .where('year_and_section', isEqualTo: 'IT 1-1')
//         .get();
//     _totalIT11 = it11.size.toDouble();
//     return _totalIT11;
//   }

//   getTotal12() async {
//     QuerySnapshot it12 = await _firebase
//         .collection('students')
//         .where('year_and_section', isEqualTo: 'IT 1-2')
//         .get();
//     _totalIT12 = it12.size.toDouble();
//     return _totalIT12;
//   }

//   getTotalIT13() async {
//     QuerySnapshot it13 = await _firebase
//         .collection('students')
//         .where('year_and_section', isEqualTo: 'IT 1-3')
//         .get();
//     _totalIT13 = it13.size.toDouble();
//     return _totalIT13;
//   }

//   getTotalIT14() async {
//     QuerySnapshot it14 = await _firebase
//         .collection('students')
//         .where('year_and_section', isEqualTo: 'IT 1-4')
//         .get();
//     _totalIT14 = it14.size.toDouble();
//     return _totalIT14;
//   }

//   //Courses
//   //CCS
//   // Future<QuerySnapshot> fetchBSIT() async {
//   //   QuerySnapshot bsit = await _firebaseCCS
//   //       .collection('students')
//   //       .where('course', isEqualTo: 'BSIT')
//   //       .get();
//   //   _totalBsit = bsit.docs.length.toDouble();
//   //   return bsit;
//   // }

//   // Future<QuerySnapshot> fetchBSIS() async {
//   //   QuerySnapshot bsis = await _firebaseCCS
//   //       .collection('students')
//   //       .where('course', isEqualTo: 'BSIS')
//   //       .get();

//   //   _totalBsis = bsis.docs.length.toDouble();
//   //   _totalCcs = _totalBsis + _totalBsit;
//   //   print('eyy' + _totalCcs.toString());
//   //   return bsis;
//   // }

//   // //COB
//   // Future<QuerySnapshot> fetchBSOA() async {
//   //   QuerySnapshot bsoa = await _firebaseCCS
//   //       .collection('students')
//   //       .where('course', isEqualTo: 'BSOA')
//   //       .get();

//   //   _totalBsoa = bsoa.docs.length.toDouble();
//   //   _totalCob = _totalBsoa;
//   //   return bsoa;
//   // }

//   // //COA
//   // Future<QuerySnapshot> fetchBSA() async {
//   //   QuerySnapshot bsa = await _firebaseCCS
//   //       .collection('students')
//   //       .where('course', isEqualTo: 'BSA')
//   //       .get();

//   //   _totalBsa = bsa.docs.length.toDouble();
//   //   _totalCoa = _totalBsa;
//   //   return bsa;
//   // }

//   // //Sections
//   // //=== BSIT
//   // //=== 1st year
//   // Future<QuerySnapshot> fetchIT11() async {
//   //   QuerySnapshot it11 = await _firebaseCCS
//   //       .collection('students')
//   //       .where('year_and_section', isEqualTo: 'IT 1-1')
//   //       .get();

//   //   _totalIT11 = it11.docs.length.toDouble();
//   //   return it11;
//   // }

//   // Future<QuerySnapshot> fetchIT12() async {
//   //   QuerySnapshot it12 = await _firebaseCCS
//   //       .collection('students')
//   //       .where('year_and_section', isEqualTo: 'IT 1-2')
//   //       .get();
//   //   _totalIT12 = it12.docs.length.toDouble();
//   //   return it12;
//   // }

//   // Future<QuerySnapshot> fetchIT13() async {
//   //   QuerySnapshot it13 = await _firebaseCCS
//   //       .collection('students')
//   //       .where('year_and_section', isEqualTo: 'IT 1-3')
//   //       .get();
//   //   _totalIT13 = it13.docs.length.toDouble();
//   //   return it13;
//   // }

//   // Future<QuerySnapshot> fetchIT14() async {
//   //   QuerySnapshot it14 = await _firebaseCCS
//   //       .collection('studednts')
//   //       .where('year_and_section', isEqualTo: 'IT 1-4')
//   //       .get();
//   //   _totalIT14 = it14.docs.length.toDouble();
//   //   return it14;
//   // }

//   // //=== 2nd year
//   // Future<QuerySnapshot> fetchIT21() async {
//   //   QuerySnapshot it21 = await _firebaseCCS
//   //       .collection('students')
//   //       .where('year_and_section', isEqualTo: 'IT 2-1')
//   //       .get();
//   //   _totalIT21 = it21.docs.length.toDouble();
//   //   return it21;
//   // }

//   // Future<QuerySnapshot> fetchIT22() async {
//   //   QuerySnapshot it22 = await _firebaseCCS
//   //       .collection('students')
//   //       .where('year_and_section', isEqualTo: 'IT 2-2')
//   //       .get();
//   //   _totalIT22 = it22.docs.length.toDouble();
//   //   return it22;
//   // }

//   // Future<QuerySnapshot> fetchIT23() async {
//   //   QuerySnapshot it23 = await _firebaseCCS
//   //       .collection('students')
//   //       .where('year_and_section', isEqualTo: 'IT 2-3')
//   //       .get();
//   //   _totalIT23 = it23.docs.length.toDouble();
//   //   return it23;
//   // }

//   // Future<QuerySnapshot> fetchIT24() async {
//   //   QuerySnapshot it24 = await _firebaseCCS
//   //       .collection('students')
//   //       .where('year_and_section', isEqualTo: 'IT 2-4')
//   //       .get();
//   //   _totalIT24 = it24.docs.length.toDouble();
//   //   return it24;
//   // }

//   // //=== 3rd year
//   // Future<QuerySnapshot> fetchIT31() async {
//   //   QuerySnapshot it31 = await _firebaseCCS
//   //       .collection('students')
//   //       .where('year_and_section', isEqualTo: 'IT 3-1')
//   //       .get();
//   //   _totalIT31 = it31.docs.length.toDouble();
//   //   return it31;
//   // }

//   // Future<QuerySnapshot> fetchIT32() async {
//   //   QuerySnapshot it32 = await _firebaseCCS
//   //       .collection('students')
//   //       .where('year_and_section', isEqualTo: 'IT 3-2')
//   //       .get();
//   //   _totalIT32 = it32.docs.length.toDouble();
//   //   return it32;
//   // }

//   // Future<QuerySnapshot> fetchIT33() async {
//   //   QuerySnapshot it33 = await _firebaseCCS
//   //       .collection('students')
//   //       .where('year_and_section', isEqualTo: 'IT 3-3')
//   //       .get();
//   //   _totalIT33 = it33.docs.length.toDouble();
//   //   return it33;
//   // }

//   // Future<QuerySnapshot> fetchIT34() async {
//   //   QuerySnapshot it34 = await _firebaseCCS
//   //       .collection('students')
//   //       .where('year_and_section', isEqualTo: 'IT 3-4')
//   //       .get();
//   //   _totalIT34 = it34.docs.length.toDouble();
//   //   return it34;
//   // }

//   // //=== 4th year
//   // Future<QuerySnapshot> fetchIT41() async {
//   //   QuerySnapshot it41 = await _firebaseCCS
//   //       .collection('students')
//   //       .where('year_and_section', isEqualTo: 'IT 4-1')
//   //       .get();
//   //   _totalIT41 = it41.docs.length.toDouble();
//   //   return it41;
//   // }

//   // Future<QuerySnapshot> fetchIT42() async {
//   //   QuerySnapshot it42 = await _firebaseCCS
//   //       .collection('students')
//   //       .where('year_and_section', isEqualTo: 'IT 4-2')
//   //       .get();
//   //   _totalIT42 = it42.docs.length.toDouble();
//   //   return it42;
//   // }

//   // Future<QuerySnapshot> fetchIT43() async {
//   //   QuerySnapshot it43 = await _firebaseCCS
//   //       .collection('students')
//   //       .where('year_and_section', isEqualTo: 'IT 4-3')
//   //       .get();
//   //   _totalIT43 = it43.docs.length.toDouble();
//   //   return it43;
//   // }

//   // Future<QuerySnapshot> fetchIT44() async {
//   //   QuerySnapshot it44 = await _firebaseCCS
//   //       .collection('students')
//   //       .where('year_and_section', isEqualTo: 'IT 4-4')
//   //       .get();
//   //   _totalIT44 = it44.docs.length.toDouble();
//   //   return it44;
//   // }

//   // //=== BSIS
//   // //=== 1st year
//   // Future<QuerySnapshot> fetchIS11() async {
//   //   QuerySnapshot is11 = await _firebaseCCS
//   //       .collection('students')
//   //       .where('year_and_section', isEqualTo: 'IS 1-1')
//   //       .get();

//   //   _totalIS11 = is11.docs.length.toDouble();
//   //   print('before this');
//   //   return is11;
//   // }

//   // Future<QuerySnapshot> fetchIS12() async {
//   //   QuerySnapshot is12 = await _firebaseCCS
//   //       .collection('students')
//   //       .where('year_and_section', isEqualTo: 'IS 1-2')
//   //       .get();
//   //   _totalIS12 = is12.docs.length.toDouble();
//   //   return is12;
//   // }

//   // Future<QuerySnapshot> fetchIS13() async {
//   //   QuerySnapshot is13 = await _firebaseCCS
//   //       .collection('students')
//   //       .where('year_and_section', isEqualTo: 'IS 1-3')
//   //       .get();
//   //   _totalIS13 = is13.docs.length.toDouble();
//   //   return is13;
//   // }

//   // Future<QuerySnapshot> fetchIS14() async {
//   //   QuerySnapshot is14 = await _firebaseCCS
//   //       .collection('studednts')
//   //       .where('year_and_section', isEqualTo: 'IS 1-4')
//   //       .get();
//   //   _totalIS14 = is14.docs.length.toDouble();
//   //   return is14;
//   // }

//   // //=== 2nd year
//   // Future<QuerySnapshot> fetchIS21() async {
//   //   QuerySnapshot is21 = await _firebaseCCS
//   //       .collection('students')
//   //       .where('year_and_section', isEqualTo: 'IS 2-1')
//   //       .get();
//   //   _totalIS21 = is21.docs.length.toDouble();
//   //   return is21;
//   // }

//   // Future<QuerySnapshot> fetchIS22() async {
//   //   QuerySnapshot is22 = await _firebaseCCS
//   //       .collection('students')
//   //       .where('year_and_section', isEqualTo: 'IS 2-2')
//   //       .get();
//   //   _totalIS22 = is22.docs.length.toDouble();
//   //   return is22;
//   // }

//   // Future<QuerySnapshot> fetchIS23() async {
//   //   QuerySnapshot is23 = await _firebaseCCS
//   //       .collection('students')
//   //       .where('year_and_section', isEqualTo: 'IS 2-3')
//   //       .get();
//   //   _totalIS23 = is23.docs.length.toDouble();
//   //   return is23;
//   // }

//   // Future<QuerySnapshot> fetchIS24() async {
//   //   QuerySnapshot is24 = await _firebaseCCS
//   //       .collection('students')
//   //       .where('year_and_section', isEqualTo: 'IS 2-4')
//   //       .get();
//   //   _totalIS24 = is24.docs.length.toDouble();
//   //   return is24;
//   // }

//   // //=== 3rd year
//   // Future<QuerySnapshot> fetchIS31() async {
//   //   QuerySnapshot is31 = await _firebaseCCS
//   //       .collection('students')
//   //       .where('year_and_section', isEqualTo: 'IS 3-1')
//   //       .get();
//   //   _totalIS31 = is31.docs.length.toDouble();
//   //   return is31;
//   // }

//   // Future<QuerySnapshot> fetchIS32() async {
//   //   QuerySnapshot is32 = await _firebaseCCS
//   //       .collection('students')
//   //       .where('year_and_section', isEqualTo: 'IS 3-2')
//   //       .get();
//   //   _totalIS32 = is32.docs.length.toDouble();
//   //   return is32;
//   // }

//   // Future<QuerySnapshot> fetchIS33() async {
//   //   QuerySnapshot is33 = await _firebaseCCS
//   //       .collection('students')
//   //       .where('year_and_section', isEqualTo: 'IS 3-3')
//   //       .get();
//   //   _totalIS33 = is33.docs.length.toDouble();
//   //   return is33;
//   // }

//   // Future<QuerySnapshot> fetchIS34() async {
//   //   QuerySnapshot is34 = await _firebaseCCS
//   //       .collection('students')
//   //       .where('year_and_section', isEqualTo: 'IS 3-4')
//   //       .get();
//   //   _totalIS34 = is34.docs.length.toDouble();
//   //   return is34;
//   // }

//   // //=== 4th year
//   // Future<QuerySnapshot> fetchIS41() async {
//   //   QuerySnapshot is41 = await _firebaseCCS
//   //       .collection('students')
//   //       .where('year_and_section', isEqualTo: 'IS 4-1')
//   //       .get();
//   //   _totalIS41 = is41.docs.length.toDouble();
//   //   return is41;
//   // }

//   // Future<QuerySnapshot> fetchIS42() async {
//   //   QuerySnapshot is42 = await _firebaseCCS
//   //       .collection('students')
//   //       .where('year_and_section', isEqualTo: 'IS 4-2')
//   //       .get();
//   //   _totalIS42 = is42.docs.length.toDouble();
//   //   return is42;
//   // }

//   // Future<QuerySnapshot> fetchIS43() async {
//   //   QuerySnapshot is43 = await _firebaseCCS
//   //       .collection('students')
//   //       .where('year_and_section', isEqualTo: 'IS 4-3')
//   //       .get();
//   //   _totalIS43 = is43.docs.length.toDouble();
//   //   return is43;
//   // }

//   // Future<QuerySnapshot> fetchIS44() async {
//   //   QuerySnapshot is44 = await _firebaseCCS
//   //       .collection('students')
//   //       .where('year_and_section', isEqualTo: 'IS 4-4')
//   //       .get();
//   //   _totalIS44 = is44.docs.length.toDouble();
//   //   return is44;
//   // }
// }
