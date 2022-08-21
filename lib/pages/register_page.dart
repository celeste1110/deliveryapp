import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../helpers/sp_global.dart';
import '../models/user_model.dart';
import '../services/firestore_servoce.dart';
import '../ui/general/colors.dart';
import '../ui/widgets/button_normal_widget.dart';
import '../ui/widgets/general_widget.dart';
import '../ui/widgets/text_widget.dart';
import '../ui/widgets/textfield_paddword_widget.dart';
import '../ui/widgets/textfield_widget.dart';
import 'customer/init_page.dart';
import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _lastNameController = TextEditingController();

  final TextEditingController _phoneController = TextEditingController();

  final TextEditingController _passwordConfirmController =
      TextEditingController();

  final FirestoreService _userCollection =
  FirestoreService(collection: "users");


  final SPGlobal _prefs = SPGlobal();

  bool isLoading = false;

  void registerCustomer() async {
    if (_formKey.currentState!.validate()) {
      try {

        isLoading = true;
        setState((){});
        if(_passwordController.text!=_passwordConfirmController.text){
          showSnackBar(context, "Las contraseñas no coinciden");
          isLoading = false;
          setState((){});

        }else {
          UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: _emailController.text,
            password: _passwordController.text,
          );

          if (userCredential.user != null) {
            UserModel userModel = UserModel(
              name: _nameController.text,
              lastname: _lastNameController.text,
              phone: _phoneController.text,
              email: _emailController.text,
              role: "customer",
              status: true,
            );

            _userCollection.addUser(userModel).then((value) {
              if (value.isNotEmpty) {
                _prefs.name = userModel.name;
                _prefs.lastName = userModel.lastname;
                _prefs.phone = userModel.phone;
                _prefs.email = userModel.email;
                _prefs.isLogin = true;
                _prefs.role = userModel.role;
                isLoading = false;
                setState(() {});

                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => InitPage(),
                    ),
                        (route) => false);
              }
            });
          }
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == "email-already-in-use") {

          showSnackBar(context, "El correo electrónico ya está registrado");

        } else if (e.code == "weak-password") {

          showSnackBar(context, "La contraseña es débil, intenta con otra");

        }
        isLoading = false;
        setState((){});
      }
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding:const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  divider6(),

                  divider12(),

                  TextGeneral(
                    text: 'Create una cuenta y escoge tu menu favorito',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.black54,
                  ),


                  divider12(),
                  TextFielWidget(
                    hintText: "Email",
                    controller: _emailController,
                  ),
                  TextFielWidget(
                    hintText: "Nombres",
                    controller: _nameController,
                  ),
                  TextFielWidget(
                    hintText: "Apellidos",
                    controller: _lastNameController,
                  ),
                  TextFielWidget(
                    hintText: "Telefono",
                    controller: _phoneController,
                  ),
                  TextFieldPasswordWidget(
                    controller: _passwordController,
                    text: "Contraseña",
                  ),
                  TextFieldPasswordWidget(
                    controller: _passwordConfirmController,
                    text: "Confirmar contraseña",
                  ),

                  divider20(),
                  ButtonNormalWidget(
                    title: "Registrarse",
                    onPressed: () {
                      registerCustomer();
                      // _login();
                    },
                  ),
                  divider20(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "¿Tienes una cuenta?  ",
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
                              builder: (context) => LoginPage(),
                            ),
                          );
                        },
                        child: Text(
                          "Iniciar Sesión",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: kBrandSecondaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),


                ],
              ),
            ),

          ),
        ),
      ),
    );
  }
}
