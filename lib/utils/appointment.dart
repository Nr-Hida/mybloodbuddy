import "package:firebase_auth/firebase_auth.dart";
import "package:cloud_firestore/cloud_firestore.dart";

class Appointment {
  final String donor;
  final String hospital;
  final String timeslot;
  final Timestamp date;

  Appointment({
    required this.donor,
    required this.hospital,
    required this.timeslot,
    required this.date,
  });
}

String getMonthName(int month) {
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

// Fetch upcoming Appointment
Future<Appointment> fetchUpcomingAppointment() async {
  Appointment upcoming = Appointment(donor: "", hospital: "", timeslot: "", date: Timestamp(0, 0));
  const totalMonthsInAYear = 12;
  try {
    final appRef = FirebaseFirestore.instance.collection("appointments");
    await appRef.where("donor", isEqualTo: FirebaseAuth.instance.currentUser!.email).where("created", isLessThanOrEqualTo: Timestamp.fromDate(DateTime(DateTime.now().year + 1, (DateTime.now().month + 3) % totalMonthsInAYear, DateTime.now().day))).get().then(
      (querySnapshot) {
        print("Successfully fetched upcomingAppointment");
        // print("querySnapshot: ${querySnapshot.docs.first.data()}");
        
        var cur = querySnapshot.docs.first;
        var upcomingApp = querySnapshot.docs.first;
        for (var doc in querySnapshot.docs) {
          if (
            cur.data()["date"].toDate().difference(DateTime.now()).abs()
            <
            doc.data()["date"].toDate().difference(DateTime.now()).abs()
          ) {
            upcomingApp = cur;
          }

          cur = doc;
        }

        upcoming = Appointment(
          donor: upcomingApp.data()["donor"] ?? "",
          hospital: upcomingApp.data()["hospital"] ?? "",
          timeslot: upcomingApp.data()["timeslot"] ?? "",
          date: upcomingApp.data()["date"] ?? Timestamp(0, 0),
        );
      },
      onError: (e) => {
        throw Exception("Failed to fetch upcoming appointment: $e")
      },
    );
  } catch (e) {
    print("$e, caught in fetchUpcomingAppointment()");
  }
  
  return upcoming; // empty if try block fails
}

// Fetch all Appointments
Future<Appointment> fetchAppointments() async {
  final appRef = FirebaseFirestore.instance.collection("appointments");
  await appRef.get().then(
    (querySnapshot) {
      print("Successfully fetched fetchAppointments");
      for (var docSnapshot in querySnapshot.docs) {
        print('${docSnapshot.id} => ${docSnapshot.data()}');
      }
    },
    onError: (e) => {
      throw Exception("Failed to fetch all appointments: $e")
    },
  );
  
  return Appointment(donor: "", hospital: "", timeslot: "", date: Timestamp(0, 0));
}

// Fetch and count total number of Appointments
Future<int> countAppointments() async {
  int count = 0;
  final appRef = FirebaseFirestore.instance.collection("appointments");
  await appRef.get().then(
    (querySnapshot) {
      print("Successfully fetched countAppointments");
      for (var docSnapshot in querySnapshot.docs) {
        count += 1;
        // print('${docSnapshot.id} => ${docSnapshot.data()}');
      }
      // print("Successfully counted");
      // print(count);
    },
    onError: (e) => {
      throw Exception("Failed to fetch countAppointments: $e")
    },
  );
  
  return count;
}