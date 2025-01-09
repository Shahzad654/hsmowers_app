// ignore_for_file: prefer_const_constructors

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'auth_user_model.freezed.dart';
part 'auth_user_model.g.dart';

@freezed
class AuthUserModel with _$AuthUserModel {
  const factory AuthUserModel({
    required String uid,
    required String fullName,
    required String userName,
    required String phoneNumber,
    required List<String> selectedServices,
    required double serviceDistance,
    required String schoolName,
    String? photoURL,
    String? selectedGrade,
    required String description,
    required String zipCode,
    required bool isLoggedIn,
  }) = _AuthUserModel;

  factory AuthUserModel.fromJson(Map<String, dynamic> json) =>
      _$AuthUserModelFromJson(json);
}

final authUserProvider = StateNotifierProvider<AuthUserNotifier, AuthUserModel>(
  (ref) => AuthUserNotifier(),
);

class AuthUserNotifier extends StateNotifier<AuthUserModel> {
  AuthUserNotifier()
      : super(
          AuthUserModel(
            uid: '',
            fullName: '',
            userName: '',
            phoneNumber: '',
            selectedServices: [],
            serviceDistance: 0.0,
            schoolName: '',
            photoURL: null,
            selectedGrade: null,
            description: '',
            zipCode: '',
            isLoggedIn: false,
          ),
        ) {
    FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user != null) {
        loadUserData();
      } else {
        clearUser();
      }
    });
    loadUserData();
  }

  Future<void> loadUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userData = await _fetchUserDataFromFirestore(user.uid);
      if (userData != null) {
        state = userData;
      }
    }
  }

  Future<AuthUserModel?> _fetchUserDataFromFirestore(String uid) async {
    try {
      final doc = await FirebaseFirestore.instance
          .collection('userInfo')
          .doc(uid)
          .get();
      if (doc.exists) {
        final data = doc.data()!;
        return AuthUserModel.fromJson({
          'uid': uid,
          'fullName': data['displayName'] ?? 'No Name',
          'userName': data['userName'] ?? 'No Username',
          'phoneNumber': data['phoneNumber'] ?? 'No Phone Number',
          'selectedServices': data['services'] ?? [],
          'serviceDistance': data['serviceDistance'] ?? 0.0,
          'schoolName': data['schoolName'] ?? 'No School',
          'photoURL': data['photoURL'],
          'selectedGrade': data['grade'],
          'description': data['description'] ?? 'No Description',
          'zipCode': data['zipCode'] ?? 'No Zip Code',
          'isLoggedIn': true,
        });
      } else {
        print("No user data found in Firestore for UID: $uid");
        return null;
      }
    } catch (e) {
      print("Error fetching user data from Firestore: $e");
      return null;
    }
  }

  void updateUser(AuthUserModel user) {
    state = user.copyWith(isLoggedIn: true);
  }

  void clearUser() {
    state = AuthUserModel(
      uid: '',
      fullName: '',
      userName: '',
      phoneNumber: '',
      selectedServices: [],
      serviceDistance: 0.0,
      schoolName: '',
      photoURL: null,
      selectedGrade: null,
      description: '',
      zipCode: '',
      isLoggedIn: false,
    );
  }
}
