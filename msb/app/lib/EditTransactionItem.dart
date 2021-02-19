import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:msb/HomeScreen.dart';
import 'package:msb/model/ProductModel.dart';
import 'package:msb/notifier/CartNotifier.dart';
import 'package:msb/notifier/ProductNotifier.dart';
import 'package:provider/provider.dart';

class EditTransactionItem extends StatefulWidget {
  const EditTransactionItem({Key key, @required this.product, this.index})
      : super(key: key);
  final Product product;
  final int index;
  @override
  _EditTransactionItemState createState() => _EditTransactionItemState();
}

class _EditTransactionItemState extends State<EditTransactionItem> {
  int stock;
  int price;
  TextEditingController _stock;
  TextEditingController _price;
  GlobalKey<FormState> _editTransaction =
      GlobalKey<FormState>(debugLabel: 'editTransaction');
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  void initState() {
    CartNotifier cart = Provider.of<CartNotifier>(context, listen: false);
    ProductNotifier productNotifier =
        Provider.of<ProductNotifier>(context, listen: false);
    stock = int.parse(widget.product.stock);
    price = widget.product.price;
    _price = TextEditingController();
    _price.value = TextEditingValue(
      text: price.toString(),
      selection: TextSelection.collapsed(
          offset: widget.product.price.toString().length),
    );
    _stock = TextEditingController();
    _stock.value = TextEditingValue(
      text: stock.toString(),
      selection: TextSelection.collapsed(
          offset: widget.product.stock.toString().length),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CartNotifier cart = Provider.of<CartNotifier>(context);
    ProductNotifier productNotifier = Provider.of<ProductNotifier>(context);
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      key: scaffoldKey,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Edit Item Cart'),
        elevation: 0.0,
      ),
      body: SafeArea(
        child: Form(
          key: _editTransaction,
          child: Stack(
            alignment: Alignment.centerLeft,
            fit: StackFit.expand,
            children: <Widget>[
              ListView(
                children: <Widget>[
                  Container(
                    height: deviceHeight * 0.2,
                    width: deviceWidth,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/logo_msb.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: deviceWidth * 0.02,
                        vertical: deviceHeight * 0.04),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            text: productNotifier.currentProduct.name,
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            text: "Stock Remaining: " +
                                productNotifier.currentProduct.stock.toString(),
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: deviceWidth * 0.02,
                              vertical: deviceHeight * 0.04),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              RichText(
                                textAlign: TextAlign.left,
                                text: TextSpan(
                                  style: TextStyle(color: Colors.black),
                                  text: "Expected Price",
                                ),
                              ),
                              RichText(
                                textAlign: TextAlign.right,
                                text: TextSpan(
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                    text: widget.product.price.toString()),
                              ),
                              RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                  text: "-",
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                  text:
                                      (widget.product.price + 50000).toString(),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          margin: EdgeInsets.all(20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(bottom: 20.0),
                                child: Text("Set Price: ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w200,
                                        height: 1.5)),
                              ),
                              Container(
                                width: 100.0,
                                child: TextFormField(
                                  controller: _price,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    counterText: "",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                  ),
                                  maxLength: 10,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Please enter the price';
                                    } else
                                      return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          margin: EdgeInsets.all(20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(bottom: 20.0),
                                child: Text("Set Stock: ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w200,
                                        height: 1.5)),
                              ),
                              Theme(
                                data: Theme.of(context)
                                    .copyWith(accentColor: Colors.transparent),
                                child: Container(
                                  width: 100.0,
                                  child: TextFormField(
                                    controller: _stock,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      fillColor: Colors.white,
                                      counterText: "",
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                    ),
                                    maxLength: 10,
                                  ),
                                ),
                              ),
                            ],
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
                                if (_editTransaction.currentState.validate()) {
                                  if (_stock.text == "0") {
                                    cart.removeItemfromCart(
                                        cart.cartList[widget.index]);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                HomeScreen(index: 2)));
                                  } else if (int.parse(_price.text) !=
                                      widget.product.price) {
                                    confirmPrice(context);
                                  } else {
                                    navigateShowSnackBar(context);
                                  }
                                }
                              },
                              color: const Color(0xFF11CBD7),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(left: 5),
                                    child: Text("Proceed",
                                        textAlign: TextAlign.end,
                                        style:
                                            new TextStyle(color: Colors.white)),
                                  ),
                                ],
                              ),
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
      ),
    );
  }

  navigateShowSnackBar(BuildContext context) async {
    await Navigator.pop(context, 'Item Successfully saved');
    // await Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //       maintainState: true, builder: (context) => HomeScreen(index: 2)),
    // );
    // Scaffold.of(context)
    //     .removeCurrentSnackBar()
    //     .showSnackBar(SnackBar(content: Text("Item successfully saved")));
  }

  confirmPrice(BuildContext context) {
    CartNotifier cart = Provider.of<CartNotifier>(context, listen: false);
    Widget cancelBtn = FlatButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text('Cancel'));
    Widget continueBtn = FlatButton(
        onPressed: () {
          widget.product.price = int.parse(_price.text);
          widget.product.stock = _stock.text;
          widget.product.totalPrice =
              cart.calculatePrice(widget.product.price, widget.product.stock);
          cart.editProductfromCart(widget.product, widget.index);
          Navigator.pop(context);
          navigateShowSnackBar(context);
        },
        child: Text('Continue'));
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Warning"),
        content: int.parse(_price.text) < widget.product.price
            ? Text(
                "You have set much lower price compared to the Expected Price of this item. The Admin is unlikely to approve your request and the price will be revised automatically. Would you like to proceed?")
            : Text(
                "You have set much higher price compared to the Expected Price of this item. The Admin is unlikely to approve your request and the price will be revised automatically. Would you like to proceed?"),
        actions: [
          cancelBtn,
          continueBtn,
        ],
        elevation: 1.00,
      ),
    );
  }
}
