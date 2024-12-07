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
  bool isLoading = false;
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
            child: const Text("Ok"),
          ),
        ],
      ),
    );
  }

  Future<void> loginUser(String email, String password) async {
    setState(() {
      isLoading = true; // Show loader
    });
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: email.trim(), password: password.trim())
          .then((value) async {
        print("User logged in");

        final QuerySnapshot<Map<String, dynamic>> isScribe =
            await FirebaseFirestore.instance
                .collection("Scribes")
                .where("email", isEqualTo: email)
                .get();

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
              builder: (_) => ScribeHome(emailText: email),
            ),
          );
        } else if (isSwd.docs.isNotEmpty) {
          // ignore: use_build_context_synchronously
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => SwdHome(emailText: email),
            ),
          );
        } else {
          displayMessage('User does not exist');
        }
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        displayMessage('User not found.');
      } else if (e.code == 'wrong-password') {
        displayMessage('The password entered is wrong.');
      } else {
        displayMessage(e.message.toString());
      }
    } finally {
      setState(() {
        isLoading = false; // Hide loader
      });
    }
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Welcome back",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(162, 7, 48, 1),
        automaticallyImplyLeading: false,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Color.fromRGBO(227, 161, 43, 0.3),
              ),
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: email,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return "Kindly enter your email";
                              } else if (!RegExp(
                                      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
                                  .hasMatch(value)) {
                                return "Invalid Email";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color.fromRGBO(162, 7, 48, 1),
                                  width: 3,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              hintText: "Enter Email",
                              prefixIcon: const Icon(Icons.mail),
                            ),
                          ),
                          const SizedBox(height: 25),
                          TextFormField(
                            controller: password,
                            validator: (val) {
                              if (val == null || val.trim().isEmpty) {
                                return "Kindly enter your Password";
                              } else if (val.length < 6) {
                                return "Length of password should be more than 6";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color.fromRGBO(162, 7, 48, 1),
                                  width: 3,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              hintText: "Enter Password",
                              prefixIcon: const Icon(Icons.lock),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    isVisible = !isVisible;
                                  });
                                },
                                icon: Icon(
                                  isVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                              ),
                            ),
                            obscureText: isVisible,
                          ),
                          const SizedBox(height: 10),
                          Align(
                            alignment: Alignment.centerRight,
                            child: MouseRegion(
                              onEnter: (_) => setState(() => _isHovered = true),
                              onExit: (_) => setState(() => _isHovered = false),
                              child: TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          const ForgotPasswordScreen(),
                                    ),
                                  );
                                },
                                child: Text(
                                  'Forgot Password',
                                  style: TextStyle(
                                    color: _isHovered
                                        ? const Color.fromRGBO(66, 140, 236, 1)
                                        : Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 6),
                          SizedBox(
                            width: double.infinity,
                            child: FloatingActionButton(
                              backgroundColor:
                                  const Color.fromRGBO(162, 7, 48, 1),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  loginUser(email.text, password.text);
                                }
                              },
                              child: const Text(
                                "Login",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              const Text(
                                "Don't have an account?",
                                style: TextStyle(fontSize: 16),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder: (_) => const SignUpScreen(),
                                    ),
                                  );
                                },
                                child: const Text(
                                  "Sign up",
                                  style: TextStyle(
                                    color: Color.fromRGBO(162, 7, 48, 1),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            if (isLoading)
              const Center(
                child: CircularProgressIndicator(
                  color: Color.fromRGBO(162, 7, 48, 1),
                  
                ),
              ),
          ],
        ),
      ),
    );
  }
}
