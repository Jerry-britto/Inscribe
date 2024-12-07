import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:main/components/Card/swdCard.dart';

class SwdRequests extends StatelessWidget {
  final String email;
  const SwdRequests({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection("Requests")
          .where("swdId", isEqualTo: email.toString())
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
    
        if (snapshot.hasError) {
          return const Center(child: Text("An error occurred while fetching requests."));
        }
    
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text("No Requests"));
        }
    
        final List<Map<String, dynamic>> listOfRequests = snapshot.data!.docs.map((doc) {
          return doc.data() as Map<String, dynamic>;
        }).toList();
    
        return ListView.builder(
          itemCount: listOfRequests.length,
          itemBuilder: (context, index) {
            return SwdCard(data: listOfRequests[index]);
          },
        );
      },
    );
  }
}






// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:main/components/Card/swdCard.dart';

// class SwdRequests extends StatefulWidget {
//   const SwdRequests({super.key, this.email});
//   final String? email;

//   @override
//   State<SwdRequests> createState() => _SwdRequestsState();
// }

// class _SwdRequestsState extends State<SwdRequests> {
//   // dynamic data;
//   //   List<Map<String,dynamic>>request=[
//   //   {
//   //     'scribeId':null,
//   //     'status':"pending",
//   //     "examData":{
//   //       'dateAndTime':"12th Feb 9 am",
//   //       "examType":"CIA 1",
//   //       "subjectName":"History",
//   //     },
//   //   },
//   //   {
//   //     'scribeId':null,
//   //     'status':"pending",
//   //     "examData":{
//   //       'dateAndTime':"12th Feb 9 am",
//   //       "examType":"CIA 1",
//   //       "subjectName":"History",
//   //     },
//   //   },
//   //   {
//   //     'scribeId':"sahil",
//   //     'status':"accepted",
//   //     "examData":{
//   //       'dateAndTime':"12th Feb 9 am",
//   //       "examType":"CIA 1",
//   //       "subjectName":"History",
//   //     },
//   //   },
//   //   {
//   //     'scribeId':"jerry",
//   //     'status':"accepted",
//   //     "examData":{
//   //       'dateAndTime':"12th Feb 9 am",
//   //       "examType":"CIA 1",
//   //       "subjectName":"History",
//   //     },
//   //   },
//   //   {
//   //     'scribeId':"isha",
//   //     'status':"accepted",
//   //     "examData":{
//   //       'dateAndTime':"12th Feb 9 am",
//   //       "examType":"CIA 1",
//   //       "subjectName":"History",
//   //     },
//   //   },
//   // ];
//   List<Map<String,dynamic>> listOfRequests = [];
//   Future<void> getRequests() async {
//     print("\nDisplaying requests\n\n");
//     await FirebaseFirestore.instance
//         .collection("Requests")
//         .where("swdId", isEqualTo: widget.email!.toString())
//         .get()
//         .then((QuerySnapshot querySnapshot) {
//             List<QueryDocumentSnapshot> documents = querySnapshot.docs;
//             for(QueryDocumentSnapshot doc in documents){
//               print(doc.data());
//               final data = doc.data();
//               setState(() {
//               listOfRequests.add(data as Map<String,dynamic>);
//               });
//             }
//           print('\n Displaying list of requests of length ${listOfRequests.length}:- \n');
//           print(listOfRequests);
//         }).onError((error, stackTrace) {
//           print("Error occured while getting requests");
//         });
//   }
//   @override
//   void initState() {
//     super.initState();
//     getRequests();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: RefreshIndicator(
//         onRefresh: () async{
//           setState(() {
//           listOfRequests.clear();
//           });
//           await getRequests();
//         },
//         child: listOfRequests==[] || listOfRequests.isEmpty?const Center(child:Text("No Requests")):ListView(
//       children: [Column(
//         children: List.generate(listOfRequests.length, (index) {
//           return SwdCard(data:listOfRequests[index]);
//         })
//       ),],
//     ),
//       ),
//     );
    
    
//    }
// }
