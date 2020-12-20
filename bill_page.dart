import 'package:flutter/material.dart';

class BillPage extends StatefulWidget {
  @override
  _BillPageState createState() => _BillPageState();
}

class _BillPageState extends State<BillPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "Bill",
            style: TextStyle(fontFamily: "Segoe UI"),
          ),
        ),
        body: Stack(
          children: <Widget>[
            Container(
                margin: EdgeInsets.only(top: 25, left: 30),
                child: Text(
                  "File",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
                )),
            Container(
              margin: EdgeInsets.fromLTRB(20, 80, 20, 30),
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.88,
                    height: 150,
                    child: Container(
                      child: Material(
                        elevation: 10,
                        borderRadius: BorderRadius.circular(30),
                        //color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(30),
                          splashColor: Colors.amber,
                          onTap: () {},
                          child: Center(
                              child: Text(
                            "Piutang MSB"
                            "\n"
                            "September 2020",
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 20),
                          )),
                        ),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white54,
                      ),
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
}
