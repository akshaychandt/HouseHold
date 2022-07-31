import 'package:flutter/material.dart';
class ProductModel {
  String? id;
  String? userId;
  String? productId;
  String? productName;
  String? image;
  String? price;
  String? description;
  String? status;
  String? count;

  ProductModel(
      {
        this.id,
        this.userId,
        this.productId,
        this.productName,
        this.image,
        this.price,
        this.description,
        this.status,
        this.count
      });

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    productId = json['product_id'];
    productName = json['product_name'];
    image = json['image'];
    price = json['price'];
    description = json['description'];
    status = json['status'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['product_id'] = this.productId;
    data['product_name'] = this.productName;
    data['image'] = this.image;
    data['price'] = this.price;
    data['description'] = this.description;
    data['status'] = this.status;
    data['count'] = this.count;
    return data;
  }
}
