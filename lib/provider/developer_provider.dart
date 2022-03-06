import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../models/developer.dart';

class DeveloperProvider extends ChangeNotifier {
  DeveloperProvider();
  List<Developer>? _developers;
  List<Developer>? get developers => _developers;

  Future<String?> saveDeveloper(Developer developer) async {
    return await FirebaseFirestore.instance
        .collection('developer')
        .add(developer.toMap())
        .then((value) {
      if (_developers == null) {
        _developers = [];
      }
      developer.id = value.id;
      _developers!.add(developer);
      notifyListeners();
      return developer.id;
    });
  }

  getDevelopers() {
    FirebaseFirestore.instance.collection('developer').get().then((snapshot) {
      _developers = [];

      if (snapshot.docs.isNotEmpty) {
        snapshot.docs.forEach((element) {
          _developers!.add(Developer.fromJson(element.data(), element.id));
        });
      }
      notifyListeners();
    });
  }
}
