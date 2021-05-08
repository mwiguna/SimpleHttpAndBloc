import 'package:http/http.dart' as http;

// To parse this JSON data, do
//
//  final productList = productListFromJson(jsonString);

import 'dart:convert';

ProductList productListFromJson(String str) => ProductList.fromJson(json.decode(str));

String productListToJson(ProductList data) => json.encode(data.toJson());

class ProductList {
  ProductList({
    this.name,
    this.type,
    this.product,
  });

  String name;
  String type;
  List<Product> product;

  factory ProductList.fromJson(Map<String, dynamic> json) => ProductList(
    name: json["name"],
    type: json["type"],
    product: List<Product>.from(json["product"].map((x) => Product.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "type": type,
    "product": List<dynamic>.from(product.map((x) => x.toJson())),
  };
}

class Product {
  Product({
    this.title,
    this.desc,
  });

  String title;
  String desc;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    title: json["title"],
    desc: json["desc"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "desc": desc,
  };
}

// Untuk Bloc, Karena bloc tidak boleh null, tapi classKosong boleh

class ProductListKosong extends ProductList{}