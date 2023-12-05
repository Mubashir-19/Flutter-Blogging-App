import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart' as path;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CreateBlog extends StatelessWidget {
  String author;
  CreateBlog(this.author, {super.key});
  final GlobalKey<FormState> _registerkey = GlobalKey<FormState>();

  TextEditingController title = TextEditingController(text: '');
  TextEditingController description = TextEditingController(text: '');
  TextEditingController text = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        actionsIconTheme: const IconThemeData(color: Colors.white),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      // backgroundColor: Colors.black38,
      body: Container(
        color: Colors.black87,
        child: Form(
            key: _registerkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  controller: title,
                  style: const TextStyle(color: Colors.white70),
                  decoration: const InputDecoration(
                    hintStyle: TextStyle(color: Colors.white38),
                    hintText: 'Enter Blog Title',
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: text,
                  style: const TextStyle(color: Colors.white70),
                  decoration: const InputDecoration(
                    hintStyle: TextStyle(color: Colors.white38),
                    hintText: 'Enter Blog Description',
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: description,
                  obscureText: true,
                  style: const TextStyle(color: Colors.white70),
                  decoration: const InputDecoration(
                    hintStyle: TextStyle(color: Colors.white38),
                    hintText: 'Enter Blog text',
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
                    style: ButtonStyle(
                        backgroundColor: MaterialStateColor.resolveWith(
                            (states) => const Color(0xffe8e8e8))),
                    onPressed: () async {
                      // Validate will return true if the form is valid, or false if
                      // the form is invalid.

                      if (_registerkey.currentState!.validate()) {
                        print(title.text + description.text);
//                         String currentDirectory = Directory.current.path;
//                         print(currentDirectory);
//                         // Create the path to the blogData.json file
//                         String blogDataPath = path.join(
//                             currentDirectory, '..', 'temp', 'blogdata.json');

//                         final file = File(blogDataPath);
// // var data = await json.decode(file);

//                         final jsonData = {
//                           "title": title.text,
//                           "author": author,
//                           "text": text.text,
//                           "description": description.text,
//                           "tags": [],
//                           "id": UniqueKey().hashCode,
//                           "date": DateTime.now().toString(),
//                           "upvotes": 0,
//                           "comments": []
//                         };
//                         final jsonString = jsonEncode(jsonData);
//                         if (file.existsSync()) {
//                           // Read existing data from the file
//                           final existingData =
//                               jsonDecode(file.readAsStringSync())
//                                   as List<dynamic>;

//                           // Append the new data
//                           existingData.add(jsonData);

//                           // Write the updated data back to the file
//                           file.writeAsStringSync(jsonEncode(existingData));
//                         } else {
//                           // If the file doesn't exist, create a new file with the current data
//                           file.writeAsStringSync('[$jsonString]');
//                         }
                      }
                    },
                    child: const Text('Submit'),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
