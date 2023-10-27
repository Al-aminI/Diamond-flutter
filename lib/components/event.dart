import 'package:flutter/material.dart';
//import 'package:flutter_app/pages/HomePage.dart';
//import 'package:flutter_app/pages/scanning.dart';

//import '../pages/event.dart';

class EventCard extends StatelessWidget {
  final String name;
  final String attendees;
  final String time;
  final String created;
  final String eventId;
  final String date;
  final dynamic year;
  final dynamic month;
  final dynamic day;
  final dynamic hr;
  final dynamic mint;

  const EventCard(
      {super.key,
      required this.name,
      required this.attendees,
      required this.time,
      required this.created,
      required this.eventId,
      required this.date,
      required this.year,
      required this.month,
      required this.day,
      required this.hr,
      required this.mint});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8)),
      margin: const EdgeInsets.only(top: 25, left: 25, right: 25),
      padding: const EdgeInsets.all(25),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SingleEventPage(
                            name: name,
                            time: time,
                            created: created,
                            eventId: eventId,
                            attendees: attendees,
                            year: year,
                            month: month,
                            day: day,
                            hr: hr,
                            mint: mint,
                            date: date)),
                  );
                },
                child: Text(
                  name,
                  style: const TextStyle(decoration: TextDecoration.underline),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                attendees,
                style:
                    const TextStyle(color: Color.fromARGB(255, 201, 198, 198)),
              ),
              Text(created, style: TextStyle(color: Colors.grey[400]))
            ],
          ),
          const SizedBox(
            width: 30,
          ),
          // button

          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: Colors.grey[400]),
                child: const Icon(
                  Icons.access_time,
                  color: Colors.white,
                ),
              ),
              //const SizedBox(
              //  height: 10,
              // ),
              //Text(
              //time,
              //style: const TextStyle(
              // color: Colors.black,
              // fontWeight: FontWeight.bold,
              // fontSize: 16,
              //),
              //),
            ],
          ),
        ],
      ),
    );
  }
}
