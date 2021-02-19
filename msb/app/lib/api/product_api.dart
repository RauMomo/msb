import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:msb/model/ProductModel.dart';
import 'package:msb/notifier/ProductNotifier.dart';

getProducts(ProductNotifier productNotifier) async {
  QuerySnapshot snapshot =
      await FirebaseFirestore.instance.collection('products').limit(50).get();

  List<Product> _productList = [];

  snapshot.docs.forEach((document) {
    Product product = new Product(
        name: document.data()['product_name'],
        stock: document.data()['product_stock'].toString(),
        price: determinePrice(document.data()['product_name']),
        totalPrice: 0);
    _productList.add(product);
  });
  productNotifier.productList = _productList;
  return _productList;
}

searchQuery(String productName, ProductNotifier productNotifier) async {
  List<Product> _queryResult = [];
  //   .startAt([productName.toUpperCase()]).endAt(
  // [productName.toUpperCase() + '\uf8ff']).get();
  QuerySnapshot newSnapshot = await FirebaseFirestore.instance
      .collection('products')
      .orderBy('product_name')
      .startAt([productName.toUpperCase()]).endAt(
          [productName.toUpperCase() + '\uf8ff']).get();

  newSnapshot.docs.forEach((document) {
    Product product = new Product(
        name: document.data()['product_name'],
        stock: document.data()['product_stock'].toString(),
        price: determinePrice(document.data()['product_name']),
        totalPrice: 0);
    _queryResult.add(product);
  });
  productNotifier.productList = _queryResult;
}

int determinePrice(String name) {
  if (name.startsWith(new RegExp("^[1-9]"))) {
    return 100000;
  } else if (name.startsWith(new RegExp("^[A-Ja-j]"))) {
    return 125000;
  } else if (name.startsWith(new RegExp("^[K-Tk-t]"))) {
    return 150000;
  } else if (name.startsWith(new RegExp("^[U-Zu-z]"))) {
    return 175000;
  } else
    return 200000;
}
