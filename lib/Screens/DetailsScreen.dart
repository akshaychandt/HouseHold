import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:household/Model/countModel.dart';
import 'package:household/Model/product.dart';
import 'package:household/Model/productModel.dart';
import 'package:household/Screens/Body.dart';
import 'package:provider/provider.dart';

import 'cart.dart';

class DetailsScreen extends StatelessWidget {
  final ProductModel product;
  const DetailsScreen({Key? key,required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF3D82AE),
      appBar: buildAppBar(context),
      body: Body(product: product));
  }
  AppBar buildAppBar(BuildContext context) {
    const kDefaultPaddin = 20.0;
    const kTextLightColor = Color(0xFFACACAC);
    return AppBar(
      backgroundColor: Color(0xFF3D82AE),
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back,color: kTextLightColor,),
        onPressed: () => Navigator.pop(context),
      ),
      actions: <Widget>[
        // GestureDetector(
        //   onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Cart())),
        //   child: Badge(
        //     badgeContent : Consumer<CountModel>(
        //         builder: (context, value, child) =>
        //         Text ( '${value.itemCount}' ,style : TextStyle ( color : Colors.white ))) ,
        //     animationDuration : Duration ( milliseconds : 300 ) ,
        //     child : Icon(Icons.shopping_cart) ,
        //   ),
        // ),
        IconButton(
            onPressed: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => Cart())),
            icon: Icon(Icons.shopping_cart)),
        SizedBox(width: 20)
      ],
    );
  }
}

