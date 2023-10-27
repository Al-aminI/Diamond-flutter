//import 'dart:js_interop';

import 'package:flutter/material.dart';
//import 'package:diamond/components/bottom_nav.dart';
//import 'package:diamond/components/drawer.dart';
//import 'package:diamond/components/event.dart';
//import 'package:diamond/pages/HomePage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
//import '../auth/login_or_register.dart';

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({super.key});

  @override
  State<AboutUsPage> createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  Future<List<Map<String, dynamic>>> getEvent() async {
    final url = Uri.parse('http://127.0.0.1:5000/get_event');
    final response = await http.get(url);
    List<Map<String, dynamic>> data =
        List<Map<String, dynamic>>.from(jsonDecode(response.body));
    //print(data);
    return data;
  }

  @override
  Widget build(BuildContext context) {
    //final response = getEvent();
    //print(response);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 56, 0, 80),
        title: const Text("About Us"),
      ),
      backgroundColor: const Color.fromARGB(255, 254, 247, 255),
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.symmetric(horizontal: 3),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Mega Diamond Miner is a Free crypto Mining app that generates new coins by running complex algorithms on our powerful platforms.',
              style: TextStyle(
                  color: Color.fromARGB(255, 52, 44, 55),
                  fontWeight: FontWeight.normal,
                  fontSize: 20,
                  fontFamily: 'Raleway'),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'We exist to connect users from all over the world and create effective wealth distribution for the low income earners arround the world.',
              style: TextStyle(
                  color: Color.fromARGB(255, 52, 44, 55),
                  fontWeight: FontWeight.normal,
                  fontSize: 20,
                  fontFamily: 'Raleway'),
            ),
            const SizedBox(
              height: 15,
            ),
            const Text(
              'Click here to read out terms and conditions.',
              style: TextStyle(
                  color: Color.fromARGB(255, 59, 147, 255),
                  fontWeight: FontWeight.normal,
                  fontSize: 20,
                  fontFamily: 'Raleway'),
            ),
            const SizedBox(
              height: 15,
            ),
            const Text(
              'Refer to our social media handles fro more information and updates.',
              style: TextStyle(
                  color: Color.fromARGB(255, 52, 44, 55),
                  fontWeight: FontWeight.normal,
                  fontSize: 20,
                  fontFamily: 'Raleway'),
            ),
            const SizedBox(
              height: 23,
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'images/facebook.png', // Replace with the actual path to your image asset.
                    width: 50, // Set the desired width.
                    height: 50, // Set the desired height.
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  Image.asset(
                    'images/instagram.jpeg', // Replace with the actual path to your image asset.
                    width: 50, // Set the desired width.
                    height: 50, // Set the desired height.
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  Image.asset(
                    'images/twitter.png', // Replace with the actual path to your image asset.
                    width: 50, // Set the desired width.
                    height: 50, // Set the desired height.
                  ),
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}
