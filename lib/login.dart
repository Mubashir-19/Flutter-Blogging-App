import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// ignore: must_be_immutable
class Login extends StatelessWidget {
  Login({super.key});
  final GlobalKey<FormState> _signinkey = GlobalKey<FormState>();
  TextEditingController semail = TextEditingController(text: '');
  TextEditingController spassword = TextEditingController(text: '');

  Future<void> sendPostRequest() async {
    var response =
        await http.post(Uri.parse("http://192.168.100.9:4000/signin"),
            headers: {"Content-Type": "application/json"},
            body: jsonEncode({
              "email": semail.text,
              "password": spassword.text,
            }));

    if (kDebugMode) {
      print(response.statusCode);
      print(response.body);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _signinkey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              controller: semail,
              decoration: const InputDecoration(
                hintText: 'Enter your email',
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
            TextFormField(
              controller: spassword,
              obscureText: true,
              decoration: const InputDecoration(
                hintText: 'Enter your Password',
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  // Validate will return true if the form is valid, or false if
                  // the form is invalid.
                  if (_signinkey.currentState!.validate()) {
                    // print(semail.text + spassword.text);

                    sendPostRequest();
                  }
                },
                child: const Text('Submit'),
              ),
            ),
          ],
        ));
  }
}
