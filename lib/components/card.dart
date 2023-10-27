import 'package:flutter/material.dart';

class MyCard extends StatelessWidget {
  final Function()? onTap;
  final String text;

  const MyCard({super.key, required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(15),
          margin: const EdgeInsets.symmetric(horizontal: 3),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 56, 0, 80),
            borderRadius: BorderRadius.circular(8),
          ),
          width: 150,
          height: 100,
          child: Center(
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ));
  }
}
