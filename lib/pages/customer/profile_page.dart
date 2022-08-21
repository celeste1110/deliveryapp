import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deliveryapp/ui/general/colors.dart';
import 'package:flutter_deliveryapp/ui/widgets/general_widget.dart';
import 'package:flutter_deliveryapp/ui/widgets/text_widget.dart';

import '../../helpers/sp_global.dart';
import '../../services/order_service.dart';
import '../../services/order_stream_service.dart';
import '../login_page.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final SPGlobal _prefs = SPGlobal();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image:
                      // AssetImage(
                      //   'assets/images/fondo_perfil.jpg',
                      // ),
                      NetworkImage(
                    'https://images.pexels.com/photos/4253056/pexels-photo-4253056.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundImage: NetworkImage(
                            'https://images.pexels.com/photos/762020/pexels-photo-762020.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                          ),
                        ),
                        divider6(),
                        TextGeneral(
                          text: '${_prefs.name} ${_prefs.lastName}',
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 5,
                    right: 0,
                    child: IconButton(
                      onPressed: () {
                        _prefs.name = "";
                        _prefs.lastName="";
                        _prefs.phone="";
                        _prefs.email = "";
                        _prefs.role = "";
                        _prefs.isLogin = false;
                        OrderService().eliminar();

                        setState((){});

                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ),
                                (route) => false);
                      },
                      icon: Icon(
                        Icons.logout,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            divider20(),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.person,
                        size: 28,
                      ),
                      dividerWidth10,
                      TextGeneral(
                        text: _prefs.name + ' ' + _prefs.lastName,
                        fontSize: 15,
                        color: kBrandPrimaryColor,
                      ),
                    ],
                  ),
                  divider12(),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.email,
                        size: 28,
                      ),
                      dividerWidth10,
                      TextGeneral(
                        text: _prefs.email,
                        fontSize: 15,
                        color: kBrandPrimaryColor,
                      ),
                    ],
                  ),
                  divider12(),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.phone,
                        size: 28,
                      ),
                      dividerWidth10,
                      TextGeneral(
                        text: _prefs.phone,
                        fontSize: 15,
                        color: kBrandPrimaryColor,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
