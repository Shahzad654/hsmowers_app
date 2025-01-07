// ignore_for_file: prefer_const_constructors

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:hsmowers_app/models/auth_user_model.dart';
part 'auth_user_provider.g.dart';

@riverpod
class AuthUser extends _$AuthUser {
  @override
  AuthUserModel build() {
    return AuthUserModel(
      uid: '',
      fullName: '',
      userName: '',
      phoneNumber: '',
      selectedServices: [],
      serviceDistance: 0.0,
      schoolName: '',
      photoURL: '',
      selectedGrade: null,
      description: '',
      zipCode: '',
      isLoggedIn: false,
    );
  }

  void addUserInfo({
    required String uid,
    required String fullName,
    required String userName,
    required String phoneNumber,
    required List<String> selectedServices,
    required double serviceDistance,
    required String schoolName,
    required String photoURL,
    String? selectedGrade,
    required String description,
    required String zipCode,
    required bool isLoggedIn,
  }) {
    state = AuthUserModel(
      uid: uid,
      fullName: fullName,
      userName: userName,
      phoneNumber: phoneNumber,
      selectedServices: selectedServices,
      serviceDistance: serviceDistance,
      schoolName: schoolName,
      selectedGrade: selectedGrade,
      photoURL: photoURL,
      description: description,
      zipCode: zipCode,
      isLoggedIn: isLoggedIn,
    );
  }
}
