import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:msb/model/ProductModel.dart';

class CartNotifier with ChangeNotifier {
  List<Product> _cartList = [];
  int _totalPrice = 0;
  Product currentItem;

  set cartList(List<Product> cartList) {
    _cartList = cartList;
  }

  UnmodifiableListView<Product> get cartList => UnmodifiableListView(_cartList);

  set totalPrice(int totalPrice) {
    _totalPrice = calculateTotalPrice();
    notifyListeners();
  }

  int get totalPrice => _totalPrice;

  void addItemtoCart(Product prod, int qty) {
    bool isFound = false;
    int result;
    if (_cartList.length > 0) {
      for (int count = 0; count < _cartList.length; count++) {
        if (prod.name == _cartList[count].name) {
          isFound = true;
          result = int.parse(_cartList[count].stock);
          result = result + qty;
          _cartList[count].stock = result.toString();
          _cartList[count].totalPrice =
              calculatePrice(_cartList[count].price, _cartList[count].stock);
          break;
          //  else if (prod.name == _cartList[count].name && isFound == true) {
          //   _cartList.removeAt(count);
        } else if (count == _cartList.length - 1) {
          _cartList.add(new Product(
              name: prod.name,
              price: prod.price,
              stock: qty.toString(),
              totalPrice: calculatePrice(prod.price, qty.toString())));
          break;
        }
      }
    } else {
      _cartList.add(new Product(
          name: prod.name,
          price: prod.price,
          stock: qty.toString(),
          totalPrice: calculatePrice(prod.price, qty.toString())));
    }
    notifyListeners();
  }

  void removeItemfromCart(Product prod) {
    _cartList.remove(prod);
    notifyListeners();
  }

  void editProductfromCart(Product product, int index) {
    Product _prod = _cartList.firstWhere((prod) => prod.name == product.name);
    _cartList.remove(_prod);
    _cartList.insert(index, product);
  }

  int calculateTotalPrice() {
    int price = 0;
    if (_cartList.isNotEmpty) {
      _cartList.forEach((prod) {
        price += (prod.price * int.parse(prod.stock));
      });
      return price;
    } else
      return 0;
  }

  int calculatePrice(int price, String stock) {
    notifyListeners();
    return price * int.parse(stock);
  }

  int calculateTotalProduct() {
    int totalAmount = 0;
    if (_cartList.isNotEmpty) {
      _cartList.forEach((prod) {
        totalAmount += int.parse(prod.stock);
      });
      return totalAmount;
    } else {
      return 0;
    }
  }
}
