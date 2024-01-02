import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:provider/provider.dart';
import 'package:se_project/auth.dart';
import 'package:se_project/main.dart';
import 'package:se_project/widgets/imagePicker.dart';
import 'package:se_project/widgets/postwidget.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Account extends StatefulWidget {
  final String email;
  final String username;
  final String authorid;
  final Function setAvatarHome;
  final String avatar;

  const Account(
      {super.key,
      required this.authorid,
      required this.username,
      required this.avatar,
      required this.email,
      required this.setAvatarHome});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  List<String> myLikes = [];
  dynamic items;
  late String avatar = '';

  void setImage(XFile img) async {
    final String image = await uploadImageToCloudinary(img.path);
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("avatar", image);
    setState(() {
      avatar = image;
    });
    widget.setAvatarHome(image);
    http.post(
      Uri.parse('${dotenv.env['host']}/updateAvatar'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "id": widget.authorid,
        "avatar": avatar
        // Your request body here
      }),
    );
  }

  Future<String> uploadImageToCloudinary(String path) async {
    File file = File(path);
    Uint8List imageData = await file.readAsBytes();

    Uint8List result = await FlutterImageCompress.compressWithList(
      imageData,
      minHeight: 200,
      minWidth: 200,
      quality: 80,
    );

    // print(result);

    var cloudinaryUrl =
        'https://api.cloudinary.com/v1_1/dgixhggt0/image/upload';
    var apiKey = '562691868772357';
    // var apiSecret = '8OZ2vxLiWd_f3hVMDM-mBlIloA0';
    // final cloudinary = CloudinaryObject.fromCloudName(cloudName: 'dgixhggt0');
    try {
      var request = http.MultipartRequest('POST', Uri.parse(cloudinaryUrl))
        ..fields.addAll({
          'upload_preset':
              'e9gzbdu1', // You need to create an upload preset in your Cloudinary dashboard
          'api_key': apiKey,
        })
        ..files.add(
          http.MultipartFile.fromBytes(
            'file',
            Uint8List.fromList(result),
            filename: 'compressed_image.jpg',
          ),
        );

      final resp = await request.send();
      var responseData = await resp.stream.toBytes();
      var responseString = utf8.decode(responseData);
      var jsonResponse = json.decode(responseString);
      // print(responseString);
      // final sdata = String.fromCharCodes(await resp.stream.toBytes());
      // final jsonMap = jsonDecode(sdata);

      // print(jsonMap['url']);
      return jsonResponse['url'];
    } catch (e) {
      return '';
    }

    // print(resp);
  }

  @override
  void initState() {
    super.initState();
    // Your function call goes here
    init();
  }

  void init() async {
    avatar = widget.avatar;
    myLikes = context.mounted
        ? Provider.of<LikesModel>(context, listen: false).myLikes
        : [];
    items = context.mounted
        ? Provider.of<ItemsModel>(context, listen: false)
            .items
            .where((element) => element["authorid"] == widget.authorid)
        : {};
    // final prefs = await SharedPreferences.getInstance();
    // avatar = prefs.getString("avatar") ?? avatar;
    // print(avatar);
  }
  // Future<void> _pickImage() async {
  //   final pickedFile =
  //       await ImagePicker().getImage(source: ImageSource.gallery);

  //   setState(() {
  //     if (pickedFile != null) {
  //       _image = File(pickedFile.path);
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      Padding(
        padding: EdgeInsets.only(
            bottom: 30,
            top: MediaQuery.of(context).size.height * 0.07,
            left: MediaQuery.of(context).size.width * 0.05,
            right: MediaQuery.of(context).size.width * 0.05),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                ClipOval(
                  child: CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(avatar == ''
                        ? "https://w7.pngwing.com/pngs/215/58/png-transparent-computer-icons-google-account-scalable-graphics-computer-file-my-account-icon-rim-123rf-symbol-thumbnail.png"
                        : avatar),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: 15,
                        width: 60,
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(136, 0, 0, 0),
                            borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(
                                  100), // Adjust the radius for the half-circle effect
                            )),
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: ImagePickerWidget(
                              onImageSelected: (XFile img) => setImage(img),
                              text: "Update",
                              textStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 7,
                              )

                              //   "Update",
                              //   style: TextStyle(
                              //     color: Colors.white,
                              //     fontSize: 7,
                              //   ),
                              ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  widget.username,
                  style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            // const Spacer(),
            IconButton(
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.remove('authorid');
                await prefs.remove('email');
                await prefs.remove('username');
                if (context.mounted) {
                  Provider.of<ItemsModel>(context, listen: false).clear();
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) =>
                          const SplashScreen(), // Replace AuthPage with the actual name of your authentication page
                    ),
                  );
                }
              },
              icon: const Icon(
                Icons.logout,
                color: Colors.black,
              ),
            )
          ],
        ),
      ),
      // const Text(
      //   "About me",
      //   style: TextStyle(
      //       color: Color.fromARGB(255, 219, 219, 219),
      //       fontSize: 20,
      //       fontWeight: FontWeight.bold),
      // ),
      Container(
        decoration: BoxDecoration(
            border: Border(
                top: BorderSide(
          color: Colors.black45,
        ))),
        child: const Padding(
          padding: EdgeInsets.only(top: 10.0, bottom: 5, left: 20),
          child: Text("My Posts",
              style: TextStyle(
                  color: Colors.black87,
                  fontSize: 30,
                  fontWeight: FontWeight.bold)),
        ),
      ),
      ...[
        for (var item in items)
          PostWidget(
            like: myLikes.contains(item["id"]),
            postId: item["id"],
            image: item["img"],
            description: item["description"],
            // key: Key(item["id"]),
            id: item["authorid"],
            title: item["title"],
            likes: item["likes"],
            author: item["author"],
            avatar: avatar,
            comments: [],
            text: item["text"],
          )
      ]
    ]);
  }
}
