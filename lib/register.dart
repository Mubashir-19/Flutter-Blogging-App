import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Register extends StatelessWidget {
  Register({super.key});
  final GlobalKey<FormState> _registerkey = GlobalKey<FormState>();

  TextEditingController remail = TextEditingController(text: '');
  TextEditingController rpassword = TextEditingController(text: '');
  TextEditingController rname = TextEditingController(text: '');
  @override
  Widget build(BuildContext context) {
    return Form(
        key: _registerkey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              controller: remail,
              decoration: const InputDecoration(
                hintText: 'Enter your Full Name',
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
            TextFormField(
              controller: rname,
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
              controller: rpassword,
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
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  // Validate will return true if the form is valid, or false if
                  // the form is invalid.
                  if (_registerkey.currentState!.validate()) {
                    print(remail.text + rpassword.text);
                  }
                },
                child: Text('Submit'),
              ),
            ),
          ],
        ));
  }
}
