import 'package:flutter/material.dart';

class BlogText extends StatefulWidget {
  const BlogText({super.key});

  @override
  State<BlogText> createState() => BlogTextState();
}

enum ContentType {
  heading,
  paragraph,
  subheading,
}

class MyTextEditingController extends TextEditingController {
  final ContentType contentType;

  MyTextEditingController({required this.contentType});
}

class BlogTextState extends State<BlogText> {
  String getBlogBody() {
    String text = '';

    textControllerMap.values.toList().forEach((element) {
      if (element.contentType == ContentType.heading) {
        text = "$text<9876>${element.text}</9876>";
      } else if (element.contentType == ContentType.subheading) {
        text = "$text<5432>${element.text}</5432>";
      } else {
        text = "$text<1010>${element.text}</1010>";
      }
    });
    return text;
  }

  Map<Widget, MyTextEditingController> textControllerMap = {};

  void setTextField(String field, ContentType type) {
    FontWeight a = FontWeight.bold;
    double fontsize = 20;
    if (type == ContentType.paragraph) {
      a = FontWeight.w100;
      fontsize = 10;
    } else if (type == ContentType.subheading) {
      a = FontWeight.w600;
      fontsize = 15;
    }

    Key uniqueKey = UniqueKey();
    MyTextEditingController controller =
        MyTextEditingController(contentType: type);
    Widget textField = Row(key: uniqueKey, children: [
      Expanded(
        flex: 8,
        child: TextField(
          maxLines: null,
          style: TextStyle(
            color: Colors.white,
            fontWeight: a,
            fontSize: fontsize,
          ),
          controller: controller,
          decoration: InputDecoration(
            labelText: field,
          ),
        ),
      ),
      Expanded(
          flex: 2,
          child: TextButton(
              onPressed: () => removeTextField(uniqueKey),
              child: const Text("X")))
    ]);
    setState(() {
      setState(() {
        textControllerMap[textField] = controller;
      });
    });
  }

  void removeTextField(Key uniqueKey) {
    setState(() {
      textControllerMap.removeWhere((key, value) => key.key == uniqueKey);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ...textControllerMap.keys.toList(),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Wrap(
          // direction: Axis.horizontal,
          // alignment: WrapAlignment.spaceAround,
          // runSpacing: 10,
          spacing: 10,
          children: [
            TextButton(
              onPressed: () =>
                  setTextField("write paragraph", ContentType.paragraph),
              style: TextButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 40, 181, 113),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 0)),
              child: const Text(
                "Add Paragraph",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold),
              ),
            ),
            TextButton(
              onPressed: () =>
                  setTextField("write heading", ContentType.heading),
              style: TextButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 153, 31, 31),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 0)),
              child: const Text(
                "Add Heading",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold),
              ),
            ),
            TextButton(
              onPressed: () =>
                  setTextField("write sub heading", ContentType.subheading),
              style: TextButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 45, 70, 169),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 0)),
              child: const Text("Add Sub heading",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      )
    ]);
  }
}
