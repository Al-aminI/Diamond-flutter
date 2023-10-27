import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:diamond/modules/diamond_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyTasks extends StatefulWidget {
  //final Function()? onTap;
  final String userId;

  const MyTasks({super.key, required this.userId});
  @override
  State<MyTasks> createState() => _MyTasksState();
}

class _MyTasksState extends State<MyTasks> {
  //, required this.onTap, required this.text});
  void addDiamond(diaAmount, userId, diaIndex) async {
    //print(emailController.text);
    final Map<String, dynamic> requestData = {
      'amount': diaAmount,
      'user_id': userId,
      'dia': diaIndex
    };
    final url = Uri.parse('http://127.0.0.1:5000/add_diamond');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json', // Set the content type to JSON
      },
      body: jsonEncode(requestData), // Encode your data as JSON
    );
    //print(response.statusCode);
    if (response.statusCode == 200) {
      // Request was successful, you can handle the response here.
      //print('Response: ${response.body}');
      Map<String, dynamic> data = jsonDecode(response.body);

      // Access specific values from the JSON data
      String message = data['message'];

      if (message == "success") {
        final Map<String, dynamic> requestData = {'user_id': widget.userId};
        final url = Uri.parse('http://127.0.0.1:5000/get_diamonds');
        final response = await http.post(
          url,
          headers: {
            'Content-Type': 'application/json', // Set the content type to JSON
          },
          body: jsonEncode(requestData), // Encode your data as JSON
        );

        if (response.statusCode == 200) {
          final responseBody = response.body;
          //print(jsonDecode(responseBody)['me']);
          try {
            final output = jsonDecode(responseBody);
            final diamondProvider =
                Provider.of<DiamondDataProvider>(context, listen: false);
            diamondProvider.diamondData?.amount = output["amount"];
          } catch (e) {
            print("Error decoding JSON: $e");
            // Handle the error or display an error message
          }
        } else {
          print("Request failed with status: ${response.statusCode}");
          // Handle the error or display an error message based on the status code
        }
      }
    }
  }

  void toggleVisibility1() {
    addDiamond("2", widget.userId, "5");
    setState(() {
      final diamondProvider =
          Provider.of<DiamondDataProvider>(context, listen: false);
      diamondProvider.diamondData?.task1 = false;
    });

    Timer(const Duration(seconds: 10), () {
      setState(() {
        final diamondProvider =
            Provider.of<DiamondDataProvider>(context, listen: false);
        diamondProvider.diamondData?.task1 = true;
        //widget.dia1 = true;
      });
    });
  }

  void toggleVisibility2() {
    addDiamond("2", widget.userId, "6");
    setState(() {
      final diamondProvider =
          Provider.of<DiamondDataProvider>(context, listen: false);
      diamondProvider.diamondData?.task2 = false;
    });

    Timer(const Duration(seconds: 10), () {
      setState(() {
        final diamondProvider =
            Provider.of<DiamondDataProvider>(context, listen: false);
        diamondProvider.diamondData?.task2 = true;
        //widget.dia1 = true;
      });
    });
  }

  void toggleVisibility3() {
    addDiamond("2", widget.userId, "7");
    setState(() {
      final diamondProvider =
          Provider.of<DiamondDataProvider>(context, listen: false);
      diamondProvider.diamondData?.task3 = false;
    });

    Timer(const Duration(seconds: 10), () {
      setState(() {
        final diamondProvider =
            Provider.of<DiamondDataProvider>(context, listen: false);
        diamondProvider.diamondData?.task3 = true;
        //widget.dia1 = true;
      });
    });
  }

  void toggleVisibility4() {
    addDiamond("2", widget.userId, "8");
    setState(() {
      final diamondProvider =
          Provider.of<DiamondDataProvider>(context, listen: false);
      diamondProvider.diamondData?.task4 = false;
    });

    Timer(const Duration(seconds: 10), () {
      setState(() {
        final diamondProvider =
            Provider.of<DiamondDataProvider>(context, listen: false);
        diamondProvider.diamondData?.task4 = true;
        //widget.dia1 = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final diaProvider = Provider.of<DiamondDataProvider>(context);
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.symmetric(horizontal: 3),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: GestureDetector(
              onTap: toggleVisibility1,
              child: Container(
                padding: const EdgeInsets.all(15),
                margin: const EdgeInsets.symmetric(horizontal: 3),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.circular(8),
                ),
                //width: 125,
                //height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          'images/l1.png', // Replace with the actual path to your image asset.
                          width: 25, // Set the desired width.
                          height: 25, // Set the desired height.
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        const Text(
                          "1   Task ",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                          textAlign: TextAlign.start,
                        ),
                        //const SizedBox(
                        // width: 20,
                        //),
                      ],
                    ),
                    Visibility(
                      visible: diaProvider.diamondData!.task1,
                      child: const Icon(
                        Icons.check_box_rounded,
                        size: 24,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Center(
            child: GestureDetector(
              onTap: toggleVisibility2,
              child: Container(
                padding: const EdgeInsets.all(15),
                margin: const EdgeInsets.symmetric(horizontal: 3),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.circular(8),
                ),
                //width: 125,
                //height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          'images/l1.png', // Replace with the actual path to your image asset.
                          width: 25, // Set the desired width.
                          height: 25, // Set the desired height.
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        const Text(
                          "2   Task ",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                          textAlign: TextAlign.start,
                        ),
                        //const SizedBox(
                        // width: 20,
                        //),
                      ],
                    ),
                    Visibility(
                      visible: diaProvider.diamondData!.task2,
                      child: const Icon(
                        Icons.check_box_rounded,
                        size: 24,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Center(
            child: GestureDetector(
              onTap: toggleVisibility3,
              child: Container(
                padding: const EdgeInsets.all(15),
                margin: const EdgeInsets.symmetric(horizontal: 3),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.circular(8),
                ),
                //width: 125,
                //height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          'images/l1.png', // Replace with the actual path to your image asset.
                          width: 25, // Set the desired width.
                          height: 25, // Set the desired height.
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        const Text(
                          "3   Task ",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                          textAlign: TextAlign.start,
                        ),
                        //const SizedBox(
                        // width: 20,
                        //),
                      ],
                    ),
                    Visibility(
                      visible: diaProvider.diamondData!.task3,
                      child: const Icon(
                        Icons.check_box_rounded,
                        size: 24,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Center(
            child: GestureDetector(
              onTap: toggleVisibility4,
              child: Container(
                padding: const EdgeInsets.all(15),
                margin: const EdgeInsets.symmetric(horizontal: 3),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.circular(8),
                ),
                //width: 125,
                //height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          'images/l1.png', // Replace with the actual path to your image asset.
                          width: 25, // Set the desired width.
                          height: 25, // Set the desired height.
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        const Text(
                          "4   Task ",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                          textAlign: TextAlign.start,
                        ),
                        //const SizedBox(
                        // width: 20,
                        //),
                      ],
                    ),
                    Visibility(
                      visible: diaProvider.diamondData!.task4,
                      child: const Icon(
                        Icons.check_box_rounded,
                        size: 24,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
