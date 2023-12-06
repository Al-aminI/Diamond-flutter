//import 'dart:js_interop';

import 'package:diamond/components/historycard.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HistoryPage extends StatefulWidget {
  final String userId;
  const HistoryPage({super.key, required this.userId});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  Future<List<Map<String, dynamic>>> getHistory() async {
    final Map<String, dynamic> requestData = {'user_id': widget.userId};

    final url = Uri.parse('https://diamond-7n50.onrender.com/get_withdrawals');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json', // Set the content type to JSON
      },
      body: jsonEncode(requestData),
    );
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
          title: const Text(
            "Withdrawal History",
            style: TextStyle(color: Colors.white),
          ),
        ),
        //drawer: MyDrawer(
        //onEventsTap: goToEventPage,
        //onHomeTap: goToHomePage,
        //onLogoutTap: goToLoginPage,
        //),
        backgroundColor: const Color.fromARGB(255, 254, 247, 255),
        body: FutureBuilder<List<Map<String, dynamic>>>(
            future: getHistory(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // While waiting for data, you can show a loading indicator.
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                // If there's an error, you can show an error message.
                return Text('Error: ${snapshot.error}');
              } else {
                // If data is available, you can build your UI based on it.
                final response = snapshot.data;
                //print(response);

                // Here, you can return a ListView or any other widget
                // that displays your data.
                return ListView.builder(
                  itemCount: response!.length,
                  itemBuilder: (context, index) {
                    return HistoryCard(
                      address: response[index]['address'],
                      amount: response[index]['amount'],
                      created: response[index]['created'],
                    );
                  },
                );
              }
            }));
  }
}
