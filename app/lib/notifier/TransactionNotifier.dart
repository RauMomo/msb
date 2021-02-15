import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:msb/model/TransactionModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionNotifier with ChangeNotifier {
  List<Transactions> _pendingTransactionList = [];
  List<Transactions> _successTransactionList = [];
  Transactions _currentTransaction;

  UnmodifiableListView<Transactions> get pendingTransactionList =>
      UnmodifiableListView(_pendingTransactionList);

  UnmodifiableListView<Transactions> get successTransactionList =>
      UnmodifiableListView(_successTransactionList);

  Transactions get currentTransaction => _currentTransaction;

  set pendingTransactionList(List<Transactions> pendingTransactionList) {
    _pendingTransactionList = pendingTransactionList;
    notifyListeners();
  }

  set successTransactionList(List<Transactions> successTransactionList) {
    _successTransactionList = successTransactionList;
    notifyListeners();
  }

  set currentTransaction(Transactions currentTransaction) {
    _currentTransaction = currentTransaction;
    notifyListeners();
  }

  Future proceedTransaction(Transactions transaction) async {
    await FirebaseFirestore.instance.collection('transactions').add({
      'transaction_date': Timestamp.fromDate(transaction.date),
      'transaction_email': transaction.email,
      'tranasction_id': transaction.id,
      'transaction_invoice': transaction.invoice,
      'transaction_products': transaction.products,
      'transaction_status': transaction.status,
      'transaction_supplier': transaction.supplier,
      'transaction_total_price': transaction.totalPrice,
      'transaction_total_product': transaction.totalProduct,
      'user_id': transaction.userId
    });
    notifyListeners();
  }
}
