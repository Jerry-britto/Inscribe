import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final emailController = TextEditingController();
  displayMessage(String message) => showDialog(
      context: context,
      builder: (_) => AlertDialog(
            content: Text(message),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Ok"))
            ],
          ));
  Future passwordReset(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email).then(
          (value) =>
              displayMessage("Password Reset link sent! Check your email"));
    } catch (e) {
      displayMessage("Failed to send the pasword reset link");
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Forgot Password"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: <Widget>[
            TextFormField(
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
              controller: emailController,
              decoration: const InputDecoration(
                hintText: "Enter email",
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            FloatingActionButton.extended(
              onPressed: () async {
                await passwordReset(emailController.text.toLowerCase().trim());
              },
              label: const Text("Reset your password"),
            )
          ],
        ),
      ),
    );
  }
}
