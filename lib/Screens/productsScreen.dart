import 'dart:convert';

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:household/Constant.dart';
import 'package:household/Loader/ColorLoader.dart';
import 'package:household/Model/countModel.dart';
import 'package:household/Screens/DetailsScreen.dart';
import 'package:household/Screens/ItemCard.dart';
import 'package:household/Screens/cart.dart';
import 'package:provider/provider.dart';

import '../Model/productModel.dart';
import 'package:http/http.dart' as http;

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  Future<List<ProductModel>> _getProduct() async {
    var data = await http.get(Uri.parse("${BASE_URL}view_product.php"));
    List jsonData = jsonDecode(data.body);
    List<ProductModel> products = jsonData.map<ProductModel>((json) => ProductModel.fromJson(json)).toList();
    return products;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text('Products'),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: <Widget>[
          // IconButton(
          //   icon: Icon(Icons.search,color: kTextLightColor,),
          //   onPressed: () {},
          // ),
          IconButton(
              onPressed: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Cart())),
              icon: Icon(Icons.shopping_cart)),
          SizedBox(width: 20)
        ],
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: _getProduct(),
          builder:
              (BuildContext context, AsyncSnapshot<List<ProductModel>> snapshot) {
            if (!snapshot.hasData) {
              return Center(child: ColorLoader());
            } else {
              return Column(
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Row(
                    children: [
                      SizedBox(width: 25,),
                    Text("LED Bulbs",textAlign: TextAlign.left,style: TextStyle(
                        fontWeight: FontWeight.bold
                      ),),
                    ],
                  ),
                  Expanded(
                    child: GridView.builder(
                        itemCount: snapshot.data?.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount:
                            2), // SliverGridDelegateWithFixedCrossAxisCount
                        itemBuilder: (BuildContext context, int index) {
                          return ItemCard(
                            product: snapshot.data!.elementAt(index),
                            press: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailsScreen(
                                    product: snapshot.data!.elementAt(index)),
                              ),
                            ),
                          ); // Single_prod
                        }),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
