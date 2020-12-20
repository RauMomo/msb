import 'package:flutter/material.dart';

class CreateTransactionPage extends StatefulWidget {
  @override
  _CreateTransactionPageState createState() => _CreateTransactionPageState();
}

class _CreateTransactionPageState extends State<CreateTransactionPage> {
  String _friendsVal;
  List _friendsName = ["Apotek ABC", "Apotek DEF", "Apotek GHI", "Apotek JKL"];
  int selectedIndex = 0;
  List<String> list = ["with tax", "without tax"];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "Create Transaction",
            style: TextStyle(fontFamily: "Segoe_UI"),
          ),
        ),
        body: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.bottomCenter,
              child: ListView(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.fromLTRB(30, 30, 0, 0),
                    child: Text("Client Name",
                        style: TextStyle(
                            fontFamily: "Segoe_UI_Bold",
                            fontSize: 20,
                            fontWeight: FontWeight.w500)),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 16.0, right: 16.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        //border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(30)),
                    margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: DropdownButton(
                      hint: Text("Choose Your Role",
                          style: TextStyle(fontFamily: "Segoe_UI")),
                      dropdownColor: Colors.white,
                      elevation: 10,
                      icon: Icon(Icons.arrow_drop_down_circle),
                      iconSize: 25.0,
                      isExpanded: true,
                      value: _friendsVal,
                      style: TextStyle(color: Colors.black, fontSize: 20.0),
                      onChanged: (value) {
                        setState(() {
                          _friendsVal = value;
                        });
                      },
                      items: _friendsName.map((value) {
                        return DropdownMenuItem(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(30, 30, 0, 0),
                    child: Text(
                      "Confirm Order",
                      style: TextStyle(
                          fontFamily: "Segoe_UI_Bold",
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                    width: 150,
                    height: 190,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 7,
                            offset: Offset(1, 1))
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.fromLTRB(20, 20, 0, 25),
                              child: Text(
                                  "Alcohol Swab                      4 pcs",
                                  style: TextStyle(
                                      fontFamily: "Segoe_UI_Bold",
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500)),
                            ),
                            Container(
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(left: 20),
                                    child: Text("Price at           20,000",
                                        style: TextStyle(
                                            fontFamily: "Segoe_UI_Bold",
                                            fontSize: 17,
                                            fontWeight: FontWeight.w500)),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.35,
                                    height: 35,
                                    child: Container(
                                      margin: EdgeInsets.only(left: 35),
                                      child: Material(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.transparent,
                                        child: InkWell(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          splashColor: Colors.amber,
                                          onTap: () {},
                                          child: Center(
                                              child: Text(
                                            "Edit",
                                            style: TextStyle(
                                                fontFamily: "Segoe_UI_Bold",
                                                fontSize: 17,
                                                fontWeight: FontWeight.w500),
                                          )),
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.lightBlueAccent,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 20),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(left: 20),
                                    child: Text("Total Price     80,000",
                                        style: TextStyle(
                                            fontFamily: "Segoe_UI_Bold",
                                            fontSize: 17,
                                            fontWeight: FontWeight.w500)),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.35,
                                    height: 35,
                                    child: Container(
                                      margin: EdgeInsets.only(left: 35),
                                      child: Material(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.transparent,
                                        child: InkWell(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          splashColor: Colors.amber,
                                          onTap: () {},
                                          child: Center(
                                              child: Text(
                                            "Delete",
                                            style: TextStyle(
                                                fontFamily: "Segoe_UI_Bold",
                                                fontSize: 17,
                                                fontWeight: FontWeight.w500),
                                          )),
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                    width: 150,
                    height: 190,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 7,
                            offset: Offset(1, 1))
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.fromLTRB(20, 20, 0, 25),
                              child: Text(
                                  "Alcohol Swab                      4 pcs",
                                  style: TextStyle(
                                      fontFamily: "Segoe_UI_Bold",
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500)),
                            ),
                            Container(
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(left: 20),
                                    child: Text("Price at           20,000",
                                        style: TextStyle(
                                            fontFamily: "Segoe_UI_Bold",
                                            fontSize: 17,
                                            fontWeight: FontWeight.w500)),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.35,
                                    height: 35,
                                    child: Container(
                                      margin: EdgeInsets.only(left: 35),
                                      child: Material(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.transparent,
                                        child: InkWell(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          splashColor: Colors.amber,
                                          onTap: () {},
                                          child: Center(
                                              child: Text(
                                            "Edit",
                                            style: TextStyle(
                                                fontFamily: "Segoe_UI_Bold",
                                                fontSize: 17,
                                                fontWeight: FontWeight.w500),
                                          )),
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.lightBlueAccent,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 20),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(left: 20),
                                    child: Text("Total Price     80,000",
                                        style: TextStyle(
                                            fontFamily: "Segoe_UI_Bold",
                                            fontSize: 17,
                                            fontWeight: FontWeight.w500)),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.35,
                                    height: 35,
                                    child: Container(
                                      margin: EdgeInsets.only(left: 35),
                                      child: Material(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.transparent,
                                        child: InkWell(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          splashColor: Colors.amber,
                                          onTap: () {},
                                          child: Center(
                                              child: Text(
                                            "Delete",
                                            style: TextStyle(
                                                fontFamily: "Segoe_UI_Bold",
                                                fontSize: 17,
                                                fontWeight: FontWeight.w500),
                                          )),
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
                    width: 150,
                    height: 190,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 7,
                            offset: Offset(1, 1))
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.fromLTRB(20, 20, 0, 25),
                              child: Text(
                                  "Alcohol Swab                      4 pcs",
                                  style: TextStyle(
                                      fontFamily: "Segoe_UI_Bold",
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500)),
                            ),
                            Container(
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(left: 20),
                                    child: Text("Price at           20,000",
                                        style: TextStyle(
                                            fontFamily: "Segoe_UI_Bold",
                                            fontSize: 17,
                                            fontWeight: FontWeight.w500)),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.35,
                                    height: 35,
                                    child: Container(
                                      margin: EdgeInsets.only(left: 35),
                                      child: Material(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.transparent,
                                        child: InkWell(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          splashColor: Colors.amber,
                                          onTap: () {},
                                          child: Center(
                                              child: Text(
                                            "Edit",
                                            style: TextStyle(
                                                fontFamily: "Segoe_UI_Bold",
                                                fontSize: 17,
                                                fontWeight: FontWeight.w500),
                                          )),
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.lightBlueAccent,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 20),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(left: 20),
                                    child: Text("Total Price     80,000",
                                        style: TextStyle(
                                            fontFamily: "Segoe_UI_Bold",
                                            fontSize: 17,
                                            fontWeight: FontWeight.w500)),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.35,
                                    height: 35,
                                    child: Container(
                                      margin: EdgeInsets.only(left: 35),
                                      child: Material(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.transparent,
                                        child: InkWell(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          splashColor: Colors.amber,
                                          onTap: () {},
                                          child: Center(
                                              child: Text(
                                            "Delete",
                                            style: TextStyle(
                                                fontFamily: "Segoe_UI_Bold",
                                                fontSize: 17,
                                                fontWeight: FontWeight.w500),
                                          )),
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    child: Text(
                      "Total :                                    240,000",
                      style: TextStyle(
                          fontFamily: "Segoe_UI_Bold",
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20, top: 20),
                    child: Text(
                      "Select Invoice Type",
                      style: TextStyle(
                          fontFamily: "Segoe_UI_Bold",
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            customRadio(list[0], 0),
                            customRadio(list[1], 1),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(20, 20, 20, 30),
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.88,
                          height: 45,
                          child: Container(
                            child: Material(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(20),
                                splashColor: Colors.amber,
                                onTap: () {},
                                child: Center(
                                    child: Text(
                                  "Proceed",
                                  style: TextStyle(
                                      fontFamily: "Segoe_UI_Bold",
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                )),
                              ),
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.lightBlueAccent,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void changeIndex(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  Widget customRadio(String txt, int index) {
    return OutlineButton(
      onPressed: () => changeIndex(index),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      borderSide:
          BorderSide(color: selectedIndex == index ? Colors.cyan : Colors.grey),
      child: Text(
        txt,
        style: TextStyle(
            color: selectedIndex == index ? Colors.cyan : Colors.grey,
            fontFamily: "Segoe_UI_Bold",
            fontSize: 18,
            fontWeight: FontWeight.w500),
      ),
    );
  }
}
