import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/developer.dart';
import '../provider/developer_provider.dart';

class DevelopersPage extends StatefulWidget {
  const DevelopersPage({Key? key}) : super(key: key);

  @override
  State<DevelopersPage> createState() => _DevelopersPageState();
}

class _DevelopersPageState extends State<DevelopersPage> {
  @override
  void initState() {
    Provider.of<DeveloperProvider>(context, listen: false).getDevelopers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Developers",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 32.0,
            ),
            Expanded(
              child: Selector<DeveloperProvider, List<Developer>?>(
                shouldRebuild: (prev, next) => true,
                selector: (context, developerProvider) =>
                    developerProvider.developers,
                builder: (context, developers, _) {
                  if (developers == null) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (developers.isEmpty) {
                    return const Center(
                      child: Text('No developer found'),
                    );
                  } else {
                    return GridView.builder(
                      shrinkWrap: true,
                      itemCount: developers.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 2,
                        crossAxisSpacing: 16.0,
                        mainAxisSpacing: 16.0,
                      ),
                      itemBuilder: (context, index) {
                        return Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                              border: Border.all(width: 1),
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(12.0))),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text.rich(
                                TextSpan(
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16.0,
                                    ),
                                    children: [
                                      const TextSpan(
                                        text: 'UserName: ',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      TextSpan(
                                          text: developers[index].userName),
                                    ]),
                              ),
                              const SizedBox(
                                height: 8.0,
                              ),
                              Text.rich(
                                TextSpan(
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16.0,
                                    ),
                                    children: [
                                      const TextSpan(
                                        text: 'Email: ',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      TextSpan(text: developers[index].email),
                                    ]),
                              ),
                              const SizedBox(
                                height: 8.0,
                              ),
                              Text.rich(
                                TextSpan(
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16.0,
                                    ),
                                    children: [
                                      const TextSpan(
                                        text: 'Phone: ',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      TextSpan(
                                          text: developers[index]
                                              .phone
                                              .toString()),
                                    ]),
                              ),
                              const SizedBox(
                                height: 8.0,
                              ),
                              Text.rich(
                                TextSpan(
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16.0,
                                    ),
                                    children: [
                                      const TextSpan(
                                        text: 'Skillset: ',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      TextSpan(
                                          text: developers[index].skillSet),
                                    ]),
                              ),
                              const SizedBox(
                                height: 8.0,
                              ),
                              Text.rich(
                                TextSpan(
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16.0,
                                    ),
                                    children: [
                                      const TextSpan(
                                        text: 'Hobby: ',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      TextSpan(text: developers[index].hobby),
                                    ]),
                              ),
                              const SizedBox(
                                height: 8.0,
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
