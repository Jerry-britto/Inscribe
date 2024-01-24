import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:main/screens/login/forgot_password.dart';

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
      body: Container(
          decoration: const BoxDecoration(
            color: Color.fromRGBO(227, 161, 43, 0.3),
          ),
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
                            borderSide: const BorderSide(
                                color: Color.fromRGBO(162, 7, 48, 1), width: 2),
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
                      if (val == null || val.isEmpty) {
                        return "Kindly enter your Password";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        hintText: "Enter Password",
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isVisible = !isVisible;
                              });
                            },
                            icon: const Icon(Icons.remove_red_eye_sharp))),
                    obscureText: isVisible,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: MouseRegion(
                      onEnter: (event) => setState(() => _isHovered = true),
                      onExit: (event) => setState(() => _isHovered = false),
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) =>
                                      const ForgotPasswordScreen()));
                        },
                        child: Text(
                          'Forgot Password',
                          style: TextStyle(
                              color: _isHovered
                                  ? const Color.fromRGBO(66, 140, 236, 1)
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
                        backgroundColor: const Color.fromRGBO(162, 7, 48, 1),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            //Authenticate the user
                            FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                                    email: email.text, password: password.text)
                                .then((val) {
                              //Navigate to home page
                            }).onError((error, stackTrace) {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                        title: const Text("Failed to Login"),
                                        content:
                                            const Text("Invalid credentials"),
                                        actions: [
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context, 'OK'),
                                            child: const Text('OK'),
                                          ),
                                        ],
                                      ));
                            });
                          }
                          email.text = password.text = "";
                        },
                        child: const Text(
                          "Login",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        )),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  TextButton.icon(
                    onPressed: () {
                      // Sign in with Google
                    },
                    icon: SizedBox(
                      height: 20,
                      child: Image.asset("assets/images/google_icon.webp"),
                    ),
                    label: const Text(
                      "Sign in with Google",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text(
                        "Don't have a account ?",
                        style: TextStyle(fontSize: 16),
                      ),
                      TextButton(
                          onPressed: () {
                            print("go to sign up");
                          },
                          child: const Text(
                            "Sign up",
                            style:
                                TextStyle(color: Color.fromRGBO(162, 7, 48, 1)),
                          ))
                    ],
                  ),
                ],
              ),
            ),
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color.fromRGBO(162, 7, 48, 1),
        tooltip: 'Admin',
        shape: const CircleBorder(
            side:
                BorderSide(color: Color.fromRGBO(227, 161, 43, 0.3), width: 2),
            eccentricity: 1.0),
        child: const Icon(
          Icons.admin_panel_settings_outlined,
          color: Colors.white,
        ),
      ),
      );
}
