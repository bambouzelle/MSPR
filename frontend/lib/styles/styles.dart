import 'package:flutter/material.dart';

//colors
const primaryColor = Color(0XFF97be79);
const secondaryColor = Color(0XFF5b8f3b);
const buttonColor = Color(0XFF9f6152);

elevatedButtonStyle() {
  return ElevatedButton.styleFrom(
    textStyle: const TextStyle(fontSize: 20, color: Colors.white),
    backgroundColor: secondaryColor,
    minimumSize: const Size(250, 50),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(50),
    ),
  );
}

appBar(title) {
  return AppBar(
    toolbarHeight: 80,
    centerTitle: true,
    title: Text(title),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(30),
      ),
    ),
    backgroundColor: secondaryColor,
  );
}
