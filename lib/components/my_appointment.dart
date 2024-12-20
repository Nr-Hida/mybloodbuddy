// import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";
import "package:mybb/utils/appointment.dart";

class MyAppointment extends StatelessWidget {
  final Future<Appointment> upcomingApp;

  final totalMonthsInAYear = 12;
  
  const MyAppointment({
    super.key,
    required this.upcomingApp,
  });

  String formatUpcomingAppointment() {
    // final ts = Timestamp.fromDate(DateTime(DateTime.now().year + 1, (DateTime.now().month + 3) % totalMonthsInAYear, DateTime.now().day));
    return "";
  }

  bool emptyAppointment(Appointment? emptyApp) {
    return emptyApp?.donor == ""
    && emptyApp?.hospital == ""
    && emptyApp?.timeslot == "";
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: upcomingApp,
      builder: (context, snapshot) {
        if (emptyAppointment(snapshot.data)) {
          return Padding(
            padding: const EdgeInsets.only(right: 25.0, bottom: 25.0, left: 25.0),
            child: Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Color(0xFFBC3B3B),
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(4.0, 4.0),
                    blurRadius: 5.0,
                    spreadRadius: 1.0
                  )
                ]
              ),
              child: const Row(
                children: [
                  Text(
                    "No upcoming appointments",
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900
                    )
                  ),
                ],
              )
            ),
          );
        } else if (snapshot.hasData) {
          return Padding(
            padding: const EdgeInsets.only(right: 25.0, bottom: 25.0, left: 25.0),
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFFBC3B3B),
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(4.0, 4.0),
                    blurRadius: 5.0,
                    spreadRadius: 1.0
                  )
                ]
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(10.0)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 50.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(getMonthName(snapshot.data!.date.toDate().month), style: const TextStyle(
                              fontSize: 24
                            )),
                            Text(snapshot.data!.date.toDate().day.toString(), style: const TextStyle(
                              fontSize: 64,
                              fontWeight: FontWeight.w900
                            )),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.pin_drop),
                          const SizedBox(height: 8),
                          Text(
                            snapshot.data!.hospital,
                            softWrap: true,
                            overflow: TextOverflow.fade,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w900
                            )
                          ),
                          const SizedBox(height: 8),
                          const Icon(Icons.calendar_month),
                          const SizedBox(height: 8),
                          Text(
                            snapshot.data!.timeslot,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w900
                            )
                          ),
                          // Row(
                          //   children: [
                          //     const Icon(Icons.pin_drop),
                          //     const SizedBox(width: 8),
                          //     Text(
                          //       snapshot.data!.hospital,
                          //       softWrap: true,
                          //       overflow: TextOverflow.fade,
                          //       style: const TextStyle(
                          //         color: Colors.white,
                          //         fontWeight: FontWeight.w900
                          //       )
                          //     ),
                          //   ],
                          // ),
                          // Row(
                          //   children: [
                          //     const Icon(Icons.calendar_month),
                          //     const SizedBox(width: 8),
                          //     Text(
                          //       snapshot.data!.timeslot,
                          //       softWrap: true,
                          //       overflow: TextOverflow.ellipsis,
                          //       style: const TextStyle(
                          //         color: Colors.white,
                          //         fontWeight: FontWeight.w900
                          //       )
                          //     ),
                          //   ],
                          // )
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ),
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}: ${snapshot.stackTrace}');
        }

        return const CircularProgressIndicator();
      }
    );
  }
}