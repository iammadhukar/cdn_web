import 'package:cdn_web/control/enum.dart';
import 'package:cdn_web/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  final PageController _pageController = PageController();
  final _formKey1 = GlobalKey<FormState>(debugLabel: 'Phone');
  final _formKey2 = GlobalKey<FormState>(debugLabel: 'Phone');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: [
          Form(
            key: _formKey1,
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 300,
                    child: TextFormField(
                      controller: _phoneController,
                      decoration: const InputDecoration(
                        hintText: 'Phone Number',
                        prefixText: '+91',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(12.0),
                          ),
                        ),
                      ),
                      validator: (s) {
                        if (s == null) {
                          return 'Phone number can not be empty';
                        } else {
                          if (!RegExp(r"^[6-9]\d{9}$")
                              .hasMatch(_phoneController.text)) {
                            return 'Not a valid phone number';
                          }
                          return null;
                        }
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 32.0,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey1.currentState?.validate() ?? false) {
                        Provider.of<AuthProvider>(context, listen: false)
                            .signInWithPhoneNumber(_phoneController.text);
                        setState(() {
                          _pageController.jumpToPage(1);
                        });
                      }
                    },
                    child: const Text('Login'),
                  ),
                ],
              ),
            ),
          ),
          Form(
            key: _formKey2,
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Phone: ${_phoneController.text}",
                    style: const TextStyle(color: Colors.black),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  SizedBox(
                    width: 300,
                    child: TextFormField(
                      controller: _otpController,
                      decoration: const InputDecoration(
                        hintText: 'Otp',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(12.0),
                          ),
                        ),
                      ),
                      validator: (s) {
                        if (s == null) {
                          return 'Otp can not be empty';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 32.0,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey2.currentState?.validate() ?? false) {
                        showDialog(
                          context: context,
                          builder: (context) => StatefulBuilder(
                            builder: (context, setState) {
                              return Dialog(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 32.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const CircularProgressIndicator(),
                                      const SizedBox(
                                        height: 32,
                                      ),
                                      Selector<AuthProvider, AuthState>(
                                        shouldRebuild: (prev, next) =>
                                            prev != next,
                                        selector: (context, authProvider) =>
                                            authProvider.authState,
                                        builder: (context, authState, _) {
                                          switch (authState) {
                                            case AuthState.fetchingProfile:
                                              return const Text(
                                                  "Fetching Profile..");
                                            case AuthState.initState:
                                              return const Text("Please wait");
                                            default:
                                              return const Text("Please wait");
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                        Provider.of<AuthProvider>(context, listen: false)
                            .confirmOtp(_otpController.text);
                      }
                    },
                    child: const Text('Submit'),
                  ),
                  SizedBox(
                    width: 400,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            _pageController.jumpToPage(0);
                          },
                          icon: const Icon(Icons.arrow_back),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text('ReSend'),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
