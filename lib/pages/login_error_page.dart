import 'package:cdn_web/pages/login_page.dart';
import 'package:flutter/material.dart';

class LoginErrorPage extends StatelessWidget {
  const LoginErrorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Text('Something went wrong. Please try again after some time'),
          const SizedBox(
            height: 32,
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginPage(),
                  ),
                );
              },
              child: const Text("Login Again"))
        ],
      ),
    );
  }
}
