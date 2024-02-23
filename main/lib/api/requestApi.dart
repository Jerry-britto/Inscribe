import 'package:cloud_firestore/cloud_firestore.dart';

class RequestApi {
  final db = FirebaseFirestore.instance;
  Map<String, dynamic>? SwdData; // to store data of swd

  Future<Map<String, dynamic>> getSwdData(String swdEmail) async {
    await db.collection("SWD").doc(swdEmail).get().then(
      (DocumentSnapshot doc) {
        SwdData = doc.data() as Map<String, dynamic>;
        print("Swd data is as follows: $SwdData");
      },
    );
    return SwdData!;
  }

  Future<void> findScribe(
      String examType, String subject, String examDate, String swdEmail) async {
    SwdData = await getSwdData(swdEmail) as Map<String, dynamic>;
    print(
        "Your examtype is ${examType} and your subject is ${subject} and date is ${examDate}");
    print(SwdData);
    if (SwdData!.containsKey("vols")) {
      List vols = SwdData!["vols"];
      if (vols.isNotEmpty) {
        print("applied for more than 1 exam");
        print("Available vols $vols");
        String scribe = vols[0]["email"];

        print("Assigned Scribe $scribe");
        vols.removeAt(0);
        print("new vols data $vols");

        await db.collection("Requests").add({
          "swdId": SwdData!["email"],
          "scribeId": scribe,
          "status":"pending",
          "examData": {
            "subjectName": subject,
            "examType": examType,
            "dateAndTime": examDate
          }
        });
        await db
            .collection("SWD")
            .doc(SwdData!["email"])
            .update({"vols": vols})
            .then((value) => print("vols list updated"))
            .onError((error, stackTrace) => print("vols list not updated"));
        return;
      }
    }
    List vols = [];
    // filtering list of scribes
    print('Searching for scribe');
    print(
        "course is ${SwdData!['course']} and he belongs to year: ${SwdData!["year"]} and his age is ${SwdData!["age"]}");
    // filtered based on different course and one year smaller
    await db
        .collection("Scribes")
        .where("age", isLessThanOrEqualTo: SwdData!["age"])
        .orderBy("age", descending: true)
        .limit(7)
        .get()
        .then((QuerySnapshot querySnapshot) {
      List<QueryDocumentSnapshot> documents = querySnapshot.docs;

      for (QueryDocumentSnapshot document in documents) {
        if (document["year"] != SwdData!["year"] &&
            document["course"] != SwdData!["course"]) {
          print("Document ID: ${document.id}");
          print(document.data());
          final data = document.data();
          vols.add(data);
          print("-------------");
        }
      }
    }).onError((error, stackTrace) {
      print("could not filter data");
      return;
    });

    await db
        .collection("Requests")
        .add({
          "swdId": SwdData!["email"],
          "scribeId": vols[0]["email"],
          'status': 'pending',
          "examData": {
            "subjectName": subject,
            "examType": examType,
            "dateAndTime": examDate
          }
        })
        .then((value) => print("Requests added"))
        .onError((error, stackTrace) => print("Requests not added"));
    vols.removeAt(0);
    await db
        .collection("SWD")
        .doc(SwdData!["email"])
        .update({"vols": vols})
        .then((value) => print("vols added"))
        .onError((error, stackTrace) => print("Vosl not added"));
  }
}
