import 'package:flutter/material.dart';

class Account extends StatelessWidget {
  final String email;
  final String username;
  const Account({super.key, required this.username, required this.email});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: Column(children: [
        Padding(
          padding: EdgeInsets.only(
              bottom: 30, top: MediaQuery.of(context).size.height * 0.07),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.05),
                child: Row(
                  children: [
                    const Icon(
                      Icons.account_circle,
                      size: 100,
                      color: Colors.white70,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      username,
                      style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        const Text(
          "About me",
          style: TextStyle(
              color: Colors.white70, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const Text("lorem ipsum.....................",
            style: TextStyle(
                color: Colors.white70,
                fontSize: 10,
                fontWeight: FontWeight.bold))
      ]),
    );
  }
}
