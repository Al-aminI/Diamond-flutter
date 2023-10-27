import 'package:flutter/material.dart';

class MyTextArea extends StatelessWidget {
  final controller;
  final String hintText;
  final bool obsecureText;

  const MyTextArea({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obsecureText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        maxLines: 5,
        controller: controller,
        obscureText: obsecureText,
        decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color.fromARGB(255, 245, 227, 255)),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color.fromARGB(255, 245, 227, 255)),
            ),
            fillColor: const Color.fromARGB(255, 249, 239, 254),
            filled: true,
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey[500])),
      ),
    );
  }
}
