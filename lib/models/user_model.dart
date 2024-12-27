import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    required String fullName,
    required String userName,
    required String email,
    required String phoneNum,
    required String address,
    required String description,
    String? zipCode,
    @JsonKey(fromJson: _fileFromJson, toJson: _fileToJson) File? profileImage,
    String? profileImageUrl,
    required List<String> selectedServices,
    required double serviceDistance,
    required String schoolName,
    required String grade,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}

File? _fileFromJson(String? path) {
  if (path == null) return null;
  return File(path);
}

String? _fileToJson(File? file) {
  return file?.path;
}
