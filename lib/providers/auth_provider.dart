import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_tut/models/admin.dart';
import 'package:web_tut/services/firestore_service.dart';

class AuthProvider with ChangeNotifier {
  final firestoreService = FirestoreService();
  final auth = FirebaseAuth.instance;
  String _email = '';
  String _password = '';
  bool _isVerifiedAcct = false;
  // PrefService myPref = PrefService();
  bool _isVerifiedAdminEmail = false;
  bool _isEnabled = true;
  //change password
  String _oldPassword = '';
  String _newPassword = '';
  String _reNewPass = '';
  bool _isPasswordChanged = false;
  bool _isError = false;
  bool _oldPassCorrect = false;
  //reset password
  String _resetNewPassword = '';
  String _reResetNewPass = '';
  String _resetEmail = '';
  bool _isPasswordReset = false;

  Stream<User> get authStateChanges => FirebaseAuth.instance.authStateChanges();

  //get
  String get email => _email;
  String get password => _password;
  bool get isVerifiedAcct => _isVerifiedAcct;
  bool get isVerifiedAdminEmail => _isVerifiedAdminEmail;
  bool get isEnabled => _isEnabled;
  //change pass
  String get newPassword => _newPassword;
  String get reNewPass => _reNewPass;
  String get oldPassword => _oldPassword;
  bool get isPasswordChanged => _isPasswordChanged;
  bool get oldPassCorrect => _oldPassCorrect;
  //reset pass
  String get resetNewPass => _resetNewPassword;
  String get reResetNewPass => _reResetNewPass;
  String get resetEmail => _resetEmail;
  bool get isPasswordReset => _isPasswordReset;

  //set
  set email(String email) {
    _email = email;
    notifyListeners();
  }

  set password(String password) {
    _password = password;
    notifyListeners();
  }

  set oldPassword(String oldPassword) {
    _oldPassword = oldPassword;
    notifyListeners();
  }

  set oldPassCorrect(bool oldPassCorrect) {
    _oldPassCorrect = oldPassCorrect;
    notifyListeners();
  }

  set newPassword(String newPassword) {
    _newPassword = newPassword;
    notifyListeners();
  }

  set reNewPass(String reNewPass) {
    _reNewPass = reNewPass;
    notifyListeners();
  }

  set changeIsPassChanged(bool isPassChanged) {
    _isPasswordChanged = isPassChanged;
    notifyListeners();
  }

  set changeResetEmail(String resetEmail) {
    _resetEmail = resetEmail;
    notifyListeners();
  }

  set changeIsPassReset(bool isPassReset) {
    _isPasswordReset = isPassReset;
    notifyListeners();
  }

  //functions
  logInAdmin() async {
    if (_email != null && _password != null) {
      var res =
          await firestoreService.logIn(email: _email, password: _password);
      _isVerifiedAcct = res;
      print('not null');
      notifyListeners();
    } else {
      _isVerifiedAcct = false;
      notifyListeners();
    }
  }

  signOutAdmin() async {
    await firestoreService.signOut();
    _email = '';
    _password = '';
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove('userstatus');
    notifyListeners();
  }

  checkAdminsColl() async {
    if (_email != null) {
      var res = await firestoreService.verifyAdminEmail(_email);
      _isVerifiedAdminEmail = res;
      notifyListeners();
    } else {
      _isVerifiedAdminEmail = false;
      notifyListeners();
    }
  }

  checkAdminsEnabled() async {
    if (_email != null) {
      var res = await firestoreService.getAdminEnable(_email);
      _isEnabled = res;
      notifyListeners();
    } else {
      _isEnabled = false;
      notifyListeners();
    }
  }

  validateOldPassword() async {
    User user = auth.currentUser;
    String email = user.email;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: _oldPassword,
      );
      _oldPassCorrect = true;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      print('wrong wrong');
      notifyListeners();
    }
    notifyListeners();
  }

  changePassword() async {
    User user = auth.currentUser;
    String email = user.email;

    //Create field for user to input old password

    //pass the password here
    String password = _oldPassword;
    String newPassword = _newPassword;
    String reNewPass = _reNewPass;

    if (newPassword == reNewPass) {
      try {
        UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );

        user.updatePassword(newPassword).then((_) {
          print("Successfully changed password");
          _isPasswordChanged = true;
          changeIsPassChanged = true;
        }).catchError((error) {
          print("Password can't be changed" + error.toString());
          _isPasswordChanged = false;
          //This might happen, when the wrong password is in, the user isn't found, or if the user hasn't logged in recently.
        });
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          print('No user found for that email.');
          _isError = true;
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
          _isError = true;
        } else if (e.code == 'wrong-password') {
          //when account di faabkes
        }
      }
    }
  }

  resetPassword() async {
    if (_resetNewPassword == _reResetNewPass) {
      try {
        auth.sendPasswordResetEmail(email: _resetEmail);
        _isPasswordReset = true;
        changeIsPassReset = true;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          print('No user found for that email.');
          _isError = true;
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
          _isError = true;
        }
      }
    }
  }
}
