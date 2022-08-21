
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deliveryapp/pages/customer/profile_page.dart';
import 'package:flutter_svg/svg.dart';

import '../../services/order_stream_service.dart';
import '../../ui/general/colors.dart';
import 'home_customer_page.dart';
import 'menu_page.dart';
import 'order_page.dart';

class InitPage extends StatefulWidget {


  @override
  State<InitPage> createState() => _InitPageState();
}

class _InitPageState extends State<InitPage> {
  int _currentIndex = 0;


  final List<Widget> _pages = [
    const HomeCustomerPage(),
     MenuPage(),
     OrderPage(),

    ProfilePage(),
  ];

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    OrderStreamService().closeStream();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: TextStyle(
          fontSize: 12.0,
          height: 1.7
        ),
        selectedFontSize: 12.0,
        unselectedFontSize: 12.0,
        unselectedItemColor: kBrandPrimaryColor.withOpacity(0.4),
        selectedItemColor: kBrandSecondaryColor,
        onTap: (int value) {
          _currentIndex = value;
          setState(() {});
        },
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(

            label: "Home",

            icon: SvgPicture.asset(
              'assets/icons/home.svg',
              height: 25,

              color: _currentIndex == 0
                  ? kBrandSecondaryColor
                  : kBrandPrimaryColor.withOpacity(0.3),
            ),


          ),
          BottomNavigationBarItem(
            label: "Menu",
            icon: SvgPicture.asset(
              'assets/icons/list.svg',
              height: 25,
              color: _currentIndex == 1
                  ? kBrandSecondaryColor
                  : kBrandPrimaryColor.withOpacity(0.3),
            ),
          ),
          BottomNavigationBarItem(
            label: "Cart",
            icon: Stack(
              clipBehavior: Clip.none,
              children: [
                SvgPicture.asset(
                  'assets/icons/cart.svg',
                  height: 25,
                  color: _currentIndex == 2
                      ? kBrandSecondaryColor
                      : kBrandPrimaryColor.withOpacity(0.3),
                ),
                Positioned(
                  right: -3,
                  top: -3,
                  child: StreamBuilder(
                    stream: OrderStreamService().counterStream,
                    builder: (BuildContext context, AsyncSnapshot snap) {
                      if (snap.hasData) {
                        int counter = snap.data;

                        return counter > 0 ? Container(
                          padding: const EdgeInsets.all(4.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: kBrandSecondaryColor,
                          ),
                          child: Text(
                            counter.toString(),
                            style: const TextStyle(
                              fontSize: 11.0,
                            ),
                          ),
                        ): const SizedBox();
                      }
                      return const SizedBox();
                    },
                  ),
                ),
              ],
            ),
          ),

          BottomNavigationBarItem(
            label: "Profile",
            icon: SvgPicture.asset(
              'assets/icons/person.svg',
              height: 25,
              color: _currentIndex == 3
                  ? kBrandSecondaryColor
                  : kBrandPrimaryColor.withOpacity(0.3),
            ),
          ),
        ],
      ),

    );
  }
}
