import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deliveryapp/pages/register_page.dart';
import 'package:flutter_deliveryapp/ui/widgets/textfield_paddword_widget.dart';
import 'package:flutter_deliveryapp/ui/widgets/textfield_widget.dart';
import 'package:google_fonts/google_fonts.dart';

import '../helpers/sp_global.dart';
import '../services/firestore_servoce.dart';
import '../ui/general/colors.dart';
import '../ui/widgets/button_normal_widget.dart';
import '../ui/widgets/general_widget.dart';
import '../ui/widgets/text_widget.dart';
import 'admin/home_admin_page.dart';
import 'customer/init_page.dart';

class LoginPage extends StatefulWidget {


  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirestoreService _userReference = FirestoreService(collection: "users");
  final SPGlobal _prefs = SPGlobal();


  void _login() async {
    try {
      UserCredential userCredential =
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      if (userCredential.user != null) {
        _userReference.getUser(_emailController.text).then((value) {
          if (value != null) {
            if (value.role == "customer" && value.status) {
              _prefs.name = value.name;
              _prefs.lastName=value.lastname;
              _prefs.phone=value.phone;
              _prefs.email = value.email;
              _prefs.isLogin = true;
              _prefs.role = value.role;
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => InitPage(),
                  ),
                      (route) => false);
            } else if (value.role == "admin" && value.status) {
              _prefs.name = value.name;
              _prefs.lastName=value.lastname;
              _prefs.phone=value.phone;
              _prefs.email = value.email;
              _prefs.isLogin = true;
              _prefs.role = value.role;
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeAdminPage(),
                  ),
                      (route) => false);
            }
          }
        });
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        showSnackBar(context, "El correo electrónico es incorrecto");
      } else if (e.code == 'user-not-found') {
        showSnackBar(context, "El usuario no existe");
      } else if (e.code == 'wrong-password') {
        showSnackBar(context, "La contraseña es incorrecta");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                   key: _formKey,
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      divider6(),

                      Center(
                        child: Image.asset(
                          'assets/images/delivery.gif',
                          height: 310,
                        ),
                      ),

                      // SvgPicture.asset(
                      //
                      //   'assets/images/delivery.svg',
                      //   height: 120,
                      // ),
                      TextGeneral(
                        text: 'Bienvenido',
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),

                      //  Text(
                      //   "Bienvenido",
                      //   style: GoogleFonts.inter(
                      //     fontSize: 34,
                      //     fontWeight: FontWeight.bold
                      //   ),
                      //   // style: TextStyle(
                      //   //   color: Colors.black,
                      //   //   fontSize: 32.0,
                      //   //   fontWeight: FontWeight.w900,
                      //   // ),
                      // ),
                      divider12(),

                      TextGeneral(
                        text: 'Por favor, ingresa tus credenciales',
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.black54,
                      ),

                      // Text(
                      //   "Por favor, ingresa tus credenciales",
                      //   style: GoogleFonts.inter(
                      //     fontSize: 14,
                      //     fontWeight: FontWeight.w400,
                      //     color: Colors.black54,
                      //   ),
                      //   // style: TextStyle(
                      //   //   color: Colors.black54,
                      //   //   fontSize: 14,
                      //   //   fontWeight: FontWeight.w500
                      //   // ),
                      // ),
                      divider12(),
                      TextFielWidget(
                        hintText: "Email",
                        controller: _emailController,
                      ),
                      TextFieldPasswordWidget(
                        controller: _passwordController,
                        text: "Contraseña",
                      ),

                      divider20(),
                      ButtonNormalWidget(
                        title: "Iniciar Sesión",
                        onPressed: () {
                           _login();
                        },
                      ),
                      divider20(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "¿Aún no estás registrado?  ",
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w400,
                              color: Colors.black26,
                            ),
                          ),
                          dividerWidth6,
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RegisterPage(),
                                ),
                              );
                            },
                            child: Text(
                              "Regístrate",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: kBrandSecondaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),

                      // RichText(
                      //   text: const TextSpan(
                      //     text: "¿Aún no estás registrado?  ",
                      //     style: TextStyle(
                      //       fontSize: 14.0,
                      //       fontWeight: FontWeight.w400,
                      //       color: Colors.black26,
                      //     ),
                      //     children: [
                      //       TextSpan(
                      //         text: " Regístrate",
                      //         style: TextStyle(
                      //           fontSize: 15.0,
                      //           fontWeight: FontWeight.w600,
                      //           color: kBrandSecondaryColor,
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // isLoading
          //     ? Container(
          //   color: kBrandPrimaryColor.withOpacity(0.85),
          //   child: const Center(
          //     child: SizedBox(
          //       width: 20,
          //       height: 20,
          //       child: CircularProgressIndicator(
          //         color: kBrandSecondaryColor,
          //         strokeWidth: 2.3,
          //       ),
          //     ),
          //   ),
          // )
          //     : const SizedBox(),
        ],
      ),
    );
  }
}
