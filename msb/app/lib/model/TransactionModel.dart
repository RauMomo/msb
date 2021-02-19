import 'package:msb/model/ProductModel.dart';

class Transactions {
  String id;
  String userId;
  String email;
  bool invoice;
  DateTime date;
  List<Product> products;
  String status;
  String supplier;
  int totalPrice;
  int totalProduct;

  Transactions(
      {this.id,
      this.userId,
      this.email,
      this.invoice,
      this.date,
      this.products,
      this.status,
      this.supplier,
      this.totalPrice,
      this.totalProduct});

  Transactions.fromMap(Map<String, dynamic> data) {
    id = data['transaction_id'];
    email = data['transaction_email'];
    invoice = data['transaction_invoice'];
    date = data['transaction_date'];
    products = data['transaction_products'];
    status = data['transaction_status'];
    supplier = data['transaction_supplier'];
    totalPrice = data['transaction_total_price'];
    totalProduct = data['transaction_total_product'];
  }
}
