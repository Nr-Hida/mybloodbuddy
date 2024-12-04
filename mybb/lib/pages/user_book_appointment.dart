import "package:flutter/material.dart";

class UserBookAppointment extends StatefulWidget {
  const UserBookAppointment({super.key});

  @override
  State<StatefulWidget> createState() => _UserBookAppointmentState();
}

class _UserBookAppointmentState extends State<UserBookAppointment> {

  final tod = TimeOfDay.now();

  // show date picker method
  void _showDatePicker() {
    showDatePicker(context: context, firstDate: DateTime(2024), lastDate: DateTime(2025));
  }

  // show time picker method
  void _showTimePicker() {
    showTimePicker(context: context, initialTime: tod);
  }
  
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Set Appointment"),
        const Text("Select a date:"),
        MaterialButton(
          onPressed: _showDatePicker,
          child: const Text("Choose A Date"),
        ),
        const Text("Select a time:"),
        MaterialButton(
          onPressed: _showTimePicker,
          child: const Text("Choose A Date"),
        )
      ],
    );
  }
}