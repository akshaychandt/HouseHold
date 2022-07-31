import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:household/Constant.dart';
import 'package:household/Loader/ColorLoader.dart';
import 'package:household/Model/productModel.dart';
import 'package:household/Screens/DetailsScreen.dart';
import 'package:household/Screens/cart.dart';
import 'package:household/Screens/ordersItemCard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({Key? key}) : super(key: key);
  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  Future<dynamic> _getOrders() async {
    var sharedprfs = await SharedPreferences.getInstance();
    var _user_id = sharedprfs.getString('id');
    var data = await http
        .post(Uri.parse("${BASE_URL}view_orders.php"),
    body: {
          "id":_user_id
        });
    List jsonData = jsonDecode(data.body);
    print("inside function $jsonData");
    List<ProductModel> products =
    jsonData.map<ProductModel>((json) => ProductModel.fromJson(json)).toList();
    print(jsonData.first['product_name']);
    // print(' before returning $products');
    return products;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(context),
      body: buildBody(context),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: Text('Orders'),
      actions: [
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {},
        ),
        IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () =>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Cart()))
        ),

      ],
    );
  }

  SafeArea buildBody(BuildContext context){
    return SafeArea(
      child: FutureBuilder(
        future: _getOrders(),
        builder: (BuildContext context,
             snapshot){
          print('inside builder ${snapshot.data}');
          if (snapshot.connectionState==ConnectionState.waiting) {
            return Center(child: ColorLoader());
          } else if(!snapshot.hasData){
            return Center(child: Text('no data ${snapshot.data}'),);
          }else{
    print("inside builder wiget part ${snapshot.data}");

            return Column(
              children: [
                SizedBox(height: 20,),
            Expanded(
            child: GridView.builder(
            itemCount: (snapshot.data as List).length,
                gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2), // SliverGridDelegateWithFixedCrossAxisCount
                itemBuilder: (BuildContext context, int index){
                  // Product product = products[index];
                  return OrdersItemCard(
                    product:(snapshot.data as List).elementAt(index),
                    press: () =>Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailsScreen(product:(snapshot.data as List).elementAt(index)),
                      ),
                    ),
                  );
                }),
          )
              ],
            );
          }
        },
      ),
    );
  }
}
