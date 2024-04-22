// ignore_for_file: prefer_const_constructors, annotate_overrides

import 'package:fakestore_api/controller/home_screen_controller.dart';
import 'package:fakestore_api/global_widget/loading_indicatet.dart';
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
      body: homeScreenState.isLoading
          ? Center(child: ReusableLoadingIndicator())
          : ListView.builder(
              itemBuilder: (context, index) => Container(
                    child: ListTile(
                      leading: Image.network(
                          homeScreenState.productsList[index].image ?? ""),
                      title: Text(
                          homeScreenState.productsList[index].title.toString()),
                      // subtitle: Text(homeScreenState.productsList[index].description.toString()),
                      subtitle: Text(
                          homeScreenState.productsList[index].price.toString()),
                      trailing: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.shopping_cart_checkout_sharp),
                      ),
                    ),
                  )),
    );
  }
}
