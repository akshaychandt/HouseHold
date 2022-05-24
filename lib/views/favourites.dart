import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:household/Constant.dart';
import 'package:household/Loader/ColorLoader.dart';
import 'package:household/Model/productModel.dart';
import 'package:household/views/Body.dart';
import 'package:household/views/DetailsScreen.dart';
import 'package:household/views/ItemCard.dart';
import 'package:http/http.dart' as http;
import 'package:household/views/cart.dart';

class Favourites extends StatefulWidget {
  const Favourites({Key? key}) : super(key: key);

  @override
  State<Favourites> createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  Future<List<ProductModel>> _getFavProduct() async {
    var data = await http
        .get(Uri.parse("${BASE_URL}view_favourite.php"));
    List jsonData = jsonDecode(data.body);
    List<Color> colors = [Color(0xFF3D82AE),Color(0xFFD3A984),Color(0xFF989493)];
    int item = 0;
    List<ProductModel> products =
    jsonData.map<ProductModel>((json) => ProductModel.fromJson(json,item!=colors.last?colors[item++]: colors[item=0])).toList();
    print(jsonData.first['product_name']);
    return products;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: buildBody(context),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: Text('House Hold'),
      centerTitle: true,
      actions: [
        IconButton(
          icon: Icon(Icons.search,color: kTextLightColor,),
          onPressed: () {},
        ),
        IconButton(
            icon: Icon(Icons.shopping_cart,
              color: kTextLightColor,),
            onPressed: () =>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Cart()))
        ),

      ],
    );
  }

  SafeArea buildBody(BuildContext context){
    return SafeArea(
      child: FutureBuilder(
        future: _getFavProduct(),
        builder: (BuildContext context,
            AsyncSnapshot<List<ProductModel>> snapshot){
          if (!snapshot.hasData) {
            return Center(child: ColorLoader());
          } else {
            return GridView.builder(
                itemCount: snapshot.data?.length,
                gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2), // SliverGridDelegateWithFixedCrossAxisCount
                itemBuilder: (BuildContext context, int index){
                  // Product product = products[index];
                  return ItemCard(
                    product:snapshot.data!.elementAt(index),
                    press: () =>Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailsScreen(product:snapshot.data!.elementAt(index)),
                      ),
                    ),
                  );
                });
          }
        },
      ),
    );
  }
}
