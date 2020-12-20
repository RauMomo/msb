//import 'package:belajar_flutter/login_page.dart';
//import 'package:belajar_flutter/complete_profile.dart';
import 'package:belajar_flutter/bill_page.dart';
import 'package:belajar_flutter/create_transaction.dart';
import 'package:belajar_flutter/home.dart';
import 'package:belajar_flutter/product.dart';
//import 'package:belajar_flutter/forgot_password.dart';
import 'package:belajar_flutter/profile_page.dart';
//import 'package:belajar_flutter/request.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  int selectedItemIndex = 0;
  List<Widget> container = [
    new HomePage(),
    new ProductPage(),
    new CreateTransactionPage(),
    new BillPage(),
    new ProfilePage()
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: container[selectedItemIndex],
      bottomNavigationBar: new BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            setState(() {
              selectedItemIndex = index;
            });
          },
          currentIndex: selectedItemIndex,
          items: [
            BottomNavigationBarItem(
              activeIcon: new Icon(
                Icons.home,
                color: Colors.red,
              ),
              icon: new Icon(
                Icons.home,
                color: Colors.grey,
              ),
              title: new Text(
                "Home",
                style: TextStyle(
                    color: selectedItemIndex == 0 ? Colors.red : Colors.grey,
                    fontFamily: "Segoe UI"),
              ),
            ),
            BottomNavigationBarItem(
              activeIcon: new Icon(
                Icons.healing,
                color: Colors.red,
              ),
              icon: new Icon(
                Icons.healing,
                color: Colors.grey,
              ),
              title: new Text(
                "Product",
                style: TextStyle(
                    color: selectedItemIndex == 1 ? Colors.red : Colors.grey,
                    fontFamily: "Segoe UI"),
              ),
            ),
            BottomNavigationBarItem(
              activeIcon: new Icon(
                Icons.note,
                color: Colors.red,
              ),
              icon: new Icon(
                Icons.note,
                color: Colors.grey,
              ),
              title: new Text(
                "Request",
                style: TextStyle(
                    color: selectedItemIndex == 2 ? Colors.red : Colors.grey,
                    fontFamily: "Segoe UI"),
              ),
            ),
            BottomNavigationBarItem(
              activeIcon: new Icon(
                Icons.payment,
                color: Colors.red,
              ),
              icon: new Icon(
                Icons.payment,
                color: Colors.grey,
              ),
              title: new Text(
                "Bill",
                style: TextStyle(
                    color: selectedItemIndex == 3 ? Colors.red : Colors.grey,
                    fontFamily: "Segoe UI"),
              ),
            ),
            BottomNavigationBarItem(
              activeIcon: new Icon(
                Icons.person,
                color: Colors.red,
              ),
              icon: new Icon(
                Icons.person,
                color: Colors.grey,
              ),
              title: new Text(
                "Profile",
                style: TextStyle(
                    color: selectedItemIndex == 4 ? Colors.red : Colors.grey,
                    fontFamily: "Segoe UI"),
              ),
            ),
          ]),
    );
  }
}
