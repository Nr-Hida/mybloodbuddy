import "package:flutter/material.dart";
import "package:mybb/components/my_button.dart";
import "package:mybb/components/my_timeblock.dart";

class UserConfirmAppointment extends StatefulWidget {
  const UserConfirmAppointment({super.key});

  @override
  State<StatefulWidget> createState() => _UserConfirmAppointmentState();
}

class _UserConfirmAppointmentState extends State<UserConfirmAppointment> {
  final int totalMonthsInAYear = 12;
  final _defaultDateTime = DateTime.now().toString();
  DateTime _dateTime = DateTime.now();
  // TimeOfDay _timeSlot = TimeOfDay.now();
  String _timeBlock = "No time chosen yet.";

  // show date picker method
  void _showDatePicker() {
    showDatePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
      lastDate: DateTime(DateTime.now().year + 1, (DateTime.now().month + 3) % totalMonthsInAYear, DateTime.now().day)
    ).then((value) {
      setState(() {
        _dateTime = value!;
      });
    });
  }

  // show time picker method
  // void _showTimePicker() {
  //   showTimePicker(context: context, initialTime: _timeSlot).then((value) {
  //     setState(() {
  //       _timeSlot = value!;
  //     });
  //   });
  // }

  // select time block
  void selectTimeBlock(String value) {
    setState(() {
      _timeBlock = value;
    });
  }

  String _getMonthName(int month) {
    if (month == 1) {
      return "January";
    } else if (month == 2) {
      return "February";
    } else if (month == 3) {
      return "March";
    } else if (month == 4) {
      return "April";
    } else if (month == 5) {
      return "May";
    } else if (month == 6) {
      return "June";
    } else if (month == 7) {
      return "July";
    } else if (month == 8) {
      return "August";
    } else if (month == 9) {
      return "September";
    } else if (month == 10) {
      return "October";
    } else if (month == 11) {
      return "November";
    } else {
      return "December";
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: ListView(
            children: [
              const ListTile(
                title: Text("Set Appointment"),
              ),
              ListTile(
                title: _dateTime.toString() == _defaultDateTime ? const Text("No date chosen yet.") : Text("Chosen date:\n${_dateTime.day.toString()}/${_dateTime.month.toString()}/${_dateTime.year.toString()} (${_dateTime.day.toString()} ${_getMonthName(_dateTime.month)} ${_dateTime.year.toString()})"),
              ),
              Container(
                margin: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: ListTile(
                  title: const Text("Select a date *"),
                  leading: const Icon(Icons.calendar_month),
                  onTap: _showDatePicker,
                ),
              ),
              const Text(
                "* For fairness, appointments can only be made\nup to 3 months in advanced",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12.0)
              ),
              // ListTile(
              //   title: _timeSlot == TimeOfDay.now() ? const Text("No time chosen yet.") : Text("Chosen time: ${_timeSlot.format(context).toString()}"),
              // ),
              ListTile(
                title: Text("Chosen time: $_timeBlock"),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MyTimeblock(text: "9-10 AM", onTap: () => selectTimeBlock("9-10 AM")),
                  MyTimeblock(text: "10-11 AM", onTap: () => selectTimeBlock("10-11 AM")),
                  MyTimeblock(text: "11-12 PM", onTap: () => selectTimeBlock("11-12 PM")),
                ],
              ),
              const SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MyTimeblock(text: "1-2 PM", onTap: () => selectTimeBlock("1-2 PM")),
                  MyTimeblock(text: "2-3 PM", onTap: () => selectTimeBlock("2-3 PM")),
                  MyTimeblock(text: "3-4 PM", onTap: () => selectTimeBlock("3-4 PM")),
                ],
              ),
              // Container(
              //   margin: const EdgeInsets.all(10.0),
              //   decoration: BoxDecoration(
              //     color: Colors.grey.shade400,
              //     borderRadius: BorderRadius.circular(10.0),
              //   ),
              //   child: ListTile(
              //     title: const Text("Select a time"),
              //     leading: const Icon(Icons.access_time),
              //     onTap: _showTimePicker,
              //   ),
              // ),
              const SizedBox(height: 10.0),
              MyButton(text: "Next", onTap: () {
                Navigator.pushNamed(context, "login");
              }),
            ],
          )
        )
      )
    );
  }
}