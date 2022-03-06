import 'package:cdn_web/pages/developers_page.dart';
import 'package:flutter/material.dart';

import 'developer_form_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DeveloperFormPage(),
                  ),
                );
              },
              child: const Card(
                child: Padding(
                  padding: EdgeInsets.all(32.0),
                  child: Text("Add Developers"),
                ),
              ),
            ),
            const SizedBox(
              width: 32.0,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DevelopersPage(),
                  ),
                );
              },
              child: const Card(
                child: Padding(
                  padding: EdgeInsets.all(32.0),
                  child: Text("Developers"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
