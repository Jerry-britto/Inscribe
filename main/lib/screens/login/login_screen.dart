import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:main/screens/login/forgot_password.dart';
import 'package:main/screens/signup.dart';

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

  loginUser(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        print("User logged in");
        // navigate to home
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        displayMessage('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        displayMessage('Wrong password provided for that user.');
      } else {
        displayMessage(e.message.toString());
      }
    }
  }

  signInWithGoogle() async {
    try {
      GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      UserCredential user =
          await FirebaseAuth.instance.signInWithCredential(credential);

      print(user.user?.photoURL);
    } on FirebaseAuthException catch (e) {
      displayMessage(e.message.toString());
    }
    ;
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
                        if (val == null || val.isEmpty) {
                          return "Kindly enter your Password";
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
                              loginUser(email.text, password.text);
                            }
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
                        signInWithGoogle();
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
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) => const SignUpScreen()));
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
            )),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: const Color.fromRGBO(162, 7, 48, 1),
          tooltip: 'Admin',
          shape: const CircleBorder(
              side: BorderSide(
                  color: Color.fromRGBO(227, 161, 43, 0.3), width: 2),
              eccentricity: 1.0),
          child: const Icon(
            Icons.admin_panel_settings_outlined,
            color: Colors.white,
          ),
        ),
      );
}
