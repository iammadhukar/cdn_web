import 'package:cdn_web/models/developer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/developer_provider.dart';

class DeveloperFormPage extends StatefulWidget {
  const DeveloperFormPage({Key? key}) : super(key: key);

  @override
  State<DeveloperFormPage> createState() => _DeveloperFormPageState();
}

class _DeveloperFormPageState extends State<DeveloperFormPage> {
  final _developerForm = GlobalKey<FormState>(debugLabel: 'developerForm');
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _skillController = TextEditingController();
  final TextEditingController _hobbyeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Form(
          key: _developerForm,
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _userNameController,
                      decoration: const InputDecoration(
                        hintText: 'Username',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(12.0),
                          ),
                        ),
                      ),
                      validator: (s) {
                        if (s?.isEmpty ?? true) {
                          return 'Username can not be empty';
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
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        hintText: 'Email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(12.0),
                          ),
                        ),
                      ),
                      validator: (s) {
                        if (s?.isEmpty ?? true) {
                          return 'Email can not be empty';
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
                      controller: _skillController,
                      decoration: const InputDecoration(
                        hintText: 'Skillset',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(12.0),
                          ),
                        ),
                      ),
                      validator: (s) {
                        if (s?.isEmpty ?? true) {
                          return 'Skillset can not be empty';
                        } else {
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
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _hobbyeController,
                      decoration: const InputDecoration(
                        hintText: 'Hobby',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(12.0),
                          ),
                        ),
                      ),
                      validator: (s) {
                        if (s?.isEmpty ?? true) {
                          return 'Hobby can not be empty';
                        } else {
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
                  if (_developerForm.currentState?.validate() ?? false) {
                    showDialog(
                      context: context,
                      builder: (context) => Dialog(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              CircularProgressIndicator(),
                              SizedBox(
                                height: 32.0,
                              ),
                              Text("Please wait"),
                            ],
                          ),
                        ),
                      ),
                    );
                    Developer _developer = Developer(
                      null,
                      _userNameController.text,
                      _emailController.text,
                      int.parse(_phoneController.text),
                      _skillController.text,
                      _hobbyeController.text,
                    );
                    Provider.of<DeveloperProvider>(context, listen: false)
                        .saveDeveloper(_developer)
                        .then((value) {
                      if (value != null) {
                        Navigator.pop(context);
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text("Success"),
                            content: const Text("Data uploaded successfully."),
                            actions: [
                              TextButton(
                                child: const Text("Ok"),
                                onPressed: () {
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ),
                        );
                      } else {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text("Error"),
                            content: const Text(
                                "Something went wrong. Please try again."),
                            actions: [
                              TextButton(
                                child: const Text("Ok"),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ),
                        );
                      }
                    });
                  }
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
