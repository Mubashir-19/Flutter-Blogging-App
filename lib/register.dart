import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:quickalert/quickalert.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:se_project/login.dart';

// ignore: must_be_immutable
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

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 50),
            child: Center(
              child: Text(
                "Register",
                style: TextStyle(
                    fontSize: 40,
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.w700),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Form(
                key: _registerkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: TextFormField(
                        controller: rname,
                        decoration: const InputDecoration(
                          hintText: 'Enter your Username',
                        ),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Required';
                          }
                          return null;
                        },
                      ),
                    ),
                    TextFormField(
                      controller: remail,
                      decoration: const InputDecoration(
                        hintText: 'Enter your email',
                      ),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Required';
                        }
                        return null;
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: TextFormField(
                        controller: rpassword,
                        obscureText: true,
                        decoration: const InputDecoration(
                          hintText: 'Enter your Password',
                        ),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Required';
                          }
                          return null;
                        },
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        // Validate will return true if the form is valid, or false if
                        // the form is invalid.
                        if (_registerkey.currentState!.validate()) {
                          // print(remail.text + rpassword.text);

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

                          if (response.statusCode == 200) {
                            // print('Response: ${response.body}');
                            showAlert();
                          } else {
                            print(
                                'Request failed with status: ${response.statusCode}');
                          }
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 30),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 1,
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.deepPurple),
                          child: Center(
                              child: const Text(
                            'Submit',
                            style: TextStyle(color: Colors.white, fontSize: 23),
                          )),
                        ),
                      ),
                    ),
                  ],
                )),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an Acoount?  ",
                      style: TextStyle(fontSize: 18),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Login()));
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(
                            color: Colors.deepPurple,
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
