// ignore_for_file: prefer_const_constructors

import 'package:fakestore_api/model/cart_screen_model.dart';
import 'package:fakestore_api/model/products_list_model.dart';
import 'package:fakestore_api/view/cart_screen/cart_screen.dart';
import 'package:flutter/material.dart';

class CartScreenController with ChangeNotifier {
  List<CartModel> cartList = [];

  //at first the amount is zero
  double totalAmount = 0;

  addToCart(ProductsListModel product, BuildContext context) {
    final isCarted =
        cartList.any((element) => element.product.id == product.id);
    if (isCarted) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => CartScreen()));
      print("alredy in cart");
    } else {
      cartList.add(CartModel(product: product));
    }
    calculateTM();
    notifyListeners();
  }

  deletFormCart(int index) {
    cartList.removeAt(index);
    calculateTM();
    notifyListeners();
  }

  onIncrementQty(int index) {
    cartList[index].qty = cartList[index].qty + 1;
    calculateTM();
    notifyListeners();
  }

  onDecrementQty(int index) {
    if (cartList[index].qty > 1) {
      cartList[index].qty = cartList[index].qty - 1;
      calculateTM();
      notifyListeners();
    }
  }

//for calculating total amount

  calculateTM() {
    totalAmount = 0;
    for (var element in cartList) {
      //to calculate the amount of each product
      totalAmount = totalAmount + (element.qty * (element.product.price ?? 0));
    }
    print("TOtal : $totalAmount");
    notifyListeners();
  }
}
