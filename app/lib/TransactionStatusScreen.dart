import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:msb/model/TransactionModel.dart';
import 'package:msb/api/transaction_api.dart';
import 'package:msb/notifier/TransactionNotifier.dart';
import 'package:provider/provider.dart';

class TransactionStatusScreen extends StatefulWidget {
  @override
  const TransactionStatusScreen({Key key, @required this.transaction})
      : super(key: key);
  final Transactions transaction;
  _TransactionStatusScreenState createState() =>
      _TransactionStatusScreenState();
}

class _TransactionStatusScreenState extends State<TransactionStatusScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        primary: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.check_circle_outline_rounded,
                size: 84.0, color: const Color(0xFF11CBD7)),
            SizedBox(height: 50.0),
            Text(
              "Successfully issued transaction. Please wait for Admin Confirmation in 1-3 days",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16.0),
            ),
            Text(widget.transaction.totalProduct.toString())
          ],
        ),
      ),
    );
  }
}
