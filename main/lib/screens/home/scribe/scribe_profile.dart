import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:main/screens/details_pages/scribe_details.dart';

class ScribeProfile extends StatefulWidget {
  final String? emailText;
  const ScribeProfile({super.key, required this.emailText});

  @override
  State<ScribeProfile> createState() => _ScribeProfileState();
}

class _ScribeProfileState extends State<ScribeProfile> {
  final TextStyle customTextStyle = const TextStyle(
    fontSize: 20,
  );
  Map<String, dynamic>? data;
  void getData() async {
    try {
      final snapShot = await FirebaseFirestore.instance
          .collection("Scribes")
          .doc(widget.emailText)
          .get();
      print(snapShot.data());
      setState(() {
        data = snapShot.data();
      });
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    print("User Entered ${widget.emailText}");
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return data != null
        ? Padding(
            padding: const EdgeInsets.all(20),
            child: Card(
              color: Colors.white,
              child: Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          data!["name"] != null ? data!['name'] : '',
                          style: const TextStyle(
                              fontSize: 25, fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: data!.containsKey("imageUrl") &&
                                  data!["imageUrl"] != ""
                              ? FadeInImage(
                                  placeholder: AssetImage(
                                      "assets/images/dummyAvatar.png"),
                                  image: NetworkImage(data!['imageUrl']),
                                  height: 150,
                                  width: 150,
                                  fit: BoxFit.cover,
                                )
                              : const Icon(
                                  Icons.person,
                                  color: Color.fromRGBO(162, 7, 48, 1),
                                  size: 100,
                                ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Category :",
                          style: customTextStyle,
                        ),
                        Text(
                          " Scribe",
                          style: customTextStyle,
                        ),
                      ],
                    ),
                    Row(children: [
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        "Email :",
                        style: customTextStyle,
                      ),
                      Text(
                        " ${data!['email']}",
                        style: const TextStyle(fontSize: 18),
                      ),
                    ]),
                    Row(
                      children: [
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          "UID :",
                          style: customTextStyle,
                        ),
                        Text(
                          data!['uid'] != null
                              ? " ${data!['uid'].toString()}"
                              : '',
                          style: customTextStyle,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Year :",
                          style: customTextStyle,
                        ),
                        Text(
                          data!['year'] != null ? " ${data!['year']}" : '',
                          style: customTextStyle,
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        Text(
                          "Course :",
                          style: customTextStyle,
                        ),
                        Text(
                          data!['course'] != null ? " ${data!['course']}" : '',
                          style: customTextStyle,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Age :",
                          style: customTextStyle,
                        ),
                        Text(
                          data!['age'] != null
                              ? " ${data!['age'].toString()}"
                              : '',
                          style: customTextStyle,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Contact :",
                          style: customTextStyle,
                        ),
                        Text(
                          data!['phoneNo'] != null
                              ? " ${data!['phoneNo'].toString()}"
                              : '',
                          style: customTextStyle,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CircleAvatar(
                          backgroundColor: const Color.fromRGBO(162, 7, 48, 1),
                          child: IconButton(
                              tooltip: "Edit Details",
                              iconSize: 32,
                              color: Colors.white,
                              onPressed: () {
                                print("edit details");
                                print(data);
                                // print();
                                Future.delayed(
                                    const Duration(milliseconds: 1000), () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => DetailsForm2(
                                              emailText: widget.emailText
                                                  .toString())));
                                });
                              },
                              icon: Image.asset(
                                "assets/icons/pencil.png",
                                color: Colors.white,
                              )),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
        : SizedBox(
            height: MediaQuery.of(context).size.height / 2,
            width: MediaQuery.of(context).size.height / 2,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
  }
}
