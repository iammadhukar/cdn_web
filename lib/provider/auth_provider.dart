import 'dart:html';

import 'package:cdn_web/control/enum.dart';
import 'package:cdn_web/models/auth_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AuthProvider extends ChangeNotifier {
  AuthProvider() {
    checkUserAuthenticated();
  }
  User? currentUser;
  FirebaseAuth auth = FirebaseAuth.instance;
  AuthState authState = AuthState.initState;
  AuthUser? _authUser;
  AuthUser? get authUser => _authUser;
  ConfirmationResult? confirmationResult;

  checkUserAuthenticated() {
    currentUser = auth.currentUser;
    if (currentUser == null) {
      authState = AuthState.needToLogin;
      notifyListeners();
    } else {
      getAdminProfile(currentUser?.uid);
    }
  }

  signInWithPhoneNumber(String phoneNumber) async {
    confirmationResult = await auth.signInWithPhoneNumber('+91' + phoneNumber);
  }

  confirmOtp(String otpCode) {
    confirmationResult?.confirm(otpCode).then((value) {
      authState = AuthState.fetchingProfile;
      getAdminProfile(value.user?.uid);
    }).onError((error, stackTrace) {
      authState = AuthState.loginError;
    });
  }

  getAdminProfile(String? id) {
    FirebaseFirestore.instance
        .collection('admin')
        .doc(id)
        .get()
        .then((snapshot) {
      if (snapshot.exists) {
        authState = AuthState.loggedIn;
        _authUser = AuthUser.fromJson(snapshot.data()!);
      } else {
        authState = AuthState.profileNotFound;
      }
      notifyListeners();
    });
  }

  saveSignUpData(AuthUser user) {
    user.uid = currentUser?.uid;
    FirebaseFirestore.instance
        .collection('admin')
        .doc(currentUser?.uid)
        .set(user.toMap())
        .then((value) {
      authState = AuthState.loggedIn;
      notifyListeners();
    });
  }
}
