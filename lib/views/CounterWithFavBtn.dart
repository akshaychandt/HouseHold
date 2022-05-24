import 'package:flutter/material.dart';
import 'package:household/Constant.dart';
import 'package:household/Model/productModel.dart';
import 'package:household/views/CartCounter.dart';
import 'package:http/http.dart' as http;

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
            onPressed: () {
              setState(() {
                fav = !fav;
                // if(fav=='false'){
                //   var id = products.productId;
                // }
              });
            },
          ),
        )
      ],
    );
  }
}