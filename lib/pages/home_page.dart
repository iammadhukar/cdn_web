import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(children: const [
        Card(
          child: Padding(
            padding: EdgeInsets.all(32.0),
            child: Text("Add Developers"),
          ),
        ),
        Card(
          child: Padding(
            padding: EdgeInsets.all(32.0),
            child: Text("Developers"),
          ),
        ),
      ]),
    );
  }
}
