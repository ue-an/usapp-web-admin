import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalDataProvider with ChangeNotifier {
  //Admin Details
  storeLocalAdminName(String adminname) async {
    SharedPreferences adminDetailsPrefs = await SharedPreferences.getInstance();
    await adminDetailsPrefs.setString('localadmin-name', adminname);
    notifyListeners();
  }

  storeLocalAdminEmail(String adminemail) async {
    SharedPreferences adminDetailsPrefs = await SharedPreferences.getInstance();
    await adminDetailsPrefs.setString('localadmin-email', adminemail);
    notifyListeners();
  }

  storeLocalAdminUsertype(String adminusertype) async {
    SharedPreferences adminDetailsPrefs = await SharedPreferences.getInstance();
    await adminDetailsPrefs.setString('localadmin-usertype', adminusertype);
    notifyListeners();
  }

  //get
  Future<String> getLocalAdminName() async {
    SharedPreferences adminDetailsPrefs = await SharedPreferences.getInstance();
    await adminDetailsPrefs.reload();
    notifyListeners();
    return adminDetailsPrefs.getString('localadmin-name');
  }

  Future<String> getLocalAdminEmail() async {
    SharedPreferences adminDetailsPrefs = await SharedPreferences.getInstance();
    await adminDetailsPrefs.reload();
    notifyListeners();
    return adminDetailsPrefs.getString('localadmin-email');
  }

  Future<String> getLocalAdminUsertype() async {
    SharedPreferences adminDetailsPrefs = await SharedPreferences.getInstance();
    await adminDetailsPrefs.reload();
    notifyListeners();
    return adminDetailsPrefs.getString('localadmin-usertype');
  }
}
