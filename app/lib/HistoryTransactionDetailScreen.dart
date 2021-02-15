import 'package:flutter/material.dart';
import 'package:msb/notifier/TransactionNotifier.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'dart:core';

class HistoryTransactionDetailScreen extends StatelessWidget {
  String convertDatetime(DateTime date) {
    var formattedDate = DateFormat.yMMMd().format(date);
    return formattedDate.toString();
  }

  Widget build(BuildContext context) {
    TransactionNotifier transactionNotifier =
        Provider.of<TransactionNotifier>(context, listen: false);
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Detail'),
        elevation: 1.0,
      ),
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
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
                      text: "Transaction ID : " +
                          transactionNotifier.currentTransaction.id,
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: "Created at : " +
                          convertDatetime(
                              transactionNotifier.currentTransaction.date),
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: deviceWidth * 0.1,
                        vertical: deviceHeight * 0.02),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        RichText(
                          textAlign: TextAlign.left,
                          text: TextSpan(
                            style: TextStyle(color: Colors.black, fontSize: 17),
                            text: "Client Name",
                          ),
                        ),
                        RichText(
                            text: TextSpan(
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17),
                                text: transactionNotifier
                                    .currentTransaction.supplier)),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: deviceWidth * 0.1,
                        vertical: deviceHeight * 0.02),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        RichText(
                          textAlign: TextAlign.left,
                          text: TextSpan(
                            style: TextStyle(color: Colors.black, fontSize: 17),
                            text: "Invoice",
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17),
                              text: transactionNotifier
                                          .currentTransaction.invoice ==
                                      true
                                  ? "With Invoice"
                                  : " Without Invoice"),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: deviceWidth * 0.1,
                        vertical: deviceHeight * 0.02),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        RichText(
                          textAlign: TextAlign.left,
                          text: TextSpan(
                            style: TextStyle(color: Colors.black, fontSize: 17),
                            text: "Total Products",
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17),
                              text: transactionNotifier
                                  .currentTransaction.totalProduct
                                  .toString()),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: deviceWidth * 0.1,
                        vertical: deviceHeight * 0.02),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        RichText(
                          textAlign: TextAlign.left,
                          text: TextSpan(
                            style: TextStyle(color: Colors.black, fontSize: 17),
                            text: "Total Price",
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17),
                              text: transactionNotifier
                                  .currentTransaction.totalPrice
                                  .toString()),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: Text("Products", style: TextStyle(fontSize: 17.0)),
            ),
            Container(
              child: ListView.builder(
                physics: ScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                shrinkWrap: true,
                itemCount:
                    transactionNotifier.currentTransaction.products.length,
                itemBuilder: (BuildContext context, int index) =>
                    transactionNotifier.currentTransaction.products.length !=
                            null
                        ? Card(
                            borderOnForeground: true,
                            child: InkWell(
                              splashColor: Colors.blue.shade300,
                              onTap: () {},
                              child: Container(
                                height: MediaQuery.of(context).size.height / 8,
                                width: MediaQuery.of(context).size.width,
                                child: new ListTile(
                                  title: Text(transactionNotifier
                                      .currentTransaction.products[index].name),
                                  subtitle: Text(transactionNotifier
                                          .currentTransaction
                                          .products[index]
                                          .stock +
                                      " Items"),
                                  trailing: Text(transactionNotifier
                                      .currentTransaction.products[index].price
                                      .toString()),
                                ),
                              ),
                            ),
                          )
                        : Center(child: Text("No data")),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
