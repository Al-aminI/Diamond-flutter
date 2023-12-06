import 'package:diamond/modules/user_data.dart';
import 'package:diamond/modules/user_data_provider.dart';
import 'package:diamond/pages/notifs.dart';
import 'package:flutter/material.dart';
import 'package:diamond/components/my_textfield.dart';
import 'package:diamond/components/mybutton.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:image_picker/image_picker.dart';

import 'dart:io';

import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  final String userId;
  const ProfilePage({super.key, required this.userId});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  XFile? image;

  final ImagePicker picker = ImagePicker();

  //we can upload image from camera or from gallery based on parameter
  Future getImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);

    setState(() {
      image = img;
    });
    if (image != null) {
      // Handle the picked image, e.g., save it to your app or display it.
    }
  }

  // text controllers
  final countryController = TextEditingController();
  final genderController = TextEditingController();
  final addressController = TextEditingController();
  bool isLoading = false;
  String userId = "";
  String countryHint = "";
  String genderHint = "";
  String addressHint = "";

  updateIn() async {
    final url = Uri.parse('https://diamond-7n50.onrender.com/edit_user');
    final request = http.MultipartRequest('POST', url);

    // Add the image file to the request
    if (image != null) {
      final imageFile = await http.MultipartFile.fromPath('image', image!.path);
      request.files.add(imageFile);
    }

    if (countryController.text == "") {
      request.fields['country'] = countryHint;
    } else {
      request.fields['country'] = countryController.text;
    }
    if (genderController.text == "") {
      request.fields['gender'] = genderHint;
    } else {
      request.fields['gender'] = genderController.text;
    }
    if (addressController.text == "") {
      request.fields['address'] = addressHint;
    } else {
      request.fields['address'] = addressController.text;
    }

    request.fields['user_id'] = userId;

    // Send the request
    final response = await request.send();

    return response;
  }

  // sing user Up method
  void updateUser() async {
    setState(() {
      isLoading = true;
      showLoadingDialog();
      // Clear previous result
    });
    final response = await updateIn();
    //print(response.statusCode);
    if (response.statusCode == 200) {
      final responseBody = await response.stream.bytesToString();

      // Request was successful, you can handle the response here.
      //print('Response: ${responseBody}');
      Map<String, dynamic> data = jsonDecode(responseBody);

      // Access specific values from the JSON data
      String message = data['message'];
      //print(message);
      if (message == "success") {
        //fetchAndSetUserData(data["userId"]);

        final Map<String, dynamic> requestData = {'user_id': userId};
        final url = Uri.parse('https://diamond-7n50.onrender.com/me');
        final response = await http.post(
          url,
          headers: {
            'Content-Type': 'application/json', // Set the content type to JSON
          },
          body: jsonEncode(requestData), // Encode your data as JSON
        );
        //print(response.statusCode);
        if (response.statusCode == 200) {
          final responseBody = response.body;
          //print(jsonDecode(responseBody));

          try {
            final decodedRes = jsonDecode(responseBody);
            final meData = decodedRes['me'];

            final userData = UserData(
                username: meData["name"],
                email: meData["email"],
                contact: meData["contact"],
                country: meData["country"],
                address: meData["address"],
                gender: meData["gender"],
                image: meData["image"],
                referralCode: meData["referral_code"],
                userId: meData["user_id"]);

            final userProvider =
                Provider.of<UserDataProvider>(context, listen: false);
            userProvider.setUserData(userData);
            showTextDialog(context);

            // Update the data
          } catch (e) {
            errshowTextDialog(context);
            print("Error decoding JSON: $e");
            // Handle the error or display an error message
          }
        } else {
          errshowTextDialog(context);
          //print("Request failed with status: ${response.statusCode}");
          // Handle the error or display an error message based on the status code
        }
      } else {
        errshowTextDialog(context);
      }
    } else {
      // Request failed, handle the error here.
      //print('Request failed with status: ${response.statusCode}');
      //pop menu drawer
      errshowTextDialog(context);
    }
  }

  // Function to display the dialog
  void showTextDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Update Status'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("profile updated successifully"),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.pop(context);

                  // then go to EventsPage
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProfilePage(
                                userId: widget.userId,
                              ))); // Close the dialog
                },
                child: const Text('Close'),
              ),
            ],
          );
        });
  }

  // Function to display the dialog
  void errshowTextDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Update Status'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Oops, please try again"),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.pop(context);

                  // then go to EventsPage
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProfilePage(
                                userId: widget.userId,
                              ))); // Close the dialog
                },
                child: const Text('Close'),
              ),
            ],
          );
        });
  }

  showLoadingDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  // notification page method
  // sing user in method
  void notif() {
    //Navigator.pop(context);
    // then go to EventsPage

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => NotifPage(userId: widget.userId)));
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserDataProvider>(context);
    setState(() {
      userId = '${userProvider.userData?.userId}';
      countryHint = '${userProvider.userData?.country}';
      addressHint = '${userProvider.userData?.address}';
      genderHint = '${userProvider.userData?.gender}';
    });

    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 56, 0, 80),
          title: const Text(
            "Profile",
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.notifications,
                color: Color.fromARGB(255, 255, 255, 255),
              ), // Replace 'your_icon' with the desired icon, e.g., Icons.search
              onPressed: notif,
            ),
          ],
        ),
        /*drawer: MyDrawer(
          onHomeTap: goToHomePage,
          onLogoutTap: goToLoginPage,
          onProfileTap: goToProfilePage,
          onAboutUsTap: goToAboutUsPage,
          onTeamTap: goToTeamPage,
        ),*/
        backgroundColor: const Color.fromARGB(255, 254, 247, 255),
        body: SafeArea(
            child: SingleChildScrollView(
                child: Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
              const SizedBox(height: 25),

              // logo
              /*const Icon(
                Icons.diamond,
                size: 100,
              ),*/
              if (image != null)
                Image.file(
                  File(image!.path),
                  width: 120,
                  height: 120,
                )
              else
                const Icon(Icons.image, size: 120),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment
                      .center, // Center the content horizontally.
                  children: [
                    IconButton(
                      icon: const Icon(Icons.photo_library),
                      onPressed: () {
                        getImage(ImageSource.gallery);
                      },
                      tooltip: 'From Gallery',
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    IconButton(
                      icon: const Icon(Icons.camera),
                      onPressed: () {
                        getImage(ImageSource.camera);
                      },
                      tooltip: 'From Camera',
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // welcome back
              Text(
                'Your Profile',
                style: TextStyle(
                    color: Colors.grey[700], fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 15),

              Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(15),
                      margin: const EdgeInsets.symmetric(horizontal: 25),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 249, 239, 254),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Text(
                            ' ${userProvider.userData?.username}',
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontWeight: FontWeight.normal,
                              fontSize: 15,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.all(15),
                      margin: const EdgeInsets.symmetric(horizontal: 25),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 249, 239, 254),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Text(
                            " '${userProvider.userData?.email}'",
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontWeight: FontWeight.normal,
                              fontSize: 15,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.all(15),
                      margin: const EdgeInsets.symmetric(horizontal: 25),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 249, 239, 254),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Text(
                            ' ${userProvider.userData?.contact}',
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontWeight: FontWeight.normal,
                              fontSize: 15,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ],
                      ),
                    ),
                  ]),
              const SizedBox(height: 10),

              // password textfield
              MyTextField(
                controller: countryController,
                hintText: '${userProvider.userData?.country}',
                obsecureText: false,
              ),

              const SizedBox(height: 10),

// password textfield
              MyTextField(
                controller: addressController,
                hintText: '${userProvider.userData?.address}',
                obsecureText: false,
              ),

              const SizedBox(height: 10),

              /*email textfield
              MyTextField(
                controller: daController,
                hintText: "Date of Birth",
                obsecureText: false,
              ),*/

              const SizedBox(height: 10),

              // password textfield
              MyTextField(
                controller: genderController,
                hintText: '${userProvider.userData?.gender}',
                obsecureText: false,
              ),

              const SizedBox(height: 25),

              // signin button
              MyButton(
                onTap: updateUser,
                //signUserIn,
                text: "Update",
              ),

              const SizedBox(height: 50),

              // or continue with
              /*Padding(
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
              )*/
              // google + apple login buttons
            ])))));
  }
}
