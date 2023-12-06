import 'package:diamond/modules/diamond_data.dart';
import 'package:diamond/modules/diamond_provider.dart';
import 'package:flutter/material.dart';
import 'package:diamond/auth/login_or_register.dart';
//import 'package:diamond/pages/login_page.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../components/my_textfield.dart';
import '../components/mybutton.dart';
import 'dart:convert';
import 'package:csc_picker/csc_picker.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final contactController = TextEditingController();
  final countryController = TextEditingController();
  final stateController = TextEditingController();
  final cityController = TextEditingController();
  final genderController = TextEditingController();
  final referralController = TextEditingController();
  final addressController = TextEditingController();
  bool isLoading = false;

  signUp() async {
    //print(emailController.text);
    final Map<String, dynamic> requestData = {
      'email': emailController.text,
      'password': passwordController.text,
      'name': nameController.text,
      'contact': contactController.text,
      'gender': genderController.text,
      'country': countryController.text,
      'state': stateController.text,
      'city': cityController.text,
      'referrer': referralController.text,
      'address': addressController.text,
    };
    final url = Uri.parse('https://diamond-7n50.onrender.com/signup');
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
  void signUserUp() async {
    //if (passwordController == confirmpasswordController){
    setState(() {
      isLoading = true;
      showLoadingDialog();
      // Clear previous result
    });
    //}
    final response = await signUp();

    if (response.statusCode == 200) {
      setState(() {
        isLoading = false;
      });
      // Request was successful, you can handle the response here.
      //print('Response: ${response.body}');
      //pop menu drawer
      // Parse the JSON response
      Map<String, dynamic> data = jsonDecode(response.body);

      // Access specific values from the JSON data
      String message = data['message'];
      if (message == "success") {
        //print("message");
        final Map<String, dynamic> requestData = {'user_id': data["user_id"]};
        final url = Uri.parse('https://diamond-7n50.onrender.com/get_dia');
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
            final diaData = DiamondData(
                userId: output["user_id"],
                amount: output["amount"],
                stake: output["stake"],
                dia1: output["dia1"],
                dia2: output["dia2"],
                dia3: output["dia3"],
                dia4: output["dia4"],
                task1: output["task1"],
                task2: output["task2"],
                task3: output["task3"],
                task4: output["task4"]);
            final diamondDataProvider =
                Provider.of<DiamondDataProvider>(context, listen: false);
            diamondDataProvider.setDiamondData(diaData);
          } catch (e) {
            print("Error decoding JSON: $e");
            // Handle the error or display an error message
          }
        } else {
          print("Request failed with status: ${response.statusCode}");
          // Handle the error or display an error message based on the status code
        }
        showSuccessDialog(context);
        Navigator.pop(context);

        // then go to EventsPage
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const LoginOrRegister(
                      showLoginPage: true,
                    )));
      } else {
        showSuccessDialog(context);
        //pop menu drawer
        Navigator.pop(context);

        // then go to EventsPage
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const LoginOrRegister(
                      showLoginPage: false,
                    )));
      }
      showSuccessDialog(context);
    } else {
      showSuccessDialog(context);
      // Request failed, handle the error here.
      //print('Request failed with status: ${response.statusCode}');
      //pop menu drawer
      Navigator.pop(context);

      // then go to EventsPage
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const LoginOrRegister(
                    showLoginPage: true,
                  )));
    }
    showSuccessDialog(context);
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
          content: Text('Registered successfully!'),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 254, 247, 255),
        body: SafeArea(
            child: SingleChildScrollView(
                child: Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
              const SizedBox(height: 30),

              // logo
              /*const Icon(
                Icons.diamond,
                size: 100,
              ),*/
              Image.asset(
                'images/l1.png', // Replace with the actual path to your image asset.
                width: 100, // Set the desired width.
                height: 100, // Set the desired height.
              ),

              const SizedBox(height: 30),

              // welcome back
              Text(
                'Welcome to Diamond, create you account',
                style: TextStyle(color: Colors.grey[700]),
              ),

              const SizedBox(height: 25),

              MyTextField(
                controller: nameController,
                hintText: "Full name",
                obsecureText: false,
              ),

              const SizedBox(height: 10),

              //username textfield
              MyTextField(
                controller: emailController,
                hintText: "Email",
                obsecureText: false,
              ),

              const SizedBox(height: 10),

              MyTextField(
                controller: contactController,
                hintText: "Contact",
                obsecureText: false,
              ),

              const SizedBox(height: 10),

              MyTextField(
                controller: genderController,
                hintText: "Gender",
                obsecureText: false,
              ),

              const SizedBox(height: 10),
              // password textfield
              /*MyTextField(
                controller: countryController,
                hintText: "country",
                obsecureText: false,
              ),*/

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: CSCPicker(
                  layout: Layout.vertical,
                  flagState: CountryFlag.ENABLE,
                  onCountryChanged: (country) {
                    countryController.text = country;
                  },
                  onStateChanged: (state) {
                    stateController.text = state ?? "";
                  },
                  onCityChanged: (city) {
                    cityController.text = city ?? "";
                  },
                ),
              ),
              const SizedBox(height: 10),

              const SizedBox(height: 10),
              // password textfield
              MyTextField(
                controller: addressController,
                hintText: "Address",
                obsecureText: false,
              ),

              const SizedBox(height: 10),

              //username textfield
              MyTextField(
                controller: referralController,
                hintText: "Referral code",
                obsecureText: false,
              ),

              const SizedBox(height: 10),

              // password textfield
              MyTextField(
                controller: passwordController,
                hintText: "Password",
                obsecureText: true,
              ),

              /*const SizedBox(height: 10),

              // Confirm password textfield
              MyTextField(
                controller: confirmpasswordController,
                hintText: "Confirm password",
                obsecureText: true,
              ),*/

              const SizedBox(height: 25),

              // signin button
              MyButton(
                onTap: signUserUp,
                text: "Sign Up",
              ),

              const SizedBox(height: 50),

              // or continue with
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
                      onTap: widget.onTap,
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          "Or login",
                          style: TextStyle(
                              color: Color.fromARGB(255, 52, 140, 208)),
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
              // google + apple login buttons
            ])))));
  }
}
