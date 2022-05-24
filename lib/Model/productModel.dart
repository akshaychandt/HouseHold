import 'package:flutter/material.dart';
import 'package:household/views/color_and_size.dart';
class ProductModel {
  String? productId;
  String? productName;
  String? image;
  String? price;
  String? description;
  Color? color;

  ProductModel(
      {this.productId,
        this.productName,
        this.image,
        this.price,
        this.description,
        this.color});

  ProductModel.fromJson(Map<String, dynamic> json,Color color) {
    productId = json['product_id'];
    productName = json['product_name'];
    image = json['image'];
    price = json['price'];
    description = json['description'];
    color = color;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['product_name'] = this.productName;
    data['image'] = this.image;
    data['price'] = this.price;
    data['description'] = this.description;
    data['color'] = this.color;
    return data;
  }
}
