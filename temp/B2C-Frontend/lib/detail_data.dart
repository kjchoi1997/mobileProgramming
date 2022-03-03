import 'package:flutter/material.dart';

class detailCard {
  final String title;
  final String image;
  final String location;
  final String calorie;
  final String price;
  final String name;
  final String topping;
  final List<Color> colors;
  final String profilePicture;

  detailCard(
      {required this.title,
        required this.image,
        required this.location,
        required this.calorie,
        required this.price,
        required this.colors,
        required this.name,
        required this.topping,
        required this.profilePicture});
}

List detail =[

  detailCard(
    title: "Roast Veggies",
    image: "assets/images/plate_food/20.png",
    location: "New York",
    calorie: "255 Cal",
    price: "\$ 15.00",
    name: "Martha Wix",
    profilePicture:
    "https://images.pexels.com/photos/1382731/pexels-photo-1382731.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
    topping: "sauce, mayonnaise, cheese",
    colors: [
      Color(0xFFFEE140),
      Color(0xFFFA709A),
    ],
  ),
];