import 'package:msb/model/ProductModel.dart';
import 'package:msb/notifier/TransactionNotifier.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:msb/model/TransactionModel.dart';
import 'product_api.dart';
import 'package:firebase_auth/firebase_auth.dart';

final firebaseUser = FirebaseAuth.instance.currentUser;
Transactions transaction = new Transactions();
String str = "";
getPendingTransactionList(TransactionNotifier transactionNotifier) async {
  QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection('transactions')
      .where('transaction_status', isEqualTo: 'Pending')
      .get()
      .catchError((onError) {
    print('error');
  });
  str = FirebaseFirestore.instance.collection('transactions').doc().id;
  List<Transactions> transactionList = List<Transactions>();
  snapshot.docs.forEach((document) {
    Transactions transaction = Transactions(
        date: (document.get('transaction_date') as Timestamp).toDate(),
        email: document.get('transaction_email'),
        id: str,
        supplier: document.get('transaction_supplier'),
        products: List<Product>.from(
            document.data()['transaction_products'].map((item) {
          return Product(
            name: item['product_name'],
            stock: item['product_amount'].toString(),
            // price: determinePrice(item['product_name']));
            price: item['product_retail_price'],
          );
        })).toList(),
        invoice: document.get('transaction_invoice'),
        status: document.get('transaction_status'),
        totalPrice: document.get('transaction_total_price'),
        totalProduct: document.get('transaction_total_product'));
    transactionList.add(transaction);
  });
  transactionNotifier.pendingTransactionList = transactionList;
}

getSuccessTransactionList(TransactionNotifier transactionNotifier) async {
  QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection('transactions')
      .where('transaction_status', isEqualTo: 'Verified')
      .get()
      .catchError((onError) {
    print('error');
  });
  str = FirebaseFirestore.instance.collection('transactions').doc().id;

  List<Transactions> transactionList = List<Transactions>();
  snapshot.docs.forEach((document) {
    Transactions transaction = Transactions(
        date: (document.get('transaction_date') as Timestamp).toDate(),
        email: document.get('transaction_email'),
        id: str,
        supplier: document.get('transaction_supplier'),
        products: List<Product>.from(
            document.data()['transaction_products'].map((item) {
          return Product(
              name: item['product_name'],
              stock: item['product_amount'].toString(),
              price: item['product_retail_price']);
        })).toList(),
        invoice: document.get('transaction_invoice'),
        status: document.get('transaction_status'),
        totalPrice: document.get('transaction_total_price'),
        totalProduct: document.get('transaction_total_product'));
    transactionList.add(transaction);
  });
  transactionNotifier.successTransactionList = transactionList;
}

Future<void> proceedTransaction(Transactions transaction) async {
  await FirebaseFirestore.instance.collection('transactions').add({
    'transaction_date': Timestamp.fromDate(transaction.date),
    'transaction_email': transaction.email,
    'tranasction_id': transaction.id,
    'transaction_invoice': transaction.invoice,
    'transaction_products': transaction.products
        .map((e) => {
              'product_amount': e.stock,
              'product_description': "-",
              'product_name': e.name,
              'product_retail_price': e.price,
              'product_total_price': e.totalPrice
            })
        .toList(),
    'transaction_status': transaction.status,
    'transaction_supplier': transaction.supplier,
    'transaction_total_price': transaction.totalPrice,
    'transaction_total_product': transaction.totalProduct,
    'user_id': transaction.userId
  });
}
