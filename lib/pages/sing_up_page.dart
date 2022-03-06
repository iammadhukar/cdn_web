import 'package:cdn_web/models/auth_user.dart';
import 'package:cdn_web/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _signUpForm = GlobalKey<FormState>(debugLabel: 'SignUp');
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 64.0),
        child: Center(
          child: Form(
            key: _signUpForm,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          hintText: 'Name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(12.0),
                            ),
                          ),
                        ),
                        validator: (s) {
                          if (s?.isEmpty ?? true) {
                            return 'Name can not be empty';
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 32,
                    ),
                    Expanded(
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
                          if (s?.isEmpty ?? true) {
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
                  ],
                ),
                const SizedBox(
                  height: 32,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_signUpForm.currentState?.validate() ?? false) {
                      AuthUser _user = AuthUser(
                        null,
                        _nameController.text,
                        int.parse(_phoneController.text),
                      );
                      Provider.of<AuthProvider>(context, listen: false)
                          .saveSignUpData(_user);
                    }
                  },
                  child: const Text('Save'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
