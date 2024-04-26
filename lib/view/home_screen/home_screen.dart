// ignore_for_file: prefer_const_constructors, annotate_overrides, prefer_const_literals_to_create_immutables

import 'package:fakestore_api/controller/cart_screen_controller.dart';
import 'package:fakestore_api/controller/home_screen_controller.dart';
import 'package:fakestore_api/global_widget/reusable_loading_indicator.dart';
import 'package:fakestore_api/view/cart_screen/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //function for api call
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Provider.of<HomeScreenController>(context, listen: false)
          .getProvider();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final homeScreenState = context.watch<HomeScreenController>();
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Provider.of<HomeScreenController>(context, listen: false)
      //         .getProvider();
      //   },
      // ),
      appBar: AppBar(
          // actions: [
          //   IconButton(
          //       onPressed: () {
          //         Navigator.push(
          //             context,
          //             MaterialPageRoute(
          //               builder: (context) => CartScreen(),
          //             ));
          //       },
          //       icon: Icon(Icons.shopping_cart))
          // ],
          ),

      // drawder
      drawer: Drawer(
        child: Column(
          children: [
            // about profile

            DrawerHeader(
                child: UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.green,
              ),
              accountName: Text("Alan"),
              accountEmail: Text("alsp@gmail.com"),
            )),

            // Cart Screen Navigator
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CartScreen(),
                    ));
              },
              child: ListTile(
                leading: Icon(Icons.shopping_cart),
                title: Text("Cart"),
                trailing: Icon(Icons.arrow_right),
              ),
            ),
          ],
        ),
      ),

      //body

      body: homeScreenState.isLoading
          ? Center(child: ReusableLoadingIndicator())
          : Padding(
              padding: const EdgeInsets.only(
                  top: 10, bottom: 10, right: 10, left: 10),

              //showing the items we use listview.builder
              child: ListView.builder(
                  itemCount: homeScreenState.productsList.length,
                  itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Container(
                          height: 100,
                          width: double.infinity,
                          child: ListTile(
                            //showing image
                            leading: Image.network(
                                width: 40,
                                height: 60,
                                fit: BoxFit.fill,
                                homeScreenState.productsList[index].image ??
                                    ""),

                            //showing title
                            title: Text(homeScreenState
                                .productsList[index].title
                                .toString()),

                            //showing price
                            subtitle: Text(
                              homeScreenState.productsList[index].price
                                  .toString(),
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green),
                            ),

                            //cart icon to add product to cart
                            trailing: IconButton(
                              onPressed: () {
                                Provider.of<CartScreenController>(context,
                                        listen: false)
                                    .addToCart(
                                        homeScreenState.productsList[index],
                                        context);
                              },
                              icon: Icon(Icons.shopping_cart_checkout_sharp),
                            ),
                          ),
                        ),
                      )),
            ),
    );
  }
}
