import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:household/Constant.dart';
import 'package:household/Model/countModel.dart';
import 'package:household/Model/product.dart';
import 'package:household/Model/productModel.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddToCart  extends StatelessWidget {
  final ProductModel product;
  const AddToCart({
    Key? key,
    required this.product,
  }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin),
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: kDefaultPaddin),
            height: 50,
            width: 58,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: Color(0xFF3D82AE),
              ),
            ),
            child: Consumer<CountModel>(
              builder: (context, value, child) =>
              IconButton(
                icon: Icon(Icons.shopping_cart,
                  color: Color(0xFF3D82AE),),
                onPressed: () async {
                  final sharedprfs = await SharedPreferences.getInstance();
                  final _user_id = sharedprfs.getString("id");
                  final _product_id = product.productId;
                  var data = await http.post(
                      Uri.parse("${BASE_URL}add_to_cart.php"),
                      body: {
                        "product_id": _product_id,
                        "user_id"   : _user_id
                      });
                  var jsonData = jsonDecode(data.body);
                  if(jsonData['message']== 'true'){
                    value.cartItemCountIncrement();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      behavior: SnackBarBehavior.floating,
                      margin: EdgeInsets.only(bottom: 315,left: 20,right: 20) ,
                      content: Text("Item added to cart",style: TextStyle(color: Colors.greenAccent),)));
                  }
                  else{
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        behavior: SnackBarBehavior.floating,
                        margin: EdgeInsets.only(bottom: 315,left: 20,right: 20) ,
                        content: Text("Item already in cart",style: TextStyle(color: Colors.deepOrangeAccent),)));
                  }
                },
              ),
            ),
          ),
          Expanded(
            child: SizedBox(
              height: 50,
              child: ElevatedButton(style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)),
                backgroundColor: Color(0xFF3D82AE),
              ),
                onPressed: () {},
                child: Text(
                  "Buy  Now".toUpperCase(),
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
