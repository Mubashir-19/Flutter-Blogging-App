import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerWidget extends StatefulWidget {
  final Function(XFile) onImageSelected;
  final String text;
  final TextStyle textStyle;
  const ImagePickerWidget(
      {required this.onImageSelected,
      this.text = "Pick Image",
      this.textStyle = const TextStyle(),
      super.key});

  @override
  State<ImagePickerWidget> createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  XFile? image;
  // TextEditingController tags = TextEditingController(text: '');
  void pickImage() async {
    final ImagePicker picker = ImagePicker();
// Pick an image.
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    // print(pickedImage);
    if (pickedImage != null) {
      widget.onImageSelected(pickedImage);
      setState(() {
        image = pickedImage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: pickImage,
      child: Text(
        widget.text,
        style: widget.textStyle,
      ),
    );
  }
}
