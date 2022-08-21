import 'package:shared_preferences/shared_preferences.dart';

class SPGlobal {
  static final SPGlobal _instance = SPGlobal._();

  SPGlobal._();

  factory SPGlobal() {
    return _instance;
  }

  late SharedPreferences _prefs;

  Future initShared() async {
    _prefs = await SharedPreferences.getInstance();
  }

  set name(String value){
    _prefs.setString("name", value);
  }

  String get name => _prefs.getString('name') ?? "";

  set lastName(String value){
    _prefs.setString("lastName", value);
  }

  String get lastName => _prefs.getString('lastName') ?? "";

  set phone(String value){
    _prefs.setString("phone", value);
  }

  String get phone => _prefs.getString('phone') ?? "";


  set email(String value){
    _prefs.setString("email", value);
  }

  String get email => _prefs.getString('email') ?? "";


  set isLogin(bool value){
    _prefs.setBool("isLogin", value);
  }

  bool get isLogin => _prefs.getBool('isLogin') ?? false;



  set role(String value){
    _prefs.setString("role", value);
  }

  String get role => _prefs.getString('role') ?? "";



}