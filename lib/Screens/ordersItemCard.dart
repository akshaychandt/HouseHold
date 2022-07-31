import 'package:flutter/material.dart';
import 'package:household/Constant.dart';
import 'package:household/Model/productModel.dart';
class OrdersItemCard extends StatelessWidget {


  final ProductModel product;
  final Function() press;
  const OrdersItemCard({
    Key? key,
    required this.product,
    required this.press,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:press,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.all(kDefaultPaddin),
              // For  demo we use fixed height  and width
              // Now we dont need them
              height: 180,
              width: 160,
              decoration: BoxDecoration(
                color: Color(0xFF3D82AE),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Hero(
                    tag: "${product.productId}",
                    child: Image.network("${ASSET_URL}${product.image.toString()}",height: 70),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin / 4),
                    child: Text(
                      // products is out demo list
                      product.productName.toString(),
                      style: TextStyle(color: kTextLightColor),
                    ),
                  ),
                  Text(
                    "\₹${product.price}",
                    style: TextStyle(fontWeight: FontWeight.w500,color: Colors.white),
                  ),
                  Text(
                    "Status :${product.status}",
                    style: TextStyle(fontWeight: FontWeight.w400,color: Colors.white,fontSize: 12),
                  ),
                  Text(
                    "Quantity :${product.count}",
                    style: TextStyle(fontWeight: FontWeight.w400,color: Colors.white),
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 20,)
        ],
      ),
    );
  }
}
