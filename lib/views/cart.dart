import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:household/Constant.dart';
import 'package:household/Loader/ColorLoader.dart';
import 'package:household/Model/product.dart';
import 'package:household/Model/productModel.dart';
import 'package:household/views/Body.dart';
import 'package:http/http.dart' as http;
import 'package:household/views/DetailsScreen.dart';
import 'package:household/views/cartitemcard.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  Future<List<ProductModel>> _getProduct() async {
    final sharedprfs = await SharedPreferences.getInstance();
    var _id = sharedprfs.getString('id');
    var data = await http.post(Uri.parse("${BASE_URL}view_cart.php"),
    body: {
          "id" : _id,
    }

    );
    List jsonData = jsonDecode(data.body);
    List<Color> colors = [Color(0xFF3D82AE),Color(0xFFD3A984),Color(0xFF989493)];
    int item = 0;
    List<ProductModel> products =
    jsonData.map<ProductModel>((json) => ProductModel.fromJson(json,colors.elementAt(item++))).toList();
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
    const kTextLightColor = Color(0xFFACACAC);
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back,color: kTextLightColor,),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }
  SafeArea buildBody(BuildContext context) {
    return SafeArea(
      child: FutureBuilder(
        future: _getProduct(),
        builder: (BuildContext context,
            AsyncSnapshot<List<ProductModel>> snapshot){
          if (!snapshot.hasData) {
            return Center(child: ColorLoader());
          } else {
            return GridView.builder(
                itemCount: snapshot.data?.length,
                gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1), // SliverGridDelegateWithFixedCrossAxisCount
                itemBuilder: (BuildContext context, int index){
                  // Product product = products[index];
                  return GestureDetector(
      onTap: (){},
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(kDefaultPaddin),
            // For  demo we use fixed height  and width
            // Now we dont need them
            height: 180,
            width: 400,
            decoration: BoxDecoration(
              color: Color(0xFF3D82AE),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Hero(
              tag: "${snapshot.data![index].productId}",
              child: Image.network("${ASSET_URL}${snapshot.data![index].image.toString()}"),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                // products is out demo list
                snapshot.data![index].productName.toString(),
                style: TextStyle(color: kTextLightColor),
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                "\₹${snapshot.data![index].price}",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Column(
            children: [
              Container(
                color: Colors.black12,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton.icon(
                      icon: Icon(Icons.delete_forever),
                      onPressed: () async {
                        final _product_id = snapshot.data![index].productId;
                        var data = await http.post(
                            Uri.parse("${BASE_URL}remove_cart.php"),
                            body: {
                              "id": _product_id,
                            });
                        setState(() {
                          _getProduct();
                        });
                      },
                      label: Text('Remove'),
                    ),
                    TextButton.icon(
                      icon: Icon(Icons.shopping_bag),
                      onPressed: () {},
                      label: Text('Buy This Now',
                          style: TextStyle(color: Colors.redAccent)),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
                });
          }
        },
      ),
    );
  }
}