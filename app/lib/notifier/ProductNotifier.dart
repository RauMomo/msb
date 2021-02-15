import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:msb/api/product_api.dart';
import 'package:msb/model/ProductModel.dart';

class ProductNotifier with ChangeNotifier {
  ProductNotifier() {
    getProducts();
  }
  List<Product> _productList = [];
  List<Product> _searchResult = [];
  Product _currentProduct;

  UnmodifiableListView<Product> get productList =>
      UnmodifiableListView(_productList);

  Product get currentProduct => _currentProduct;

  UnmodifiableListView<Product> get searchResult =>
      UnmodifiableListView(_searchResult);

  set productList(List<Product> productList) {
    _productList = productList;
    notifyListeners();
  }

  set searchResult(List<Product> searchResult) {
    _searchResult = searchResult;
    notifyListeners();
  }

  set currentProduct(Product currentProduct) {
    _currentProduct = currentProduct;
    notifyListeners();
  }

  void searchProduct() {
    productList.clear();
  }

  Future<void> getProducts() async {
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
    productList = _productList;
  }

  Future<void> searchQuery(String productName) async {
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
    productList = _queryResult;
  }
}
