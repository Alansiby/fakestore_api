import 'package:fakestore_api/model/products_list_model.dart';

class CartModel {
  ProductsListModel product;
  int qty;
  CartModel({required this.product, this.qty = 1});
}
