import 'package:diamond/pages/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:diamond/components/my_time_picker.dart';
//import 'package:diamond/auth/login_or_register.dart';
//import 'package:diamond/pages/events.dart';
//import 'package:diamond/pages/login_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
//import '../components/drawer.dart';
import '../components/my_date_picker.dart';
import '../components/my_event_button.dart';
import '../components/my_textfield.dart';
//import 'HomePage.dart';
//import 'event.dart';
//import '../components/mybutton.dart';

class CreatEventPage extends StatefulWidget {
  final String name;
  const CreatEventPage({super.key, required this.name});

  @override
  State<CreatEventPage> createState() => _CreatEventPageState();
}

class _CreatEventPageState extends State<CreatEventPage> {
  final emailController = TextEditingController();
  // final dateController = TextEditingController();
  //final timeController = TextEditingController();
  final attendeespasswordController = TextEditingController();
  String finalDate = "";
  TimeOfDay mytime = TimeOfDay.now();
  DateTime mydate = DateTime.now();

  createEvent() async {
    // Convert the selected time to 12-hour format
    final int hour = mytime.hourOfPeriod;
    final String period = mytime.period == DayPeriod.am ? 'AM' : 'PM';

    // Display the selected time as 12-hour format (e.g., 03:30 PM)
    final formattedTime =
        '${hour.toString().padLeft(2, '0')}:${mytime.minute.toString().padLeft(2, '0')} $period';
    //print('Selected Time: $formattedTime');
    //print(mydate);
    final Map<String, dynamic> requestData = {
      'owner_email': emailController.text,
      'time': formattedTime,
      'date': mydate.toString(),
      'name': widget.name,
      'attendees': attendeespasswordController.text
    };
    final url = Uri.parse('http://127.0.0.1:5000/create_event');
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
  void goToEventsPage() async {
    //if (passwordController == confirmpasswordController){

    //}
    //print("here");
    final response = await createEvent();
    // print(response.statusCode);
    if (response.statusCode == 200) {
      // Request was successful, you can handle the response here.
      //print('Response: ${response.body}');
      Map<String, dynamic> data = jsonDecode(response.body);

      // Access specific values from the JSON data
      String message = data['message'];
      //print(message);
      if (message == "success") {
        //pop menu drawer
        Navigator.pop(context);

        // then go to EventsPage
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const HomePage()));
      } else {
        Navigator.pop(context);
      }
    } else {
      // Request failed, handle the error here.
      //print('Request failed with status: ${response.statusCode}');
      //pop menu drawer
      Navigator.pop(context);
    }
  }

  void backToHome() {
    Navigator.pop(context);
  }

  void handleDateSelected(DateTime selectedDate) {
    setState(() {
      mydate = selectedDate;
    });
  }

  void handleTimeSelected(TimeOfDay selectedTime) {
    setState(() {
      mytime = selectedTime;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        body: SingleChildScrollView(
            child: SafeArea(
                child: Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
              const SizedBox(height: 50),

              // logo
              const Icon(
                Icons.access_time_filled_rounded,
                size: 150,
              ),

              const SizedBox(height: 25),

              // welcome back
              const Text(
                'Great!!!',
                style: TextStyle(
                    color: Color.fromARGB(255, 55, 44, 44),
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: 'Raleway'),
              ),

              const SizedBox(height: 10),
              // welcome back
              Text(
                'Your are these steps away from creating your event.',
                style: TextStyle(color: Colors.grey[700]),
              ),

              const SizedBox(height: 25),

              //username textfield
              MyTextField(
                controller: emailController,
                hintText: "event owner email",
                obsecureText: false,
              ),

              const SizedBox(height: 10),

              // password textfield
              MyTextField(
                controller: attendeespasswordController,
                hintText: "number of attendees",
                obsecureText: false,
              ),

              const SizedBox(height: 10),

              MyDatePicker(
                selected: mydate,
                onDateSelected: handleDateSelected,
              ),
              const SizedBox(height: 10),

              MyTimePicker(
                selectedT: mytime,
                onTimeSelected: handleTimeSelected,
              ),

              const SizedBox(height: 25),

              // signin button
              MyEventButton(
                onTap: goToEventsPage,
                text: "Create",
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
                      onTap: backToHome,
                      child: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: 35,
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
              ),

              // google + apple login buttons
            ])))));
  }
}
