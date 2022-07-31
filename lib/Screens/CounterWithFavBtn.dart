import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:household/Constant.dart';
import 'package:household/Model/product.dart';
import 'package:household/Model/productModel.dart';
import 'package:household/views/CartCounter.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CounterWithFavBtn  extends StatefulWidget {
  final ProductModel product;
  const CounterWithFavBtn({
    Key? key,  required this.product,
  }) : super(key: key);

  @override
  State<CounterWithFavBtn> createState() => _CounterWithFavBtnState();
}

class _CounterWithFavBtnState extends State<CounterWithFavBtn> {
  bool fav = false;
  @override
  Widget build(BuildContext context) {

    final Icon favicon;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        CartCounter(),
        Container(
          padding: EdgeInsets.all(6),
          height: 50,
          width: 32,
          // decoration: BoxDecoration(
          //   color: Color(0xFFFF6464),
          //   shape: BoxShape.circle,
          // ),
          child: IconButton(
            icon: Icon(fav!=false? Icons.favorite : Icons.favorite_outline,
              color: Colors.red,),
            onPressed: () => fav_click()
          ),
        )
      ],
    );
  }
  fav_click() async{
    final sharedprfs = await SharedPreferences.getInstance();
              final _user_id = sharedprfs.getString('id');
              final _product_id = widget.product.productId;
              setState(() {
                fav = !fav;
              });
              if(fav!=false){
                var data = await http.post(Uri.parse('${BASE_URL}add_to_fav.php'),
                body: {
                  "user_id" : _user_id,
                  "product_id" : _product_id
                });
                var jsonData = jsonDecode(data.body);
                if(jsonData['message']== 'true'){
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    behavior: SnackBarBehavior.floating,
                    margin: EdgeInsets.only(bottom: 315,left: 20,right: 20) ,
                    content: Text("Item added To Wishlist",style: TextStyle(color: Colors.greenAccent),)));
              }}
              else{
                var data = await http.post(Uri.parse('${BASE_URL}remove_from_fav.php'),
                body: {
                  "user_id" : _user_id,
                  "product_id" : _product_id
                });
                var jsonData = jsonDecode(data.body);
                if(jsonData['message'] == 'true'){
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    behavior: SnackBarBehavior.floating,
                    margin: EdgeInsets.only(bottom: 315,left: 20,right: 20) ,
                    content: Text("Item removed from wishlist",style: TextStyle(color: Colors.greenAccent),)));
                }
              }
  }
}