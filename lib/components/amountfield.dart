import 'package:flutter/material.dart';

class MyAmountField extends StatefulWidget {
  final controller;
  final String amount;
  final String hintText;
  final bool obsecureText;

  const MyAmountField({
    super.key,
    required this.amount,
    required this.controller,
    required this.hintText,
    required this.obsecureText,
  });

  @override
  State<MyAmountField> createState() => _MyAmountFieldState();
}

class _MyAmountFieldState extends State<MyAmountField> {
  String _inputValue = '';

  void _setInputValue() {
    setState(() {
      _inputValue = widget.amount; // Set the new value
      widget.controller.text = _inputValue;
      // Update the text field with the new value
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
          controller: widget.controller,
          obscureText: widget.obsecureText,
          decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color.fromARGB(255, 245, 227, 255)),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color.fromARGB(255, 245, 227, 255)),
            ),
            fillColor: const Color.fromARGB(255, 249, 239, 254),
            filled: true,
            hintText: widget.hintText,
            hintStyle: TextStyle(color: Colors.grey[500]),
            suffixIcon: IconButton(
                //color: const Color.fromARGB(255, 56, 0, 80),
                icon: const Text('max',
                    style: TextStyle(color: Color.fromARGB(255, 56, 0, 80))),
                onPressed:
                    // Handle the "max" button click action here
                    _setInputValue),
          )),
    );
  }
}
