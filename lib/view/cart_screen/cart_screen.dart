// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:fakestore_api/controller/cart_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Consumer<CartScreenController>(
          builder: (context, providerObj, child) {
            return ListView.builder(
                itemCount: providerObj.cartList.length,
                itemBuilder: (context, index) => Container(
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        child: Container(
                          width: double.infinity,
                          decoration:
                              BoxDecoration(color: Colors.white, boxShadow: [
                            BoxShadow(
                                offset: Offset(4, 6),
                                blurRadius: 6,
                                color: Colors.black.withOpacity(0.4))
                          ]),
                          child: Row(
                            children: [
                              Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(providerObj
                                                .cartList[index]
                                                .product
                                                .image ??
                                            ""))),
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 105,
                                    ),
                                    Text(
                                      providerObj.cartList[index].product.title
                                          .toString(),
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(providerObj
                                        .cartList[index].product.price
                                        .toString())
                                  ],
                                ),
                              ),
                              Spacer(),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  InkWell(
                                      onTap: () {
                                        providerObj.deletFormCart(index);
                                      },
                                      child: Icon(Icons.delete)),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    children: [
                                      InkWell(
                                          onTap: () {
                                            providerObj.onIncrementQty(index);
                                          },
                                          child: Icon(Icons.add)),
                                      Center(
                                        child: Text(providerObj
                                            .cartList[index].qty
                                            .toString()),
                                      ),
                                      InkWell(
                                          onTap: () {
                                            providerObj.onDecrementQty(index);
                                          },
                                          child: Icon(Icons.remove))
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ));
          },
        ));
  }
}
