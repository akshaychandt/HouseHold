import 'package:flutter/material.dart';
import 'package:household/Constant.dart';
import 'package:household/Model/product.dart';
import 'package:household/Model/productModel.dart';

class Description extends StatelessWidget {
  const Description({
    Key? key,
    required this.product,
  }) : super(key: key);

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin),
      child: Text(
        product.description.toString(),
        style: TextStyle(height: 1.5),
      ),
    );
  }
}
