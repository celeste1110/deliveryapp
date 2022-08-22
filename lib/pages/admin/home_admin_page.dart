import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deliveryapp/pages/admin/product_page.dart';
import 'package:flutter_svg/svg.dart';

import '../../ui/general/colors.dart';
import '../customer/profile_page.dart';
import 'category_admin_page.dart';
import 'order_admin_page.dart';

class HomeAdminPage extends StatefulWidget {
  @override
  State<HomeAdminPage> createState() => _HomeAdminPageState();
}

class _HomeAdminPageState extends State<HomeAdminPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
     OrderAdminPage(),
    CategoryAdminPage(),
    ProductAdminPage(),

    ProfilePage(),
  ];

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

            label: "Orders",

            icon: SvgPicture.asset(
              'assets/icons/list.svg',
              height: 25,

              color: _currentIndex == 0
                  ? kBrandSecondaryColor
                  : kBrandPrimaryColor.withOpacity(0.3),
            ),


          ),
          BottomNavigationBarItem(

            label: "Categories",

            icon: SvgPicture.asset(
              'assets/icons/category.svg',
              height: 25,

              color: _currentIndex == 1
                  ? kBrandSecondaryColor
                  : kBrandPrimaryColor.withOpacity(0.3),
            ),


          ),

          BottomNavigationBarItem(
            label: "Products",
            icon: SvgPicture.asset(
              'assets/icons/products.svg',
              height: 25,
              color: _currentIndex == 2
                  ? kBrandSecondaryColor
                  : kBrandPrimaryColor.withOpacity(0.3),
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
