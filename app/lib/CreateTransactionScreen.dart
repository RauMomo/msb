import 'package:flutter/material.dart';
import 'package:msb/EditTransactionItem.dart';
import 'package:msb/HistoryTransactionScreen.dart';
import 'package:msb/ProductListTransactionScreen.dart';
import 'package:msb/TransactionStatusScreen.dart';
import 'package:msb/api/client_api.dart';
import 'package:msb/api/transaction_api.dart';
import 'package:msb/component/ProductCard.dart';
import 'package:msb/model/ClientModel.dart';
import 'package:msb/model/ProductModel.dart';
import 'package:msb/model/TransactionModel.dart';
import 'package:msb/notifier/CartNotifier.dart';
import 'package:msb/notifier/ClientNotifier.dart';
import 'package:msb/notifier/TransactionNotifier.dart';
import 'package:provider/provider.dart';
import 'package:flushbar/flushbar.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CreateTransactionScreen extends StatefulWidget {
  @override
  _CreateTransactionPageState createState() => _CreateTransactionPageState();
}

class _CreateTransactionPageState extends State<CreateTransactionScreen> {
  List<bool> _isSelected = [];
  Client clientVal;
  bool isInvoice = false;
  List<DropdownMenuItem<Client>> clientOptions = [];
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  void initState() {
    _isSelected = [true, false];
    TransactionNotifier transactionNotifier =
        Provider.of<TransactionNotifier>(context, listen: false);
    getSuccessTransactionList(transactionNotifier);
    getPendingTransactionList(transactionNotifier);
    ClientNotifier clientNotifier =
        Provider.of<ClientNotifier>(context, listen: false);
    CartNotifier cart = Provider.of<CartNotifier>(context, listen: false);
    getClientList(clientNotifier);
    clientOptions = clientNotifier.clientList
        .map((value) =>
            new DropdownMenuItem(value: value, child: Text(value.name)))
        .toList();
    print(cart.cartList.length);
    super.initState();
  }

  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TransactionNotifier transactionNotifier =
        Provider.of<TransactionNotifier>(context);
    CartNotifier cart = Provider.of<CartNotifier>(context);
    ClientNotifier clientNotifier = Provider.of<ClientNotifier>(context);
    clientOptions.length > 0 && clientNotifier.selectedClient == null
        ? clientVal = clientOptions[0].value
        : CircularProgressIndicator();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Create Transaction",
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.history_outlined, color: Colors.white),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HistoryTransactionScreen(),
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.bottomCenter,
            child: ListView(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: Text("Client Name",
                      style: TextStyle(
                          fontFamily: "Segoe_UI_Bold",
                          fontSize: 20,
                          fontWeight: FontWeight.w500)),
                ),
                Container(
                  decoration: BoxDecoration(
                      //border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(30)),
                  margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
                  child: DropdownButton(
                    hint: Text("Choose Client",
                        style: TextStyle(fontFamily: "Segoe_UI", fontSize: 16)),
                    dropdownColor: Colors.greenAccent[200],
                    elevation: 10,
                    icon: Icon(Icons.arrow_drop_down_circle),
                    iconSize: 25.0,
                    isExpanded: true,
                    value: clientVal,
                    style: TextStyle(
                        color: Colors.black, fontSize: 16.0, height: 1.2),
                    onChanged: (value) {
                      setState(() {
                        clientNotifier.selectedClient = value;
                        clientVal = clientNotifier.selectedClient;
                      });
                    },
                    items: clientOptions,
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: Column(children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(bottom: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Confirm Order",
                            style: TextStyle(
                                fontFamily: "Segoe_UI_Bold",
                                fontSize: 20,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.3,
                            height: 35,
                            child: Container(
                              padding: EdgeInsets.only(left: 5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.deepOrange[400],
                              ),
                              child: Material(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.transparent,
                                child: InkWell(
                                  splashColor: Colors.deepOrange[400],
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  autofocus: false,
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ProductListTransactionScreen(),
                                      ),
                                    );
                                  },
                                  child: Center(
                                    child: Row(
                                      children: [
                                        Icon(Icons.add),
                                        Text(
                                          " Add Item",
                                          style: TextStyle(
                                              fontFamily: "Segoe_UI",
                                              fontSize: 17,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                        height: MediaQuery.of(context).size.height * 0.4,
                        width: double.infinity,
                        padding: EdgeInsets.only(bottom: 20),
                        child: cart.cartList.isNotEmpty
                            ? ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: cart.cartList.length,
                                addAutomaticKeepAlives: true,
                                itemBuilder:
                                    (BuildContext context, int index) =>
                                        new ProductCard(
                                            product: cart.cartList[index],
                                            index: index))
                            : Center(
                                child: Text(
                                    'There is no item on the cart, please add one!')))
                  ]),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Total",
                        style: TextStyle(
                            fontFamily: "Segoe_UI_Bold",
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(cart.calculateTotalPrice().toString(),
                          style: TextStyle(
                              fontFamily: "Segoe_UI_Bold",
                              fontSize: 20,
                              fontWeight: FontWeight.w500))
                    ],
                  ),
                  //   child: Text(
                  //     "Total :                                    240,000",
                  //     style: TextStyle(
                  //         fontFamily: "Segoe_UI_Bold",
                  //         fontSize: 20,
                  //         fontWeight: FontWeight.w500),
                  //   ),
                  // ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 20, top: 20, bottom: 20),
                  child: Text(
                    "Select Invoice Type",
                    style: TextStyle(
                        fontFamily: "Segoe_UI_Bold",
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 20, right: 20),
                  child: ToggleButtons(
                    borderRadius: BorderRadius.circular(20),
                    fillColor: Colors.blue,
                    selectedColor: Colors.orange[200],
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2.3,
                        height: 50,
                        child: Container(
                          child: Center(
                            child: Text('With Tax'),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2.3,
                        height: 50,
                        child: Container(
                          child: Center(
                            child: Text('Without Tax'),
                          ),
                        ),
                      ),
                    ],
                    onPressed: (int index) {
                      setState(() {
                        for (int i = 0; i < _isSelected.length; i++) {
                          _isSelected[i] = i == index;
                          if (index == 0) {
                            isInvoice = true;
                          } else {
                            isInvoice = false;
                          }
                        }
                      });
                    },
                    isSelected: _isSelected,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: FlatButton(
                      height: 50,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      onPressed: () {
                        confirmTransaction(context, cart, transactionNotifier);
                      },
                      child: Text("Continue",
                          style: new TextStyle(color: Colors.white)),
                      color: Colors.red,
                    ),
                  ),
                ),
                // Row(
                //   children: <Widget>[
                //     SizedBox(
                //       width: MediaQuery.of(context).size.width / 2,
                //       height: 50,
                //       child: Container(
                //         margin: EdgeInsets.only(left: 20, right: 20),
                //         child: ButtonChoice(
                //           originalColor: Colors.blue[200],
                //           pressedColor: Colors.orange[200],
                //           tap: () {},
                //           text: 'With Tax',
                //         ),
                //       ),
                //     ),
                //     SizedBox(
                //       width: MediaQuery.of(context).size.width / 2,
                //       height: 50,
                //       child: Container(
                //         margin: EdgeInsets.only(left: 20, right: 20),
                //         child: ButtonChoice(
                //           isTapped: _isSelected[0],
                //           originalColor: Colors.blue[200],
                //           pressedColor: Colors.orange[200],
                //           tap: () {
                //             setState(() {});
                //           },
                //           text: 'Without Tax',
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  confirmTransaction(BuildContext context, CartNotifier cart,
      TransactionNotifier transactionNotifier) {
    Transactions transaction = new Transactions(
      userId: firebaseUser.uid,
      invoice: isInvoice,
      date: DateTime.now(),
      email: FirebaseAuth.instance.currentUser.email,
      id: (transactionNotifier.pendingTransactionList.length +
              transactionNotifier.successTransactionList.length +
              1)
          .toString(),
      status: 'Pending',
      supplier: clientVal.name,
      totalPrice: cart.calculateTotalPrice(),
      totalProduct: cart.calculateTotalProduct(),
      products: cart.cartList,
    );
    Widget cancelBtn = FlatButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text('No'));
    Widget removeBtn = FlatButton(
        onPressed: () {
          proceedTransaction(transaction);
          Navigator.pop(context);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      TransactionStatusScreen(transaction: transaction)));
        },
        child: Text('Yes'));
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        content: Text("Are you sure?"),
        actions: [
          cancelBtn,
          removeBtn,
        ],
        elevation: 1.00,
      ),
    );
  }
}

// ignore: must_be_immutable
class ButtonChoice extends StatefulWidget {
  bool isTapped;
  VoidCallback tap;
  Color originalColor;
  Color pressedColor;
  String text;
  ButtonChoice(
      {this.tap,
      this.originalColor,
      this.pressedColor,
      this.text,
      this.isTapped});
  @override
  State<StatefulWidget> createState() {
    return new ButtonState();
  }
}

class ButtonState extends State<ButtonChoice> {
  @override
  Widget build(BuildContext context) {
    return new Expanded(
      child: new Material(
        borderRadius: BorderRadius.circular(20),
        color: widget.isTapped ? widget.pressedColor : widget.originalColor,
        child: new InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            widget.tap();
            this.setState(() {
              if (!widget.isTapped)
                widget.isTapped = true;
              else
                widget.isTapped = false;
            });
          },
          child: Center(
            child: Text(
              widget.text,
              style: TextStyle(
                  fontFamily: "Segoe_UI_Bold",
                  fontSize: 17,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ),
    );
  }
}
