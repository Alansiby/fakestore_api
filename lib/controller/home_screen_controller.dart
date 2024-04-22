import 'dart:convert';
import 'dart:developer';

import 'package:fakestore_api/model/products_list_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreenController with ChangeNotifier {
  //initial state
  List<ProductsListModel> productsList = [];
  //loading
  bool isLoading = false;
  Future getProvider() async {
    //show loading when data is loading
    notifyListeners();
    isLoading = true;
    final url = Uri.parse("https://fakestoreapi.com/products");
    //api should be in a try catch block to handle exception
    try {
      final res = await http.get(url);

      if (res.statusCode == 200) {
        //decode
        final decodedRes = jsonDecode(res.body) as List;
        log(decodedRes.toString());
        List<ProductsListModel> productsList = decodedRes
            .map((element) => ProductsListModel.fromJson(element)
                // (
                //       id: e["id"],
                //       title: e["title"],
                //       category: e["category"],
                //       description: e["description"],
                //       image: e["image"],
                //       price: e["price"],
                // )
                )
            .toList();

        log(productsList.first.title.toString());
      } else {
        log("fail");
      }
      //end of try block
    }
    //catch block
    catch (e) {
      log(e.toString());
    }
    notifyListeners();
    isLoading = false;
  }
}
