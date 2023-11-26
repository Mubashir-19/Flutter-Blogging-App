import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(88),
        child: Container(
          color: Colors.black,
          height: 60,
          child: Padding(
              padding: const EdgeInsets.only(top: 25),
              child: Container(
                color: Colors.blue,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text("Title"),
                    Text("Signin/Signup"),
                    Text("Settings"),
                  ],
                ),
              )),
        ),
      ),
      body: Column(children: [
        Container(
          color: Colors.amber,
          child: Row(
            children: [
              Container(
                child: Text("asd"),
              )
            ],
          ),
        )
      ]),
    );
  }
}
