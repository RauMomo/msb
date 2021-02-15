import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  String name;
  String stock;
  int price;
  int totalPrice;

  Product({this.name, this.stock, this.price, this.totalPrice});
  Product.fromMap(Map<String, dynamic> snapshot) {
    name = snapshot['name'];
    stock = snapshot["stock"];
    price = snapshot["price"];
  }
}
