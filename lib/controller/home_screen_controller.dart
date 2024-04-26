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
    isLoading = true;
    notifyListeners();
    final url = Uri.parse("https://fakestoreapi.com/products");

    //api should be in a try catch block to handle exception
    try {
      final res = await http.get(url);

//Chicking the statuscode
      if (res.statusCode == 200) {
        //decode
        final decodedRes = jsonDecode(res.body) as List;
        log(decodedRes.toString());

        //Decoding the Product List Model
        productsList = decodedRes
            .map((element) => ProductsListModel.fromJson(element)

                //manual
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
        //Statuscode fail
        log("fail");
      }
      //end of try block
    }

    //catch block
    catch (e) {
      log(e.toString());
    }

    isLoading = false;
    notifyListeners();
  }
}
