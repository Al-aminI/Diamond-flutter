import 'package:flutter/material.dart';

class MyTimePicker extends StatefulWidget {
  final TimeOfDay selectedT;
  final Function(TimeOfDay) onTimeSelected;
  const MyTimePicker({
    Key? key,
    required this.onTimeSelected,
    required this.selectedT,
  }) : super(key: key);

  @override
  State createState() => _MyTimePickerState();
}

class _MyTimePickerState extends State<MyTimePicker> {
  TimeOfDay? selectedTime; // Store the selected time as TimeOfDay
  String finalTime = "";
  @override
  void initState() {
    super.initState();
    // Initialize selectedTime with the initial DateTime's time
    selectedTime = TimeOfDay.fromDateTime(DateTime.now());
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime!,
      useRootNavigator: false, // Add this line
    );

    if (pickedTime != null) {
      setState(() {
        selectedTime = pickedTime;
      });

      // Convert the selected time to 12-hour format
      final int hour = selectedTime!.hourOfPeriod;
      final String period = selectedTime!.period == DayPeriod.am ? 'AM' : 'PM';

      // Display the selected time as 12-hour format (e.g., 03:30 PM)
      final formattedTime =
          '${hour.toString().padLeft(2, '0')}:${selectedTime!.minute.toString().padLeft(2, '0')} $period';
      //print('Selected Time: $formattedTime');

      if (formattedTime != "") {
        // Call the callback function with the selected date
        widget.onTimeSelected(pickedTime);
      }
      setState(() {
        finalTime = formattedTime.toString();
      });
      // You can access the selected time using selectedTime here
      // For example, you can format it as a string and display it.
      //final formattedTime = "${selectedTime!.hour}:${selectedTime!.minute}";
      //print('Selected Time: $formattedTime');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 25),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Center(
          child: Row(
            children: [
              const Icon(Icons.timer_outlined, size: 35),
              const SizedBox(
                width: 15,
              ),
              TextButton(
                child: Text(
                  'Pick Time',
                  style: TextStyle(color: Colors.grey[500], fontSize: 16),
                ),
                onPressed: () {
                  // Show the time picker dialog
                  _selectTime(context);
                },
              ),
              const SizedBox(
                width: 20,
              ),
              Text(finalTime,
                  style: TextStyle(
                      color: Colors.grey[700],
                      fontWeight: FontWeight.bold,
                      fontSize: 16))
            ],
          ),
        ),
      ),
    );
  }
}
