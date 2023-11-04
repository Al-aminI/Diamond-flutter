import 'package:flutter/material.dart';
//import 'package:flutter_app/pages/HomePage.dart';
//import 'package:flutter_app/pages/scanning.dart';

//import '../pages/event.dart';

class TeamCard extends StatelessWidget {
  final String name;
  final String joined;

  const TeamCard({
    super.key,
    required this.name,
    required this.joined,
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
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    name,
                    style:
                        const TextStyle(decoration: TextDecoration.underline),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "",
                  style: TextStyle(color: Color.fromARGB(255, 201, 198, 198)),
                ),
                Text(joined, style: TextStyle(color: Colors.grey[400]))
              ],
            ),
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
