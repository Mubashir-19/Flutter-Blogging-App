import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:se_project/main.dart';
import 'package:se_project/widgets/blogtext.dart';
import 'package:se_project/widgets/imagePicker.dart';

class CreateBlog extends StatelessWidget {
  final String author;
  final String authorid;
  final Function getItem;

  CreateBlog(
      {super.key,
      required this.author,
      required this.authorid,
      required this.getItem});
  final GlobalKey<FormState> _registerkey = GlobalKey<FormState>();

  TextEditingController title = TextEditingController(text: '');
  TextEditingController description = TextEditingController(text: '');
  TextEditingController tags = TextEditingController(text: '');

  XFile? image;

//   Future<String> cropAndCompressImage(XFile imageFile) async {
//     // Load the image using the image package
//     List<int> bytes = await imageFile.readAsBytes();
//     img.Image? originalImage = img.decodeImage(Uint8List.fromList(bytes));
//     // Get original image dimensions
//     int originalWidth = originalImage!.width;
//     int originalHeight = originalImage.height;

//     // Scale the image up if the resolution is lower than the target crop size
//     double scale = 1.0;
//     if (originalWidth < 1280 || originalHeight < 720) {
//       scale = 1280 / originalWidth;
//       if (originalHeight * scale < 720) {
//         scale = 720 / originalHeight;
//       }
//     }

//     // Apply scaling if needed
//     if (scale != 1.0) {
//       originalImage =
//           img.copyResize(originalImage, width: (originalWidth * scale).round());
//     }
//     // Crop the image to 1280x720
//     img.Image croppedImage = img.copyCrop(originalImage!, 0, 0, 1280, 720);

//     // Compress the image
//     List<int> compressedBytes = await FlutterImageCompress.compressWithList(
//       croppedImage.getBytes(),
//       quality: 85, // Adjust the quality as needed (0 to 100)
//     );

// // Get the original file path and name
//     String originalFilePath = imageFile.path;
//     String originalFileName = originalFilePath.split('/').last;

//     // Create a new file path for the compressed image
//     String compressedFilePath = originalFilePath.replaceFirst(
//         originalFileName, '${originalFileName}_compress.jpg');

//     // Save the compressed image to the same path with a new name
//     File compressedFile = File(compressedFilePath);
//     await compressedFile.writeAsBytes(compressedBytes);

//     return compressedFilePath;
//   }

  Future<String> uploadImageToCloudinary(String path) async {
    var cloudinaryUrl =
        'https://api.cloudinary.com/v1_1/dgixhggt0/image/upload';
    var apiKey = '562691868772357';
    // var apiSecret = '8OZ2vxLiWd_f3hVMDM-mBlIloA0';
    // final cloudinary = CloudinaryObject.fromCloudName(cloudName: 'dgixhggt0');
    var request = http.MultipartRequest('POST', Uri.parse(cloudinaryUrl))
      ..fields.addAll({
        'upload_preset':
            'e9gzbdu1', // You need to create an upload preset in your Cloudinary dashboard
        'api_key': apiKey,
      })
      ..files.add(
        await http.MultipartFile.fromPath('file', path),
      );

    final resp = await request.send();

    final sdata = String.fromCharCodes(await resp.stream.toBytes());
    final jsonMap = jsonDecode(sdata);

    // print(jsonMap['url']);
    return jsonMap['url'];

    // print(resp);
  }

  final GlobalKey<BlogTextState> childKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // backgroundColor: const Color.fromARGB(255, 228, 240, 248),
          // actionsIconTheme: const IconThemeData(color: Colors.white),
          // iconTheme: const IconThemeData(color: Colors.white),
          ),
      // backgroundColor: Colors.black38,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.only(right: 15, left: 15),
        // color: Color.fromARGB(255, 219, 219, 219),
        child: Form(
            key: _registerkey,
            child: ListView(
              children: <Widget>[
                ImagePickerWidget(
                    onImageSelected: (XFile image) {
                      this.image = image;
                    },
                    text: image == null ? "Pick Image" : "Selected"),
                TextFormField(
                  controller: title,
                  // style: const TextStyle(
                  //     color: Color.fromARGB(255, 219, 219, 219)),
                  decoration: const InputDecoration(
                    hintStyle:
                        TextStyle(color: Color.fromARGB(255, 160, 160, 160)),
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
                  controller: description,
                  // style: const TextStyle(
                  //     color: Color.fromARGB(255, 219, 219, 219)),
                  decoration: const InputDecoration(
                    hintStyle:
                        TextStyle(color: Color.fromARGB(255, 160, 160, 160)),
                    hintText: 'Enter Blog Description',
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                const Text(
                  "Blog Body",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                BlogText(
                  key: childKey,
                ),

                // TextFormField(
                //   controller: text,
                //   obscureText: true,
                //   style: const TextStyle(color: Color.fromARGB(255, 219, 219, 219)),
                //   decoration: const InputDecoration(
                //     hintStyle: TextStyle(color: Colors.white38),
                //     hintText: 'Enter Blog text',
                //   ),
                //   validator: (String? value) {
                //     if (value == null || value.isEmpty) {
                //       return 'Please enter some text';
                //     }
                //     return null;
                //   },
                // ),
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
                        // print(title.text + description.text);

                        // await cropAndCompressImage(image);

                        String text = childKey.currentState!.getBlogBody();

                        if (text == '') {
                          QuickAlert.show(
                              context: context,
                              type: QuickAlertType.error,
                              text: "Blog cannot be empty");

                          return;
                        }
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return const AlertDialog(
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CircularProgressIndicator(),
                                    SizedBox(height: 16),
                                    Text('Loading...'),
                                  ],
                                ),
                              );
                            });
                        final img = image == null
                            ? "https://www.seoclerk.com/pics/653973-1pMc8u1548606687.jpg"
                            : await uploadImageToCloudinary(image!.path);

                        final response = await http.post(
                          Uri.parse('${dotenv.env['host']}/createpost'),
                          headers: {'Content-Type': 'application/json'},
                          body: jsonEncode({
                            "authorid": authorid,
                            "author": author,
                            "text": text,
                            "description": description.text,
                            "title": title.text,
                            "img": img
                            // Your request body here
                          }),
                        );
                        // print(response.body);
                        var a = jsonDecode(response.body);
                        // print(response.body);
                        if (context.mounted) {
                          if (response.statusCode == 200) {
                            Provider.of<ItemsModel>(context, listen: false)
                                .addItem(a);
                            Provider.of<LikesModel>(context, listen: false)
                                .addLike(a["id"]);
                            getItem();
                            Navigator.of(context, rootNavigator: true).pop();
                            QuickAlert.show(
                                context: context, type: QuickAlertType.success);
                            // pushItem(a);
                          } else {
                            Navigator.of(context, rootNavigator: true).pop();
                            Future.delayed(const Duration(milliseconds: 500));
                            QuickAlert.show(
                                context: context,
                                type: QuickAlertType.error,
                                title: "Error creating blog, please try later");
                          }
                          Navigator.pop(context);
                        }
                        // if (context.mounted) {
                        //   Navigator.of(context, rootNavigator: true).pop();
                        // }
                        // Navigator.of(context).pop();
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
