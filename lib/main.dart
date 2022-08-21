import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deliveryapp/pages/customer/init_page.dart';
import 'package:flutter_deliveryapp/pages/login_page.dart';
import 'package:google_fonts/google_fonts.dart';

import 'helpers/sp_global.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SPGlobal _prefs = SPGlobal();
  await _prefs.initShared();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        //textTheme: GoogleFonts.manropeTextTheme(),
        textTheme: GoogleFonts.interTextTheme()
      ),
       home: PreInit(),
      // home: ProductDetailPage(),
     // home: HomeAdminPage(),
     // home: LoginPage(),
    );
  }
}

class PreInit extends StatelessWidget {

  final SPGlobal _prefs = SPGlobal();

  @override
  Widget build(BuildContext context) {
    return _prefs.isLogin ? InitPage() : LoginPage();
  }
}
