//import 'package:diamond/modules/api_service.dart';
import 'package:diamond/modules/diamond_data.dart';
import 'package:diamond/modules/diamond_provider.dart';
import 'package:diamond/modules/notification_data.dart';
import 'package:diamond/modules/notificationsprovider.dart';
import 'package:diamond/modules/user_data.dart';
import 'package:diamond/modules/user_data_provider.dart';
import 'package:diamond/pages/bannerAd.dart';
import 'package:flutter/material.dart';
import 'package:diamond/components/my_textfield.dart';
import 'package:diamond/components/mybutton.dart';
import 'package:diamond/pages/HomePage.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import '../auth/login_or_register.dart';
//import '../auth/login_or_register.dart';
import 'dart:io';

import '../modules/admob_helper.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // text controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;

//   signIn() async {
//     //print(emailController.text);
//     final Map<String, dynamic> requestData = {
//       'email': emailController.text,
//       'password': passwordController.text,
//     };
//     final url = Uri.parse('http://127.0.0.1:5000/login');
//     final response = await http.post(
//       url,
//       headers: {
//         'Content-Type': 'application/json', // Set the content type to JSON
//       },
//       body: jsonEncode(requestData), // Encode your data as JSON
//     );

//     return response;
//   }

//   // sing user Up method
//   void signUserIn() async {
//     setState(() {
//       isLoading = true;
//       showLoadingDialog();
//       // Clear previous result
//     });
//     final response = await signIn();
//     //print(response.statusCode);
//     if (response.statusCode == 200) {
//       // Request was successful, you can handle the response here.

//       Map<String, dynamic> data = jsonDecode(response.body);

//       // Access specific values from the JSON data
//       String message = data['message'];

//       if (message == "success") {
//         //fetchAndSetUserData(data["userId"]);

// //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//         ///
//         final Map<String, dynamic> requestData = {'user_id': data["user_id"]};
//         final url = Uri.parse('http://127.0.0.1:5000/me');
//         final response = await http.post(
//           url,
//           headers: {
//             'Content-Type': 'application/json', // Set the content type to JSON
//           },
//           body: jsonEncode(requestData), // Encode your data as JSON
//         );

//         if (response.statusCode == 200) {
//           final responseBody = response.body;
//           //print(jsonDecode(responseBody)['me']);
//           try {
//             final decodedRes = jsonDecode(responseBody);
//             final meData = decodedRes['me'];

//             final userData = UserData(
//                 username: meData["name"],
//                 email: meData["email"],
//                 contact: meData["contact"],
//                 country: meData["country"],
//                 address: meData["address"],
//                 gender: meData["gender"],
//                 image: meData["image"],
//                 referralCode: meData["referral_code"],
//                 userId: meData["user_id"]);

//             final userProvider =
//                 Provider.of<UserDataProvider>(context, listen: false);
//             userProvider.setUserData(userData); // Update the data
//           } catch (e) {
//             print("Error decoding JSON: $e");
//             // Handle the error or display an error message
//           }
//         } else {
//           print("Request failed with status: ${response.statusCode}");
//           // Handle the error or display an error message based on the status code
//         }

// //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//         final Map<String, dynamic> requestDia = {'user_id': data["user_id"]};
//         final urlDia = Uri.parse('http://127.0.0.1:5000/get_dia');
//         final responseDia = await http.post(
//           urlDia,
//           headers: {
//             'Content-Type': 'application/json', // Set the content type to JSON
//           },
//           body: jsonEncode(requestDia), // Encode your data as JSON
//         );

//         if (responseDia.statusCode == 200) {
//           final responseDiaBody = responseDia.body;
//           //print(jsonDecode(responseBody)['me']);
//           try {
//             final decodedDiaRes = jsonDecode(responseDiaBody);
//             final diaData = decodedDiaRes;

//             final diamondData = DiamondData(
//               dia1: diaData["dia1"],
//               dia2: diaData["dia2"],
//               dia3: diaData["dia3"],
//               dia4: diaData["dia4"],
//               task1: diaData["task1"],
//               task2: diaData["task2"],
//               task3: diaData["task3"],
//               task4: diaData["task4"],
//               userId: data["user_id"],
//               amount: diaData["amount"],
//               stake: diaData["stake"],
//             );

