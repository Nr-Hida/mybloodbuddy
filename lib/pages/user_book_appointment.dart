// import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";
import "package:mybb/components/my_button.dart";
import "package:mybb/components/my_timeblock.dart";
import "package:mybb/utils/appointment.dart";

class UserBookAppointment extends StatelessWidget {
  final String chosenHospital;
  final GestureTapCallback selectHospitalDialog;
  final Future<int> appCount;
  final DateTime chosenDateTime;
  final GestureTapCallback showDatePicker;
  final String chosenTimeslot;
  final Function(String) selectTimeslot;
  final String fullName;
  final String bloodType;
  final String icNumber;
  final double weight;
  final double height;
  
  bool hasUserChosenTheDate() {
    return chosenDateTime.year != 2020;
  }

  bool hasUserChosenTheHospital() {
    return chosenHospital != "No hospital chosen yet.";
  }
  
  const UserBookAppointment({
    super.key,
    required this.chosenHospital,
    required this.selectHospitalDialog,
    required this.appCount,
    required this.chosenDateTime,
    required this.showDatePicker,
    required this.chosenTimeslot,
    required this.selectTimeslot,
    required this.fullName,
    required this.bloodType,
    required this.icNumber,
    required this.weight,
    required this.height,
  });
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: ListView(
            children: [
              const ListTile(
                title: Text("Set Appointment", style: TextStyle(
                  fontWeight: FontWeight.w900
                )),
                leading: Icon(Icons.calendar_month)
              ),
              ListTile(
                title: chosenHospital == ""
                ?
                const Text("No hospital chosen yet.")
                :
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Chosen hospital:"),
                    Row(
                      children: [
                        const Icon(Icons.pin_drop),
                        Text(" $chosenHospital"),
                      ],
                    ),
                  ],
                )
              ),
              Container(
                margin: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: hasUserChosenTheHospital() ? Color(0xFFBC3B3B) : Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: ListTile(
                  title: hasUserChosenTheHospital()
                  ? const Text("Press to change the hospital", style: TextStyle(
                    color: Colors.white
                  ))
                  : const Text("Select a hospital"),
                  leading: hasUserChosenTheHospital()
                  ? const Icon(Icons.check, color: Colors.white)
                  : const Icon(Icons.local_hospital),
                  onTap: selectHospitalDialog,
                ),
              ),
              ListTile(
                title: hasUserChosenTheDate()
                ?
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Chosen date:"),
                    Row(
                      children: [
                        const Icon(Icons.calendar_today),
                        Text(" ${chosenDateTime.day.toString()} ${getMonthName(chosenDateTime.month)} ${chosenDateTime.year.toString()} (${chosenDateTime.day.toString()}/${chosenDateTime.month.toString()}/${chosenDateTime.year.toString()})"),
                      ],
                    ),
                  ],
                )
                :
                const Text("No date chosen yet.")
              ),
              Container(
                margin: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: hasUserChosenTheDate() ? Color(0xFFBC3B3B) : Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: ListTile(
                  title: hasUserChosenTheDate()
                  ? const Text(
                    "Press to change the date",
                    style: TextStyle(
                      color: Colors.white
                    ),
                  )
                  : const Text("Select a date *"),
                  leading: hasUserChosenTheDate()
                  ?
                  const Icon(Icons.check, color: Colors.white)
                  : const Icon(Icons.edit_calendar),
                  onTap: showDatePicker,
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
              const SizedBox(height: 15.0),
              ListTile(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Chosen time:"),
                    Row(
                      children: [
                        const Icon(Icons.watch_later_outlined),
                        Text(" $chosenTimeslot"),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      MyTimeblock(
                        text: "9-10AM",
                        onTap: () => selectTimeslot("9AM - 10AM"),
                        selected: chosenTimeslot == "9AM - 10AM"
                      ),
                      MyTimeblock(
                        text: "10-11AM",
                        onTap: () => selectTimeslot("10AM - 11AM"),
                        selected: chosenTimeslot == "10AM - 11AM"
                      ),
                      MyTimeblock(
                        text: "11-12PM",
                        onTap: () => selectTimeslot("11AM - 12PM"),
                        selected: chosenTimeslot == "11AM - 12PM"
                      ),
                    ],
                  ),
                  const SizedBox(height: 15.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      MyTimeblock(
                        text: "1-2PM",
                        onTap: () => selectTimeslot("1PM - 2PM"),
                        selected: chosenTimeslot == "1PM - 2PM"
                      ),
                      MyTimeblock(
                        text: "2-3PM",
                        onTap: () => selectTimeslot("2PM - 3PM"),
                        selected: chosenTimeslot == "2PM - 3PM"
                      ),
                      MyTimeblock(
                        text: "3-4PM",
                        onTap: () => selectTimeslot("3PM - 4PM"),
                        selected: chosenTimeslot == "3PM - 4PM"
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 15.0),
              MyButton(
                text: "Next",
                onTap: () => {
                  Navigator.pushNamed(context, "user_booking_review", arguments: {
                    "fullName": fullName,
                    "chosenHospital": chosenHospital,
                    "chosenDateTime": chosenDateTime,
                    "chosenDateTimeString": "${chosenDateTime.day.toString()} ${getMonthName(chosenDateTime.month)} ${chosenDateTime.year.toString()}",
                    "chosenTimeslot": chosenTimeslot,
                    "bloodType": bloodType,
                    "icNumber": icNumber,
                    "weight": weight,
                    "height": height,
                    "appCount": appCount,
                  }),
                },
                verificationPassed: chosenHospital != ""
                && chosenDateTime.year != DateTime(2020).year
                && chosenTimeslot != "No time chosen yet.",
              ),
            ],
          )
        )
      )
    );
  }
}