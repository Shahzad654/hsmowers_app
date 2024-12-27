// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserModelImpl _$$UserModelImplFromJson(Map<String, dynamic> json) =>
    _$UserModelImpl(
      fullName: json['fullName'] as String,
      userName: json['userName'] as String,
      email: json['email'] as String,
      phoneNum: json['phoneNum'] as String,
      address: json['address'] as String,
      description: json['description'] as String,
      zipCode: json['zipCode'] as String?,
      profileImage: _fileFromJson(json['profileImage'] as String?),
      profileImageUrl: json['profileImageUrl'] as String?,
      selectedServices: (json['selectedServices'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      serviceDistance: (json['serviceDistance'] as num).toDouble(),
      schoolName: json['schoolName'] as String,
      grade: json['grade'] as String,
    );

Map<String, dynamic> _$$UserModelImplToJson(_$UserModelImpl instance) =>
    <String, dynamic>{
      'fullName': instance.fullName,
      'userName': instance.userName,
      'email': instance.email,
      'phoneNum': instance.phoneNum,
      'address': instance.address,
      'description': instance.description,
      'zipCode': instance.zipCode,
      'profileImage': _fileToJson(instance.profileImage),
      'profileImageUrl': instance.profileImageUrl,
      'selectedServices': instance.selectedServices,
      'serviceDistance': instance.serviceDistance,
      'schoolName': instance.schoolName,
      'grade': instance.grade,
    };
