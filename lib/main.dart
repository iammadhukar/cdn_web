import 'package:cdn_web/control/enum.dart';
import 'package:cdn_web/pages/home_page.dart';
import 'package:cdn_web/pages/login_page.dart';
import 'package:cdn_web/provider/auth_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pages/login_error_page.dart';
import 'pages/sing_up_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? errorMessage;
  bool _initialized = false;
  @override
  void initState() {
    initializeFirebase();
    super.initState();
  }

  initializeFirebase() async {
    await Firebase.initializeApp().then((value) {
      setState(() {
        _initialized = true;
      });
    }).onError((error, stackTrace) {
      _initialized = false;
      setState(() {
        errorMessage = 'Error';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_initialized) {
      return const MaterialApp(
        home: Scaffold(
          body: Center(child: CircularProgressIndicator()),
        ),
      );
    }
    if (errorMessage != null) {
      return const MaterialApp(
        home: Scaffold(
          body: Center(child: Text("Error")),
        ),
      );
    }
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthProvider(),
        ),
      ],
      child: MaterialApp(
        home: Selector<AuthProvider, AuthState>(
          shouldRebuild: (prev, next) => prev != next,
          selector: (context, authProvider) => authProvider.authState,
          builder: (context, authState, _) {
            switch (authState) {
              case AuthState.needToLogin:
                return const LoginPage();
              case AuthState.loginError:
                return const LoginErrorPage();
              case AuthState.loggedIn:
                return const HomePage();
              case AuthState.profileNotFound:
                return const SignUpPage();
              default:
                return const LoginPage();
            }
          },
        ),
      ),
    );
  }
}
