import 'package:flutter/material.dart';
import 'package:household/Constant.dart';
import 'package:household/Model/product.dart';
import 'package:household/Model/productModel.dart';

class ProductTitleWithImage  extends StatelessWidget {
  const ProductTitleWithImage({
    Key? key,
    required this.product,
  }) : super(key: key);

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "LED Bulbs",
            style: TextStyle(color: Colors.white),
          ),
          Text(
            product.productName.toString(),
            style: Theme.of(context)
                .textTheme
                .headline4
                ?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: kDefaultPaddin),
          Row(
            children: <Widget>[
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(text: "Price\n"),
                    TextSpan(
                      text: "\₹${product.price}",
                      style: Theme.of(context).textTheme.headline4?.copyWith(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SizedBox(width: kDefaultPaddin),
              Expanded(
                child: Hero(
                  tag: "${product.productId}",
                  child: Image.network(
                    "${ASSET_URL}${product.image.toString()}",height: 300,width: 300,
                    fit: BoxFit.fitHeight,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}