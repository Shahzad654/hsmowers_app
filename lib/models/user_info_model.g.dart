// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserInfoModelImpl _$$UserInfoModelImplFromJson(Map<String, dynamic> json) =>
    _$UserInfoModelImpl(
      fullName: json['fullName'] as String,
      userName: json['userName'] as String,
      phoneNumber: json['phoneNumber'] as String,
      selectedServices: (json['selectedServices'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      serviceDistance: (json['serviceDistance'] as num).toDouble(),
      schoolName: json['schoolName'] as String,
      selectedGrade: json['selectedGrade'] as String?,
      profileImage:
          const FileConverter().fromJson(json['profileImage'] as String?),
      description: json['description'] as String,
      zipCode: json['zipCode'] as String,
    );

Map<String, dynamic> _$$UserInfoModelImplToJson(_$UserInfoModelImpl instance) =>
    <String, dynamic>{
      'fullName': instance.fullName,
      'userName': instance.userName,
      'phoneNumber': instance.phoneNumber,
      'selectedServices': instance.selectedServices,
      'serviceDistance': instance.serviceDistance,
      'schoolName': instance.schoolName,
      'selectedGrade': instance.selectedGrade,
      'profileImage': const FileConverter().toJson(instance.profileImage),
      'description': instance.description,
      'zipCode': instance.zipCode,
    };
