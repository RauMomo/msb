import 'package:flutter/material.dart';
import 'package:msb/EditTransactionItem.dart';
import 'package:msb/model/ProductModel.dart';
import 'package:msb/notifier/CartNotifier.dart';
import 'package:provider/provider.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({Key key, @required this.product, this.index})
      : super(key: key);
  final Product product;
  final int index;
  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  Widget build(BuildContext context) {
    CartNotifier cart = Provider.of<CartNotifier>(context, listen: false);
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.25,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.2),
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
                margin: EdgeInsets.fromLTRB(20, 10, 0, 10),
                child: Text(widget.product.name,
                    style: TextStyle(
                        fontFamily: "Segoe_UI",
                        fontSize: 18,
                        fontWeight: FontWeight.w500)),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Asking Price",
                        style: TextStyle(
                            fontFamily: "Segoe_UI",
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            height: 1.5)),
                    Text(widget.product.price.toString(),
                        style: TextStyle(
                            fontFamily: "Segoe_UI",
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            height: 1.5)),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.27,
                      height: 35,
                      child: Container(
                        margin: EdgeInsets.only(left: 35),
                        child: Material(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(20),
                            splashColor: Colors.amber,
                            onTap: () {
                              displaySnackbar(context);
                            },
                            child: Center(
                                child: Text(
                              "Edit",
                              style: TextStyle(
                                  fontFamily: "Segoe_UI",
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
                alignment: Alignment.center,
                margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Stock",
                        style: TextStyle(
                            fontFamily: "Segoe_UI",
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            height: 1.5)),
                    Text(widget.product.stock,
                        style: TextStyle(
                            fontFamily: "Segoe_UI",
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            height: 1.5)),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.27,
                      height: 35,
                      child: Container(
                        margin: EdgeInsets.only(left: 35),
                        child: Material(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(20),
                            splashColor: Colors.amber,
                            onTap: () {
                              confirmDelete(context);
                            },
                            child: Center(
                                child: Text(
                              "Delete",
                              style: TextStyle(
                                  fontFamily: "Segoe_UI",
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500),
                            )),
                          ),
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.deepOrange[400],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Total Price",
                        style: TextStyle(
                            fontFamily: "Segoe_UI",
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            height: 1.5)),
                    Text("  " + widget.product.totalPrice.toString(),
                        style: TextStyle(
                            fontFamily: "Segoe_UI",
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            height: 1.5)),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.27,
                      height: 35,
                      child: Container(
                        margin: EdgeInsets.only(left: 35),
                        child: Material(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(20),
                            splashColor: Colors.transparent,
                            onTap: () {},
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
    );
  }

  confirmDelete(BuildContext context) {
    CartNotifier cart = Provider.of<CartNotifier>(context, listen: false);
    Widget cancelBtn = FlatButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text('Cancel'));
    Widget removeBtn = FlatButton(
        onPressed: () {
          cart.removeItemfromCart(cart.cartList[widget.index]);
          Navigator.pop(context);
        },
        child: Text('Remove'));
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        content: Text("Are you sure you want to remove this item?"),
        actions: [
          cancelBtn,
          removeBtn,
        ],
        elevation: 1.00,
      ),
    );
  }

  Future<void> displaySnackbar(BuildContext context) async {
    CartNotifier cart = Provider.of<CartNotifier>(context, listen: false);
    final result = await Navigator.push(
      context,
      new MaterialPageRoute(
        builder: (context) => new EditTransactionItem(
          product: cart.cartList[widget.index],
          index: widget.index,
        ),
      ),
    );
    if (result == null) {
      Scaffold.of(context).removeCurrentSnackBar();
    } else {
      Scaffold.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text("$result")));
    }
  }
}
