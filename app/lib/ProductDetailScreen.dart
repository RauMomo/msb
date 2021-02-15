import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:msb/notifier/ProductNotifier.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    ProductNotifier productNotifier =
        Provider.of<ProductNotifier>(context, listen: false);
    // TODO: implement build
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Detail'),
        elevation: 0.0,
      ),
      body: new SafeArea(
        child: Stack(
          alignment: Alignment.centerLeft,
          fit: StackFit.expand,
          children: <Widget>[
            Column(
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
          margin: 20.00,
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
