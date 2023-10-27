import 'package:flutter/material.dart';
//import 'package:flutter_app/pages/HomePage.dart';
//import 'package:flutter_app/pages/scanning.dart';

//import '../pages/event.dart';

class HistoryCard extends StatelessWidget {
  final String address;
  final String amount;
  final String created;

  const HistoryCard({
    super.key,
    required this.address,
    required this.amount,
    required this.created,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8)),
      margin: const EdgeInsets.only(top: 25, left: 25, right: 25),
      padding: const EdgeInsets.all(25),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {},
                child: Text(
                  address,
                  style: const TextStyle(decoration: TextDecoration.underline),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                amount,
                style:
                    const TextStyle(color: Color.fromARGB(255, 201, 198, 198)),
              ),
              Text(created, style: TextStyle(color: Colors.grey[400]))
            ],
          ),
          const SizedBox(
            width: 30,
          ),
          // button
        ],
      ),
    );
  }
}
