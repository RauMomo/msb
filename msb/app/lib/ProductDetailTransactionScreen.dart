import 'package:flutter/material.dart';
import 'package:msb/component/NumericButton.dart';
import 'package:msb/notifier/CartNotifier.dart';
import 'package:msb/notifier/ProductNotifier.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flushbar/flushbar.dart';

class ProductDetailTransactionScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    ProductNotifier productNotifier =
        Provider.of<ProductNotifier>(context, listen: false);
    // TODO: implement build
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Product Detail'),
        elevation: 0.0,
      ),
      body: new SafeArea(
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
                    children: <Widget>[
                      RichText(
                        text: TextSpan(
                          text: productNotifier.currentProduct.name,
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          text: productNotifier.currentProduct.stock.toString(),
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
                                  text: productNotifier.currentProduct.price
                                      .toString()),
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
                                text: (productNotifier.currentProduct.price +
                                        50000)
                                    .toString(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: deviceWidth * 0.02,
                            vertical: deviceHeight * 0.04),
                        height: deviceHeight * 0.2,
                        width: deviceWidth / 1.2,
                        child: LineChart(
                          LineChartData(
                            backgroundColor: Colors.white10,
                            minX: 0,
                            minY: -10,
                            maxY: 10,
                            maxX: 10,
                            titlesData: LineTitles.getData(),
                            gridData: FlGridData(
                                show: true,
                                drawHorizontalLine: true,
                                getDrawingHorizontalLine: (value) {
                                  return FlLine(
                                    color: Colors.blue[300],
                                    strokeWidth: 1,
                                  );
                                }),
                            lineBarsData: [
                              LineChartBarData(
                                preventCurveOverShooting: true,
                                spots: [
                                  FlSpot(0, 4),
                                  FlSpot(2, 5),
                                  FlSpot(4, 4),
                                  FlSpot(6, 2),
                                  FlSpot(8, 0),
                                ],
                                curveSmoothness: 2.0,
                                show: true,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.all(20.0),
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(bottom: 20.0),
                              child: Text("Product Description",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w200,
                                      height: 1.5)),
                            ),
                            Text(
                              "There is no description on this product at the moment",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            Container(
                              margin:
                                  EdgeInsets.only(left: 20, right: 20, top: 20),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: FlatButton(
                                  height: 50,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(20.0)),
                                  onPressed: () {
                                    return modalBottomSheet(
                                        context, productNotifier);
                                  },
                                  color: const Color(0xFF11CBD7),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Icon(Icons.add_circle),
                                      Padding(
                                        padding: EdgeInsets.only(left: 5),
                                        child: Text("Add to Cart",
                                            textAlign: TextAlign.end,
                                            style: new TextStyle(
                                                color: Colors.white)),
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
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<Widget> modalBottomSheet(
      BuildContext context, ProductNotifier productNotifier) {
    CartNotifier cart = Provider.of<CartNotifier>(context, listen: false);
    int count = 1;
    return showModalBottomSheet(
      isDismissible: true,
      context: context,
      builder: (BuildContext context) => Container(
          height: MediaQuery.of(context).size.height * 0.4,
          color: Colors.white,
          padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(vertical: 20.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width / 1.5,
                        child: Text(
                          productNotifier.currentProduct.name,
                          style: TextStyle(
                              fontFamily: "Segoe_UI_Bold",
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ]),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 20.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Text(
                          "Price",
                          style: TextStyle(
                              fontFamily: "Segoe_UI_Bold",
                              fontSize: 17,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Container(
                        child: Text(
                          productNotifier.currentProduct.price.toString(),
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontFamily: "Segoe_UI_Bold",
                              fontSize: 17,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ]),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Text(
                        "Quantity",
                        style: TextStyle(
                            fontFamily: "Segoe_UI_Bold",
                            fontSize: 17,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Container(
                      child: NumericButton(
                        min: 1,
                        max: 20,
                        quantityValue: (value) => count = value,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  color: const Color(0xFF11CBD7),
                  height: 50.0,
                  onPressed: () {
                    if (count == 0) {}
                    cart.addItemtoCart(productNotifier.currentProduct, count);
                    Navigator.pop(context);
                    // return showCartAddedSnackbar(
                    //     builderContext);
                    return showFlushbar(context);
                    // Scaffold.of(
                    //         builderContext)
                    //     .showSnackBar(
                    //         new SnackBar(
                    //   behavior:
                    //       SnackBarBehavior.floating,
                    //   padding:
                    //       EdgeInsets.all(30.0),
                    //   duration:
                    //       Duration(milliseconds: 2000),
                    //   content:
                    //       new Text(
                    //     "Added to Cart",
                    //   ),
                    //   elevation:
                    //       7.0,
                    // )).;
                    // setState(
                    //     () {
                    //   showFab =
                    //       true;
                    // });
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.add_circle),
                      Padding(
                        padding: EdgeInsets.only(left: 5),
                        child: Text("Add to Cart",
                            textAlign: TextAlign.end,
                            style: new TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
    ).whenComplete(() {
      // Scaffold.of(context)
      //     .showSnackBar(
      //         new SnackBar(
      //   behavior: SnackBarBehavior
      //       .floating,
      //   padding:
      //       EdgeInsets.all(30.0),
      //   duration: Duration(
      //       milliseconds: 2000),
      //   content: new Text(
      //     "Added to Cart",
      //   ),
      //   elevation: 7.0,
      // ));
    });
  }

  void showFlushbar(BuildContext context) {
    Flushbar(
      padding: EdgeInsets.all(10),
      message: 'Added to cart',
      duration: Duration(seconds: 2),
    ).show(context);
  }
}

class LineTitles {
  static getData() => FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          getTextStyles: (value) {
            TextStyle(fontSize: 7.0);
          },
          showTitles: true,
          getTitles: (value) {
            var exactValue = value.toInt();
            if (exactValue == 2) {
              return 'SEP';
            } else if (exactValue == 4) {
              return 'OCT';
            } else if (exactValue == 6) {
              return 'NOV';
            } else if (exactValue == 8) {
              return 'DEC';
            } else
              return '';
          },
        ),
        leftTitles: SideTitles(
          showTitles: true,
          margin: 22.0,
          getTitles: (value) {
            var exactValue = value.toInt();
            if (exactValue == 4) {
              return '200.000';
            } else if (exactValue == 8) {
              return '250.000';
            } else if (exactValue == 0) {
              return '150.000';
            } else if (exactValue == -4) {
              return '100.000';
            } else if (exactValue == -8) {
              return '50.000';
            } else
              return '';
          },
        ),
      );
}
