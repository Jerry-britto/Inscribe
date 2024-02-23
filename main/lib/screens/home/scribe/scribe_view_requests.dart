import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class ViewSwdRequests extends StatefulWidget {
  const ViewSwdRequests({super.key, this.email});
  final String? email;

  @override
  State<ViewSwdRequests> createState() => _ViewSwdRequestsState();
}

class _ViewSwdRequestsState extends State<ViewSwdRequests> {
  List<Map<String,dynamic>> listOfRequest=[];
  Future<void> getRequests() async {
    print("\n scribe email id: ${widget.email.toString()}");
    print('\n');
    await FirebaseFirestore.instance
        .collection("Requests")
        .where("scribeId", isEqualTo: widget.email.toString())
        .get()
        .then((QuerySnapshot snapshot) {
          List<QueryDocumentSnapshot> documents = snapshot.docs;
          for(QueryDocumentSnapshot doc in documents){
            print(doc.data());
            final data = doc.data();
            listOfRequest.add(data as Map<String,dynamic>);
          }
          print("\n\n list of requests is as follows with length ${listOfRequest.length}");
          print('\n $listOfRequest');
        })
        .onError((error, stackTrace) {
          print("Error displayed while getting requests of scribe");
        });
  }
  @override
  void initState() {
    super.initState();
    getRequests();
  }
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Your requests from SWD...."),
    );
  }
}
