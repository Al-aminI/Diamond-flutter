import 'package:flutter/material.dart';
import 'package:diamond/pages/login_page.dart';
import 'package:diamond/pages/register_page.dart';

class LoginOrRegister extends StatefulWidget {
  final bool showLoginPage;
  const LoginOrRegister({super.key, required this.showLoginPage});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  // initialize the login page
  bool showLoginPage = true;

  // toggle between login and register page
  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(onTap: togglePages);
    } else {
      return RegisterPage(onTap: togglePages);
    }
  }
}
