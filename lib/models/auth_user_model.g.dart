// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AuthUserModelImpl _$$AuthUserModelImplFromJson(Map<String, dynamic> json) =>
    _$AuthUserModelImpl(
      uid: json['uid'] as String,
      fullName: json['fullName'] as String,
      userName: json['userName'] as String,
      phoneNumber: json['phoneNumber'] as String,
      selectedServices: (json['selectedServices'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      serviceDistance: (json['serviceDistance'] as num).toDouble(),
      schoolName: json['schoolName'] as String,
      photoURL: json['photoURL'] as String,
      selectedGrade: json['selectedGrade'] as String?,
      description: json['description'] as String,
      zipCode: json['zipCode'] as String,
      isLoggedIn: json['isLoggedIn'] as bool,
    );

Map<String, dynamic> _$$AuthUserModelImplToJson(_$AuthUserModelImpl instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'fullName': instance.fullName,
      'userName': instance.userName,
      'phoneNumber': instance.phoneNumber,
      'selectedServices': instance.selectedServices,
      'serviceDistance': instance.serviceDistance,
      'schoolName': instance.schoolName,
      'photoURL': instance.photoURL,
      'selectedGrade': instance.selectedGrade,
      'description': instance.description,
      'zipCode': instance.zipCode,
      'isLoggedIn': instance.isLoggedIn,
    };