//             final diamondProvider =
//                 Provider.of<DiamondDataProvider>(context, listen: false);
//             diamondProvider.setDiamondData(diamondData);
//           } catch (e) {
//             print("Error decoding JSON: $e");
//             // Handle the error or display an error message
//           }
//         } else {
//           print("Request failed with status: ${response.statusCode}");
//           // Handle the error or display an error message based on the status code
//         }

// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//         final Map<String, dynamic> requestNotif = {'user_id': data["user_id"]};
//         final urlNotif = Uri.parse('http://127.0.0.1:5000/get_notif');
//         final responseNotif = await http.post(
//           urlNotif,
//           headers: {
//             'Content-Type': 'application/json', // Set the content type to JSON
//           },
//           body: jsonEncode(requestNotif), // Encode your data as JSON
//         );

//         if (responseNotif.statusCode == 200) {
//           final responseNotifBody = responseNotif.body;
//           //print(jsonDecode(responseBody)['me']);
//           try {
//             final decodedNotifRes = jsonDecode(responseNotifBody);
//             final notifDatadecode = decodedNotifRes;

//             final notifData = NotificationData(
//               message: notifDatadecode["message"],
//               created: notifDatadecode["created"],
//               userId: data["user_id"],
//             );

//             final notificationProvider =
//                 Provider.of<NotificationDataProvider>(context, listen: false);
//             notificationProvider.setNotificationData(notifData);
//           } catch (e) {
//             print("Error decoding JSON: $e");
//             // Handle the error or display an error message
//           }
//         } else {
//           print("Request failed with status: ${response.statusCode}");
//           // Handle the error or display an error message based on the status code
//         }

// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//         //pop menu drawer
//         Navigator.pop(context);

//         // then go to EventsPage
//         Navigator.push(
//             context,
//             MaterialPageRoute(
//                 builder: (context) => HomePage(
//                       userId: data["user_id"],
//                     )));
//       } else {
//         Navigator.pop(context);

//         // then go to EventsPage
//         Navigator.push(
//             context,
//             MaterialPageRoute(
//                 builder: (context) => const LoginOrRegister(
//                       showLoginPage: true,
//                     )));
//       }
//     } else {
//       // Request failed, handle the error here.
//       //print('Request failed with status: ${response.statusCode}');
//       //pop menu drawer
//       Navigator.pop(context);

//       // then go to EventsPage
//       Navigator.push(
//           context,
//           MaterialPageRoute(
//               builder: (context) => const LoginOrRegister(
//                     showLoginPage: true,
//                   )));
//     }
//   }

  showLoadingDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  BannerAd? _bannerAd;
  @override
  void initState() {
    super.initState();
    _createBannerAd();
  }

  void _createBannerAd() {
    _bannerAd = BannerAd(
      size: AdSize.banner,
      adUnitId:
          'ca-app-pub-3940256099942544/6300978111', //AdMobService.bannerAdUnitId,
      listener: AdMobService.bannerAdListener,
      request: const AdRequest(),
    )..load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 254, 247, 255),
      body: SafeArea(
        /*child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.pink, Colors.purple],
                  ),
                ),*/
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),

                Image.asset(
                  'images/l1.png', // Replace with the actual path to your image asset.
                  width: 100, // Set the desired width.
                  height: 100, // Set the desired height.
                ),

                const SizedBox(height: 50),

                // welcome back
                Text(
                  'Welcome back to Diamond',
                  style: TextStyle(color: Colors.grey[700]),
                ),

                const SizedBox(height: 25),

                //email textfield
                MyTextField(
                  controller: emailController,
                  hintText: "email",
                  obsecureText: false,
                ),

                const SizedBox(height: 10),

                // password textfield
                MyTextField(
                  controller: passwordController,
                  hintText: "password",
                  obsecureText: true,
                ),

                const SizedBox(height: 10),

                // forgot password text
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "forgot password?",
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 25),

                // signin button
                MyButton(
                  onTap: () {}, //signUserIn,
                  text: "Sign In",
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
                            "Or register",
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
                ),
                const SizedBox(
                  height: 10,
                ),
                const BannerAdComponent(),
                _bannerAd == null
                    ? Container()
                    : Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        height: 52,
                        child: AdWidget(ad: _bannerAd!)),
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: isAdLoaded
                //       ? SizedBox(
                //           height: bannerAd!.size.height.toDouble(),
                //           width: bannerAd!.size.height.toDouble(),
                //           ,
                //         )
                //       : const SizedBox(),
                // )
                // google + apple login buttons
              ],
            ),
          ),
        ),
      ),
    );
  }
}
