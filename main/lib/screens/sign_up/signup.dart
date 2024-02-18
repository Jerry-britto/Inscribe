import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:main/screens/details_pages/scribe_details.dart';
import 'package:main/screens/details_pages/swd_details.dart';
import 'package:main/screens/login/login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isVisible = true;
  bool isVisible2 = true;
  final _formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final password = TextEditingController();
  final cnfpassword = TextEditingController();
  bool toggleValue = false;

  createUser() {
    if (toggleValue == false) {
      final colref =
          FirebaseFirestore.instance.collection('SWD').doc(email.text);

      Map<String, dynamic> swdMap = {"email": email.text};

      colref
          .set(swdMap)
          .then((value) => print("SWD Added"))
          .catchError((error) => print("Failed to add SWD : $error"));
    } else {
      final colref =
          FirebaseFirestore.instance.collection('Scribes').doc(email.text);

      Map<String, dynamic> scribesMap = {"email": email.text};

      colref
          .set(scribesMap)
          .then((value) => print("Scribe Added"))
          .catchError((error) => print("Failed to add Scribe : $error"));
    }
  }

  void displayMessage(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Ok"),
          )
        ],
      ),
    );
  }

  void registerUser(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        createUser();
        // Navigate user to details page
        print("User signed up");
        if (toggleValue == false) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => DetailsForm(emailText: email),
            ),
          );
        } else if (toggleValue == true) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => DetailsForm2(emailText: email),
            ),
          );
        }
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        displayMessage('The password should be more than 6 characters.');
      } else if (e.code == 'email-already-in-use') {
        displayMessage('The account already exists for that email.');
      } else {
        displayMessage(e.message.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text(
            "Create an Account",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          backgroundColor: const Color.fromRGBO(162, 7, 48, 1),
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Container(
            decoration: const BoxDecoration(
              color: Color.fromRGBO(227, 161, 43, 0.3),
            ),
            child: Expanded(
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                height: 100,
                                child: Image.asset(
                                  "assets/images/xaviers_logo.png",
                                ),
                              ),
                              SizedBox(
                                height: 100,
                                child: Image.asset(
                                  "assets/images/XRCVC.png",
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Center(
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              height: 50.0,
                              width: 280.0,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: const Color(0xCCA20730)),
                                borderRadius: BorderRadius.circular(40.0),
                                color: Colors.white,
                              ),
                              child: Stack(
                                children: <Widget>[
                                  InkWell(
                                    onTap: () {
                                      toggleButton();
                                    },
                                    child: const Center(
                                      child: Row(
                                        children: <Widget>[
                                          SizedBox(width: 60),
                                          Text("SWD",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold)),
                                          SizedBox(width: 90),
                                          Text("Scribe",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold)),
                                        ],
                                      ),
                                    ),
                                  ),
                                  AnimatedPositioned(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeIn,
                                    top: 5.0,
                                    left: toggleValue ? 125.0 : 0.0,
                                    right: toggleValue ? 0.0 : 125.0,
                                    bottom: 5.0,
                                    child: AnimatedSwitcher(
                                      duration:
                                          const Duration(milliseconds: 300),
                                      child: Container(
                                        width: 140.0,
                                        height: 40.0,
                                        decoration: ShapeDecoration(
                                          color: const Color(0xCCA20730)
                                              .withOpacity(0.2),
                                          shape: RoundedRectangleBorder(
                                            side: const BorderSide(
                                                width: 1,
                                                color: Color(0xCCA20730)),
                                            borderRadius:
                                                BorderRadius.circular(40),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: email,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Kindly enter your email";
                              } else if (!RegExp(
                                      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
                                  .hasMatch(value)) {
                                return "Invalid Email";
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Color.fromRGBO(162, 7, 48, 1),
                                        width: 3),
                                    borderRadius: BorderRadius.circular(20)),
                                hintText: "Enter Email",
                                prefixIcon: const Icon(Icons.mail)),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          TextFormField(
                            controller: password,
                            validator: (val) {
                              if (val == null ||
                                  val.isEmpty ||
                                  val.trim() == "") {
                                return "Kindly enter your Password";
                              } else if (val.length < 6) {
                                return "Length of password should be more than 6";
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Color.fromRGBO(162, 7, 48, 1),
                                        width: 3),
                                    borderRadius: BorderRadius.circular(20)),
                                hintText: "Enter Password",
                                prefixIcon: const Icon(Icons.lock),
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        isVisible = !isVisible;
                                      });
                                    },
                                    icon: Icon(isVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off))),
                            obscureText: isVisible,
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          TextFormField(
                            controller: cnfpassword,
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return "Kindly enter your Password";
                              } else if (val != password.text) {
                                return "This password doesn't match the previously entered password";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Color.fromRGBO(162, 7, 48, 1),
                                        width: 3),
                                    borderRadius: BorderRadius.circular(20)),
                                hintText: "Enter Password",
                                prefixIcon: const Icon(Icons.lock),
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        isVisible2 = !isVisible2;
                                      });
                                    },
                                    icon:  Icon(isVisible2?
                                        Icons.visibility:Icons.visibility_off))),
                            obscureText: isVisible2,
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: FloatingActionButton(
                                backgroundColor:
                                    const Color.fromRGBO(162, 7, 48, 1),
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    registerUser(email.text, cnfpassword.text);
                                  }
                                },
                                child: const Text(
                                  "Register",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                )),
                          ),
                          const SizedBox(
                            height: 29,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              const Text(
                                "Already have an account ?",
                                style: TextStyle(fontSize: 16),
                              ),
                              const SizedBox(
                                width: 0,
                              ),
                              TextButton(
                                  onPressed: () {
                                    print("go to sign in");
                                    Future.delayed(
                                        const Duration(milliseconds: 600), () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginScreen(),
                                        ),
                                      );
                                    });
                                  },
                                  child: const Text(
                                    "Sign In",
                                    style: TextStyle(
                                        color: Color.fromRGBO(162, 7, 48, 1)),
                                  ))
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );

  toggleButton() {
    setState(() {
      toggleValue = !toggleValue;
    });
  }
}
