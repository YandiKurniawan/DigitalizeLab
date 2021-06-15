import 'package:flutter/material.dart';

class Product {
  final String image, title, description;
  final int price, size, id;
  final Color color;
  Product({
    this.id,
    this.image,
    this.title,
    this.price,
    this.description,
    this.size,
    this.color,
  });
}

List<Product> products = [
  // Product(
  //     id: 1,
  //     title: "Digital",
  //     price: 234,
  //     size: 12,
  //     description: dummyText1,
  //     image: "assets/images/analog10.jpg",
  //     color: Color(0xFF3D82AE)),
  // Product(
  //     id: 2,
  //     title: "Produksi",
  //     price: 234,
  //     size: 8,
  //     description: dummyText2,
  //     image: "assets/images/mikro3.jpg",
  //     color: Color(0xFF3D82AE)),
  // Product(
  //     id: 3,
  //     title: "M & R",
  //     price: 234,
  //     size: 10,
  //     description: dummyText3,
  //     image: "assets/images/analog3.jpg",
  //     color: Color(0xFF989493)),
  // Product(
  //     id: 4,
  //     title: "Mekatronika",
  //     price: 234,
  //     size: 8,
  //     description: dummyText4,
  //     image: "assets/images/analog2.jpg",
  //     color: Color(0xFFE6B398)),
  Product(
      id: 6,
      title: "Analog",
      price: 234,
      size: 7,
      description: dummyText6,
      image: "assets/images/analog1.jpg",
      color: Color(0xFFAEAEAE)),
  Product(
      id: 5,
      title: "Mikrokontroller",
      price: 234,
      size: 7,
      description: dummyText5,
      image: "assets/images/mikro5.jpg",
      color: Color(0xFFFB7883)),
];

String dummyText1 = "yandi kurniawna lorem ipsum aksnakdnkandas";
String dummyText2 = "yandi kurniawna lorem ipsum aksnakdnkandas";
String dummyText3 = "yandi kurniawna lorem ipsum aksnakdnkandas";
String dummyText4 = "yandi kurniawna lorem ipsum aksnakdnkandas";
String dummyText5 = "yandi kurniawna lorem ipsum aksnakdnkandas";
String dummyText6 = "yandi kurniawna lorem ipsum aksnakdnkandas";
