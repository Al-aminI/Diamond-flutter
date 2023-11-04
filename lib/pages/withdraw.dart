import 'package:diamond/components/amountfield.dart';
import 'package:diamond/modules/diamond_provider.dart';
import 'package:flutter/material.dart';
import 'package:diamond/components/my_textfield.dart';
import 'package:diamond/components/mybutton.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WithdrawalPage extends StatefulWidget {
  final String userId;
  const WithdrawalPage(
      {super.key, required this.userId}); //, required this.onTap});

  @override
  State<WithdrawalPage> createState() => _WithdrawalPageState();
}

class _WithdrawalPageState extends State<WithdrawalPage> {
  // text controllers
  final amountController = TextEditingController();
  final addressController = TextEditingController();

  withdrawIn() async {
    //print(emailController.text);
    final Map<String, dynamic> requestData = {
      'amount': amountController.text,
      'address': addressController.text,
      'user_id': widget.userId
    };
    final url = Uri.parse('http://127.0.0.1:5000/add_withdrawals');
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
  void withdraw() async {
    final response = await withdrawIn();
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

      setState(() {
        addressController.clear();
        amountController.clear();
      });
    }
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
          content: Text('Withdrawal request sent successfully!'),
        );
      },
    );
  }

  showLoadingDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final diaProvider = Provider.of<DiamondDataProvider>(context);
    String? amount = diaProvider.diamondData
        ?.amount; // Use a default value if diaProvider.diamondData?.amount is null
    double result = double.parse(amount ?? '0.0') * 0.0246;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 56, 0, 80),
          title: const Text("Withdraw"),
        ),
        backgroundColor: const Color.fromARGB(255, 254, 247, 255),
        body: SafeArea(
            child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
              const SizedBox(height: 30),

              // logo
              const Icon(
                Icons.attach_money,
                size: 100,
              ),

              const SizedBox(height: 30),

              // welcome back
              Text(
                'Available TRX: ${(result)} TRX',
                style: TextStyle(color: Colors.grey[700]),
              ),

              const SizedBox(height: 20),

              MyAmountField(
                amount: '${diaProvider.diamondData?.amount}',
                controller: amountController,
                hintText: "Amount in TRX",
                obsecureText: false,
              ),

              const SizedBox(height: 10),

              // password textfield
              MyTextField(
                controller: addressController,
                hintText: "Trx Address: Tron (TRC20) only",
                obsecureText: true,
              ),

              const SizedBox(height: 10),

              const SizedBox(height: 25),

              // signin button
              MyButton(
                onTap: withdraw,
                text: "withdraw",
              ),

              const SizedBox(height: 30),
              Container(
                padding: const EdgeInsets.all(5),
                margin: const EdgeInsets.symmetric(horizontal: 5),
                child: const Column(children: [
                  Row(
                    children: [
                      Text(
                        'Note.',
                        style: TextStyle(
                            color: Color.fromARGB(255, 52, 44, 55),
                            fontWeight: FontWeight.normal,
                            fontSize: 25,
                            fontFamily: 'Raleway'),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 23,
                  ),
                  Row(
                    children: [
                      Text(
                        '1. Only input Tron (TRC20) Wallet Address.',
                        style: TextStyle(
                            color: Color.fromARGB(255, 52, 44, 55),
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            fontFamily: 'Raleway'),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        '2. No Withdrawal charges for weekly withdrawals.',
                        style: TextStyle(
                            color: Color.fromARGB(255, 52, 44, 55),
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            fontFamily: 'Raleway'),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        '3. Minimum withdrawal is 10 TRX.',
                        style: TextStyle(
                            color: Color.fromARGB(255, 52, 44, 55),
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            fontFamily: 'Raleway'),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        '4. withdrawal is once per week (any day of the week).',
                        style: TextStyle(
                            color: Color.fromARGB(255, 52, 44, 55),
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            fontFamily: 'Raleway'),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        '5. First withdrawal is after 20 days of Registration.',
                        style: TextStyle(
                            color: Color.fromARGB(255, 52, 44, 55),
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            fontFamily: 'Raleway'),
                      ),
                    ],
                  ),
                ]),
              ),
            ]))));
  }
}
