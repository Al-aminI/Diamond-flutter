import 'package:diamond/components/chatarea.dart';
import 'package:diamond/components/my_textfield.dart';
import 'package:flutter/material.dart';
//import 'package:diamond/components/my_textfield.dart';
import 'package:diamond/components/mybutton.dart';
//import 'package:diamond/pages/HomePage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ChatPage extends StatefulWidget {
  final String userId;
  const ChatPage({super.key, required this.userId}); //, required this.onTap});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  // text controllers
  final subjectController = TextEditingController();
  final messageController = TextEditingController();

  chatIn() async {
    //print(emailController.text);
    final Map<String, dynamic> requestData = {
      'subject': subjectController.text,
      'message': messageController.text,
      'user_id': widget.userId
    };
    final url = Uri.parse('http://127.0.0.1:5000/add_chat');
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
  void userChat() async {
    //if (passwordController == confirmpasswordController){

    //}
    final response = await chatIn();
    //print(response.statusCode);
    if (response.statusCode == 200) {
      // Request was successful, you can handle the response here.
      //print('Response: ${response.body}');
      Map<String, dynamic> data = jsonDecode(response.body);

      // Access specific values from the JSON data
      String message = data['message'];
      //print(message);
      if (message == "success") {
        //pop menu drawer
      }
    } else {
      // Request failed, handle the error here.
    }
    setState(() {
      subjectController.clear();
      messageController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 56, 0, 80),
          title: const Text("Live Chat"),
        ),
        backgroundColor: const Color.fromARGB(255, 254, 247, 255),
        body: SafeArea(
            child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
              const SizedBox(height: 50),

              // logo
              const Icon(
                Icons.chat_rounded,
                size: 100,
                color: Color.fromARGB(255, 56, 0, 80),
              ),

              const SizedBox(height: 50),

              // welcome back
              Text(
                'Contact our Support Team',
                style: TextStyle(color: Colors.grey[700]),
              ),

              const SizedBox(height: 25),
              //subject textfield
              MyTextField(
                controller: subjectController,
                hintText: "Subject",
                obsecureText: false,
              ),
              const SizedBox(height: 10),
              //email textfield
              MyTextArea(
                controller: messageController,
                hintText: "message",
                obsecureText: false,
              ),

              const SizedBox(height: 25),

              // signin button
              MyButton(
                onTap: userChat,
                text: "Send",
              ),

              const SizedBox(height: 50),
            ]))));
  }
}
