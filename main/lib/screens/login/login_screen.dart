import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:main/screens/home/scribe/scribe_home.dart';
import 'package:main/screens/home/swd/swd_home.dart';
import 'package:main/screens/login/forgot_password.dart';
import 'package:main/screens/sign_up/signup.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isVisible = true;
  final _formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final password = TextEditingController();
  bool _isHovered = false;

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
              child: const Text("Ok"))
        ],
      ),
    );
  }

  Future<void> loginUser(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        print("User logged in");

        // To Check if the user exists in the Scribes collection
        final QuerySnapshot<Map<String, dynamic>> isScribe =
            await FirebaseFirestore.instance
                .collection("Scribes")
                .where("email", isEqualTo: email)
                .get();

        // To Check if the user exists in the Scribes collection

        final QuerySnapshot<Map<String, dynamic>> isSwd =
            await FirebaseFirestore.instance
                .collection("SWD")
                .where("email", isEqualTo: email)
                .get();

        if (isScribe.docs.isNotEmpty) {
          print('User is a Scribe.');

          // ignore: use_build_context_synchronously
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (_) => ScribeHome(
                        emailText: email,
                      )));
        } else if (isSwd.docs.isNotEmpty) {
          // ignore: use_build_context_synchronously
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (_) => SwdHome(
                        emailText: email,
                      )));
        } else {
          displayMessage('User does not exist');
        }
      });
      // Navigator.of(context).pop();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        displayMessage('User not found.');
      } else if (e.code == 'wrong-password') {
        displayMessage('The password entered is wrong.');
      } else {
        displayMessage(e.message.toString());
      }
    }
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text(
            "Welcome back", 
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
                            TextFormField(
                              controller: email,
                              validator: (value) {
                                if (value == null ||
                                    value.isEmpty ||
                                    value.trim() == "") {
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
                                      icon:  Icon(
                                         isVisible?Icons.visibility:Icons.visibility_off))),
                              obscureText: isVisible,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: MouseRegion(
                                onEnter: (event) =>
                                    setState(() => _isHovered = true),
                                onExit: (event) =>
                                    setState(() => _isHovered = false),
                                child: TextButton(
                                  onPressed: () {
                                    Future.delayed(
                                        const Duration(milliseconds: 600),
                                        () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) =>
                                                    const ForgotPasswordScreen())));
                                  },
                                  child: Text(
                                    'Forgot Password',
                                    style: TextStyle(
                                        color: _isHovered
                                            ? const Color.fromRGBO(
                                                66, 140, 236, 1)
                                            : Colors.black),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: FloatingActionButton(
                                  backgroundColor:
                                      const Color.fromRGBO(162, 7, 48, 1),
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      //Authenticate the user
                                      loginUser(email.text, password.text);
                                    }
                                  },
                                  child: const Text(
                                    "Login",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  )),
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                const Text(
                                  "Don't have an account ?",
                                  style: TextStyle(fontSize: 16),
                                ),
                                TextButton(
                                    onPressed: () {
                                      Future.delayed(
                                          const Duration(milliseconds: 600),
                                          () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (_) =>
                                                    const SignUpScreen()));
                                      });
                                    },
                                    child: const Text(
                                      "Sign up",
                                      style: TextStyle(
                                          color: Color.fromRGBO(162, 7, 48, 1)),
                                    ))
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              )),
        ),
      );
}
