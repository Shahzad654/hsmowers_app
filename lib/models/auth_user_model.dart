import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:io';

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
    required String photoURL,
    String? selectedGrade,
    required String description,
    required String zipCode,
    required bool isLoggedIn,
  }) = _AuthUserModel;

  factory AuthUserModel.fromJson(Map<String, dynamic> json) =>
      _$AuthUserModelFromJson(json);
}
