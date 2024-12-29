import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:io';

part 'user_info_model.freezed.dart';
part 'user_info_model.g.dart';

class FileConverter implements JsonConverter<File?, String?> {
  const FileConverter();

  @override
  File? fromJson(String? json) {
    if (json == null) return null;
    return File(json);
  }

  @override
  String? toJson(File? file) {
    return file?.path;
  }
}

@freezed
class UserInfoModel with _$UserInfoModel {
  const factory UserInfoModel({
    required String fullName,
    required String userName,
    required String phoneNumber,
    required List<String> selectedServices,
    required double serviceDistance,
    required String schoolName,
    String? selectedGrade,
    @FileConverter() File? profileImage,
    required String description,
    required String zipCode,
  }) = _UserInfoModel;

  factory UserInfoModel.fromJson(Map<String, dynamic> json) =>
      _$UserInfoModelFromJson(json);
}
