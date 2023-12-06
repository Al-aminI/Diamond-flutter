import 'package:diamond/components/amountfield.dart';
import 'package:diamond/modules/diamond_provider.dart';
import 'package:diamond/pages/stake_history.dart';
import 'package:flutter/material.dart';
import 'package:diamond/components/mybutton.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:provider/provider.dart';

class StakingPage extends StatefulWidget {
  final String userId;

  const StakingPage(
      {super.key, required this.userId}); //, required this.onTap});

  @override
  State<StakingPage> createState() => _StakingPageState();
}

class _StakingPageState extends State<StakingPage> {
  // text controllers
  final stakeController = TextEditingController();
  String stake = "0.0";

  stakeIn() async {
    //print(emailController.text);
    final Map<String, dynamic> requestData = {
      'amount': stakeController.text,
      'user_id': widget.userId
    };
    final url = Uri.parse('https://diamond-7n50.onrender.com/add_stake');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json', // Set the content type to JSON
      },
      body: jsonEncode(requestData), // Encode your data as JSON
    );

    return response;
  }

  // sing user Up method
  void addStake() async {
    //if (passwordController == confirmpasswordController){

    //}
    final response = await stakeIn();
    //print(response.statusCode);
    if (response.statusCode == 200) {
      // Request was successful, you can handle the response here.
      //print('Response: ${response.body}');
      Map<String, dynamic> data = jsonDecode(response.body);

      // Access specific values from the JSON data
      String message = data['message'];
      //print(message);
      if (message == "success") {
        showSuccessDialog(context);
        final Map<String, dynamic> requestData = {'user_id': widget.userId};
        final url = Uri.parse('https://diamond-7n50.onrender.com/get_diamonds');
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
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        final Map<String, dynamic> stakeRequestData = {
          'user_id': widget.userId
        };
        final stakeUrl =
            Uri.parse('https://diamond-7n50.onrender.com/get_stake');
        final stakeResponse = await http.post(
          stakeUrl,
          headers: {
            'Content-Type': 'application/json', // Set the content type to JSON
          },
          body: jsonEncode(stakeRequestData), // Encode your data as JSON
        );

        if (stakeResponse.statusCode == 200) {
          final stakeResponseBody = stakeResponse.body;
          //print(jsonDecode(responseBody)['me']);
          try {
            final stakeOutput = jsonDecode(stakeResponseBody);
            final diamondProvider =
                Provider.of<DiamondDataProvider>(context, listen: false);
            diamondProvider.diamondData?.stake = stakeOutput["amount"];
          } catch (e) {
            print("Error decoding JSON: $e");
            // Handle the error or display an error message
          }
        } else {
          print("Request failed with status: ${stakeResponse.statusCode}");
          // Handle the error or display an error message based on the status code
        }
        setState(() {
          stakeController.clear();
        });
      }
    }
  }

  showLoadingDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  void showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        Future.delayed(const Duration(seconds: 7), () {
          Navigator.of(context)
              .pop(); // Close the success dialog after 3 seconds
        });

        return const AlertDialog(
          title: Text('Success'),
          content: Text('stake added successful!'),
        );
      },
    );
  }

  void goToStakeHistoryPage() {
    //pop menu drawer
    //Navigator.pop(context);

    // then go to EventsPage
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => StakeHistoryPage(
                  userId: widget.userId,
                )));
  }

  @override
  Widget build(BuildContext context) {
    final diaProvider = Provider.of<DiamondDataProvider>(context);
    return Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      const SizedBox(height: 30),

      // logo
      const Icon(
        Icons.attach_money,
        size: 100,
      ),

      const SizedBox(height: 30),

      // welcome back
      Text(
        'Total Stake: ${diaProvider.diamondData?.stake} Diamonds',
        style: TextStyle(color: Colors.grey[700], fontWeight: FontWeight.bold),
      ),

      const SizedBox(height: 20),
      Text(
        'Available Diamond (Non Staked): ${diaProvider.diamondData?.amount} Diamonds',
        style: TextStyle(color: Colors.grey[700]),
      ),
      const SizedBox(height: 20),
      MyAmountField(
        amount: '${diaProvider.diamondData?.amount}',
        controller: stakeController,
        hintText: "Add to Stake",
        obsecureText: false,
      ),

      const SizedBox(height: 25),

      // signin button
      MyButton(
        onTap: addStake,
        text: "Stake",
      ),

      const SizedBox(height: 70),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Row(
          children: [
            Expanded(
              child: Divider(
                thickness: 0.5,
                color: Colors.grey[400],
              ),
            ),
            GestureDetector(
              onTap: goToStakeHistoryPage,
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  "stakes History",
                  style: TextStyle(color: Color.fromARGB(255, 52, 140, 208)),
                ),
              ),
            ),
            Expanded(
              child: Divider(
                thickness: 0.5,
                color: Colors.grey[400],
              ),
            )
          ],
        ),
      )
    ]));
  }
}
