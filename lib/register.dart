import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:quickalert/quickalert.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Register extends StatelessWidget {
  Register({super.key});
  final GlobalKey<FormState> _registerkey = GlobalKey<FormState>();

  TextEditingController remail = TextEditingController(text: '');
  TextEditingController rpassword = TextEditingController(text: '');
  TextEditingController rname = TextEditingController(text: '');
  @override
  Widget build(BuildContext context) {
    void showAlert() {
      QuickAlert.show(context: context, type: QuickAlertType.success);
    }

    return Form(
        key: _registerkey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              controller: rname,
              style: const TextStyle(color: Colors.black),
              decoration: const InputDecoration(
                hintStyle: TextStyle(color: Colors.grey),
                hintText: 'Enter your Username',
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Required';
                }
                return null;
              },
            ),
            TextFormField(
              controller: remail,
              style: const TextStyle(color: Colors.black),
              decoration: const InputDecoration(
                hintStyle: TextStyle(color: Colors.grey),
                hintText: 'Enter your email',
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Required';
                }
                return null;
              },
            ),
            TextFormField(
              controller: rpassword,
              obscureText: true,
              style: const TextStyle(color: Colors.black),
              decoration: const InputDecoration(
                hintStyle: TextStyle(color: Colors.grey),
                hintText: 'Enter your Password',
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Required';
                }
                return null;
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateColor.resolveWith(
                        (states) => const Color(0xffe8e8e8))),
                onPressed: () async {
                  // Validate will return true if the form is valid, or false if
                  // the form is invalid.
                  if (_registerkey.currentState!.validate()) {
                    // print(remail.text + rpassword.text);
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const AlertDialog(
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CircularProgressIndicator(),
                                SizedBox(height: 16),
                                Text('Registering...'),
                              ],
                            ),
                          );
                        });
                    final response = await http.post(
                      Uri.parse('${dotenv.env['host']}/signup'),
                      headers: {'Content-Type': 'application/json'},
                      body: jsonEncode({
                        "email": remail.text,
                        "password": rpassword.text,
                        "username": rname.text
                        // Your request body here
                      }),
                    );
                    if (context.mounted) {
                      Navigator.of(context, rootNavigator: true).pop();
                    }
                    if (response.statusCode == 200) {
                      // print('Response: ${response.body}');
                      showAlert();
                    } else if (response.statusCode == 500) {
                      if (context.mounted) {
                        QuickAlert.show(
                            title: "Service down, please try later",
                            context: context,
                            type: QuickAlertType.info);
                      }
                      // print(response.body);
                    }
                  }
                },
                child: const Text('Submit'),
              ),
            ),
          ],
        ));
  }
}
