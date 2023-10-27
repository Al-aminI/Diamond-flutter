import 'package:flutter/material.dart';

class MyDatePicker extends StatefulWidget {
  final DateTime selected;
  final Function(DateTime) onDateSelected;
  const MyDatePicker({
    Key? key,
    required this.onDateSelected,
    required this.selected,
  }) : super(key: key);

  @override
  State createState() => _MyDatePickerState();
}

class _MyDatePickerState extends State<MyDatePicker> {
  DateTime? selectedDate; // Store the selected time as TimeOfDay
  String finalDate = "";

  @override
  void initState() {
    super.initState();
    // Initialize selectedTime with the initial DateTime's time
    selectedDate = DateTime.now();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      initialDate: selectedDate!,
      useRootNavigator: false,
      // Add this line
    );

    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
      });

      // Convert the selected Date to 12-hour format
      final int day = selectedDate!.day;
      final int month = selectedDate!.month;
      final int year = selectedDate!.year;

      // Display the selected time as 12-hour format (e.g., 03:30 PM)
      final formattedDate =
          '${day.toString().padLeft(2, '0')} - ${month.toString().padLeft(2, '0')} - $year';
      //print('Selected Time: $formattedTime');
      if (formattedDate != "") {
        // Call the callback function with the selected date
        widget.onDateSelected(pickedDate);
      }
      setState(() {
        finalDate = formattedDate.toString();
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
              const Icon(Icons.date_range, size: 35),
              const SizedBox(
                width: 15,
              ),
              TextButton(
                child: Text(
                  'Pick Date',
                  style: TextStyle(color: Colors.grey[500], fontSize: 16),
                ),
                onPressed: () {
                  // Show the time picker dialog
                  _selectDate(context);
                },
              ),
              const SizedBox(
                width: 20,
              ),
              Text(finalDate,
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
