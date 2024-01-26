import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:main/screens/login/login_screen.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
  bool _isToggled = false;

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

  void registerUser(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        // Navigate user to home
        print("User signed up");
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        displayMessage('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        displayMessage('The account already exists for that email.');
      } else {
        displayMessage(e.message.toString());
      }
    }
  }

   signInWithGoogle() async {
    final  googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    final GoogleSignInAuthentication? googleSignInAuthentication =
        await googleSignInAccount?.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      idToken: googleSignInAuthentication?.idToken,
      accessToken: googleSignInAuthentication?.accessToken,
    );

    UserCredential result =
        await FirebaseAuth.instance.signInWithCredential(credential);

    User? userDetails = result.user;
    print(userDetails?.displayName);
    print(userDetails?.email);
    GoogleSignIn().disconnect();
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
                  ToggleButtons(
                    onPressed: (int index) {
                      setState(() {
                        _isToggled = index == 0;
                      });
                    },
                    borderRadius: const BorderRadius.all(Radius.circular(50)),
                    borderColor: Colors.black,
                    selectedColor: const Color.fromRGBO(162, 7, 48, 1),
                    selectedBorderColor: const Color.fromRGBO(162, 7, 48, 1),
                    constraints:
                        const BoxConstraints(minWidth: 100, minHeight: 50),
                    isSelected: [_isToggled, !_isToggled],
                    children: const [
                      Text("SWD"),
                      Text("Scribe"),
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
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        borderSide:
                            BorderSide(color: Color.fromRGBO(162, 7, 48, 1)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        borderSide:
                            BorderSide(color: Color.fromRGBO(162, 7, 48, 1)),
                      ),
                      hintText: "Enter Email",
                      prefixIcon: Icon(Icons.mail),
                    ),
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
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          borderSide:
                              BorderSide(color: Color.fromRGBO(162, 7, 48, 1)),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          borderSide:
                              BorderSide(color: Color.fromRGBO(162, 7, 48, 1)),
                        ),
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
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          borderSide:
                              BorderSide(color: Color.fromRGBO(162, 7, 48, 1)),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          borderSide:
                              BorderSide(color: Color.fromRGBO(162, 7, 48, 1)),
                        ),
                        hintText: "Re-enter Password",
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isVisible2 = !isVisible2;
                              });
                            },
                            icon: const Icon(Icons.remove_red_eye_sharp))),
                    obscureText: isVisible2,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: FloatingActionButton(
                        backgroundColor: const Color.fromRGBO(162, 7, 48, 1),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            registerUser(email.text, cnfpassword.text);
                          }
                        },
                        child: const Text(
                          "Register",
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
                        "Sign up with Google",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  const SizedBox(
                    height: 5,
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
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            "Sign In",
                            style:
                                TextStyle(color: Color.fromRGBO(162, 7, 48, 1)),
                          ))
                    ],
                  )
                ],
              ),
            ),
          )));
}
