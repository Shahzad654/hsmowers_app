// ignore_for_file: prefer_const_constructors

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:hsmowers_app/models/user_info_model.dart';
import 'dart:io';
part 'user_info_provider.g.dart';

@riverpod
class UserInfo extends _$UserInfo {
  @override
  UserInfoModel build() {
    return UserInfoModel(
      fullName: '',
      userName: '',
      phoneNumber: '',
      selectedServices: [],
      serviceDistance: 0.0,
      schoolName: '',
      selectedGrade: null,
      profileImage: null,
      description: '',
      zipCode: '',
    );
  }

  void addUserInfo({
    required String fullName,
    required String userName,
    required String phoneNumber,
    required List<String> selectedServices,
    required double serviceDistance,
    required String schoolName,
    String? selectedGrade,
    File? profileImage,
    required String description,
    required String zipCode,
  }) {
    state = UserInfoModel(
      fullName: fullName,
      userName: userName,
      phoneNumber: phoneNumber,
      selectedServices: selectedServices,
      serviceDistance: serviceDistance,
      schoolName: schoolName,
      selectedGrade: selectedGrade,
      profileImage: profileImage,
      description: description,
      zipCode: zipCode,
    );
  }
}
