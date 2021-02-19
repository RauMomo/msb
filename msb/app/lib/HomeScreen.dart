import 'package:flutter/material.dart';
import 'package:msb/BillScreen.dart';
import 'package:msb/CreateTransactionScreen.dart';
import 'package:msb/EditProfileScreen.dart';
import 'package:msb/ProductScreen.dart';
import 'package:msb/ProfileScreen.dart';
import 'package:msb/home.dart';

class HomeScreen extends StatefulWidget {
  @override
  const HomeScreen({Key key, @required this.index}) : super(key: key);
  final int index;
  _HomeScreen createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  int selectedItemIndex;
  List<Widget> container = [
    new HomePage(),
    new ProductScreen(),
    new CreateTransactionScreen(),
    new BillScreen(),
    new ProfileScreen()
  ];
  void initState() {
    if (widget.index == null) {
      selectedItemIndex = 0;
    } else {
      selectedItemIndex = widget.index;
    }
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0FFF3),
      body: DefaultTabController(
        initialIndex: selectedItemIndex,
        length: 5,
        child: Scaffold(
          key: scaffoldKey,
          body: container[selectedItemIndex],
          bottomNavigationBar: TabBar(
            onTap: (index) {
              setState(() {
                selectedItemIndex = index;
              });
            },
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            labelStyle: TextStyle(fontSize: 10),
            tabs: [
              Tab(
                icon: Icon(
                  Icons.home_outlined,
                  color: Colors.black,
                ),
                text: 'Home',
              ),
              Tab(
                icon: Icon(Icons.sanitizer_outlined, color: Colors.black),
                text: 'Product',
              ),
              Tab(
                icon: Icon(Icons.request_page_outlined, color: Colors.black),
                text: 'Request',
              ),
              Tab(
                icon: Icon(Icons.receipt_long_outlined, color: Colors.black),
                text: 'Bill',
              ),
              Tab(
                icon: Icon(Icons.account_circle_outlined, color: Colors.black),
                text: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
