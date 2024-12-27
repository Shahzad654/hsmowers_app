// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return _UserModel.fromJson(json);
}

/// @nodoc
mixin _$UserModel {
  String get fullName => throw _privateConstructorUsedError;
  String get userName => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get phoneNum => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String? get zipCode => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _fileFromJson, toJson: _fileToJson)
  File? get profileImage => throw _privateConstructorUsedError;
  String? get profileImageUrl => throw _privateConstructorUsedError;
  List<String> get selectedServices => throw _privateConstructorUsedError;
  double get serviceDistance => throw _privateConstructorUsedError;
  String get schoolName => throw _privateConstructorUsedError;
  String get grade => throw _privateConstructorUsedError;

  /// Serializes this UserModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserModelCopyWith<UserModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserModelCopyWith<$Res> {
  factory $UserModelCopyWith(UserModel value, $Res Function(UserModel) then) =
      _$UserModelCopyWithImpl<$Res, UserModel>;
  @useResult
  $Res call(
      {String fullName,
      String userName,
      String email,
      String phoneNum,
      String address,
      String description,
      String? zipCode,
      @JsonKey(fromJson: _fileFromJson, toJson: _fileToJson) File? profileImage,
      String? profileImageUrl,
      List<String> selectedServices,
      double serviceDistance,
      String schoolName,
      String grade});
}

/// @nodoc
class _$UserModelCopyWithImpl<$Res, $Val extends UserModel>
    implements $UserModelCopyWith<$Res> {
  _$UserModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fullName = null,
    Object? userName = null,
    Object? email = null,
    Object? phoneNum = null,
    Object? address = null,
    Object? description = null,
    Object? zipCode = freezed,
    Object? profileImage = freezed,
    Object? profileImageUrl = freezed,
    Object? selectedServices = null,
    Object? serviceDistance = null,
    Object? schoolName = null,
    Object? grade = null,
  }) {
    return _then(_value.copyWith(
      fullName: null == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String,
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNum: null == phoneNum
          ? _value.phoneNum
          : phoneNum // ignore: cast_nullable_to_non_nullable
              as String,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      zipCode: freezed == zipCode
          ? _value.zipCode
          : zipCode // ignore: cast_nullable_to_non_nullable
              as String?,
      profileImage: freezed == profileImage
          ? _value.profileImage
          : profileImage // ignore: cast_nullable_to_non_nullable
              as File?,
      profileImageUrl: freezed == profileImageUrl
          ? _value.profileImageUrl
          : profileImageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      selectedServices: null == selectedServices
          ? _value.selectedServices
          : selectedServices // ignore: cast_nullable_to_non_nullable
              as List<String>,
      serviceDistance: null == serviceDistance
          ? _value.serviceDistance
          : serviceDistance // ignore: cast_nullable_to_non_nullable
              as double,
      schoolName: null == schoolName
          ? _value.schoolName
          : schoolName // ignore: cast_nullable_to_non_nullable
              as String,
      grade: null == grade
          ? _value.grade
          : grade // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserModelImplCopyWith<$Res>
    implements $UserModelCopyWith<$Res> {
  factory _$$UserModelImplCopyWith(
          _$UserModelImpl value, $Res Function(_$UserModelImpl) then) =
      __$$UserModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String fullName,
      String userName,
      String email,
      String phoneNum,
      String address,
      String description,
      String? zipCode,
      @JsonKey(fromJson: _fileFromJson, toJson: _fileToJson) File? profileImage,
      String? profileImageUrl,
      List<String> selectedServices,
      double serviceDistance,
      String schoolName,
      String grade});
}

/// @nodoc
class __$$UserModelImplCopyWithImpl<$Res>
    extends _$UserModelCopyWithImpl<$Res, _$UserModelImpl>
    implements _$$UserModelImplCopyWith<$Res> {
  __$$UserModelImplCopyWithImpl(
      _$UserModelImpl _value, $Res Function(_$UserModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fullName = null,
    Object? userName = null,
    Object? email = null,
    Object? phoneNum = null,
    Object? address = null,
    Object? description = null,
    Object? zipCode = freezed,
    Object? profileImage = freezed,
    Object? profileImageUrl = freezed,
    Object? selectedServices = null,
    Object? serviceDistance = null,
    Object? schoolName = null,
    Object? grade = null,
  }) {
    return _then(_$UserModelImpl(
      fullName: null == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String,
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNum: null == phoneNum
          ? _value.phoneNum
          : phoneNum // ignore: cast_nullable_to_non_nullable
              as String,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      zipCode: freezed == zipCode
          ? _value.zipCode
          : zipCode // ignore: cast_nullable_to_non_nullable
              as String?,
      profileImage: freezed == profileImage
          ? _value.profileImage
          : profileImage // ignore: cast_nullable_to_non_nullable
              as File?,
      profileImageUrl: freezed == profileImageUrl
          ? _value.profileImageUrl
          : profileImageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      selectedServices: null == selectedServices
          ? _value._selectedServices
          : selectedServices // ignore: cast_nullable_to_non_nullable
              as List<String>,
      serviceDistance: null == serviceDistance
          ? _value.serviceDistance
          : serviceDistance // ignore: cast_nullable_to_non_nullable
              as double,
      schoolName: null == schoolName
          ? _value.schoolName
          : schoolName // ignore: cast_nullable_to_non_nullable
              as String,
      grade: null == grade
          ? _value.grade
          : grade // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserModelImpl with DiagnosticableTreeMixin implements _UserModel {
  const _$UserModelImpl(
      {required this.fullName,
      required this.userName,
      required this.email,
      required this.phoneNum,
      required this.address,
      required this.description,
      this.zipCode,
      @JsonKey(fromJson: _fileFromJson, toJson: _fileToJson) this.profileImage,
      this.profileImageUrl,
      required final List<String> selectedServices,
      required this.serviceDistance,
      required this.schoolName,
      required this.grade})
      : _selectedServices = selectedServices;

  factory _$UserModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserModelImplFromJson(json);

  @override
  final String fullName;
  @override
  final String userName;
  @override
  final String email;
  @override
  final String phoneNum;
  @override
  final String address;
  @override
  final String description;
  @override
  final String? zipCode;
  @override
  @JsonKey(fromJson: _fileFromJson, toJson: _fileToJson)
  final File? profileImage;
  @override
  final String? profileImageUrl;
  final List<String> _selectedServices;
  @override
  List<String> get selectedServices {
    if (_selectedServices is EqualUnmodifiableListView)
      return _selectedServices;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_selectedServices);
  }

  @override
  final double serviceDistance;
  @override
  final String schoolName;
  @override
  final String grade;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'UserModel(fullName: $fullName, userName: $userName, email: $email, phoneNum: $phoneNum, address: $address, description: $description, zipCode: $zipCode, profileImage: $profileImage, profileImageUrl: $profileImageUrl, selectedServices: $selectedServices, serviceDistance: $serviceDistance, schoolName: $schoolName, grade: $grade)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'UserModel'))
      ..add(DiagnosticsProperty('fullName', fullName))
      ..add(DiagnosticsProperty('userName', userName))
      ..add(DiagnosticsProperty('email', email))
      ..add(DiagnosticsProperty('phoneNum', phoneNum))
      ..add(DiagnosticsProperty('address', address))
      ..add(DiagnosticsProperty('description', description))
      ..add(DiagnosticsProperty('zipCode', zipCode))
      ..add(DiagnosticsProperty('profileImage', profileImage))
      ..add(DiagnosticsProperty('profileImageUrl', profileImageUrl))
      ..add(DiagnosticsProperty('selectedServices', selectedServices))
      ..add(DiagnosticsProperty('serviceDistance', serviceDistance))
      ..add(DiagnosticsProperty('schoolName', schoolName))
      ..add(DiagnosticsProperty('grade', grade));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserModelImpl &&
            (identical(other.fullName, fullName) ||
                other.fullName == fullName) &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.phoneNum, phoneNum) ||
                other.phoneNum == phoneNum) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.zipCode, zipCode) || other.zipCode == zipCode) &&
            (identical(other.profileImage, profileImage) ||
                other.profileImage == profileImage) &&
            (identical(other.profileImageUrl, profileImageUrl) ||
                other.profileImageUrl == profileImageUrl) &&
            const DeepCollectionEquality()
                .equals(other._selectedServices, _selectedServices) &&
            (identical(other.serviceDistance, serviceDistance) ||
                other.serviceDistance == serviceDistance) &&
            (identical(other.schoolName, schoolName) ||
                other.schoolName == schoolName) &&
            (identical(other.grade, grade) || other.grade == grade));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      fullName,
      userName,
      email,
      phoneNum,
      address,
      description,
      zipCode,
      profileImage,
      profileImageUrl,
      const DeepCollectionEquality().hash(_selectedServices),
      serviceDistance,
      schoolName,
      grade);

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserModelImplCopyWith<_$UserModelImpl> get copyWith =>
      __$$UserModelImplCopyWithImpl<_$UserModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserModelImplToJson(
      this,
    );
  }
}

abstract class _UserModel implements UserModel {
  const factory _UserModel(
      {required final String fullName,
      required final String userName,
      required final String email,
      required final String phoneNum,
      required final String address,
      required final String description,
      final String? zipCode,
      @JsonKey(fromJson: _fileFromJson, toJson: _fileToJson)
      final File? profileImage,
      final String? profileImageUrl,
      required final List<String> selectedServices,
      required final double serviceDistance,
      required final String schoolName,
      required final String grade}) = _$UserModelImpl;

  factory _UserModel.fromJson(Map<String, dynamic> json) =
      _$UserModelImpl.fromJson;

  @override
  String get fullName;
  @override
  String get userName;
  @override
  String get email;
  @override
  String get phoneNum;
  @override
  String get address;
  @override
  String get description;
  @override
  String? get zipCode;
  @override
  @JsonKey(fromJson: _fileFromJson, toJson: _fileToJson)
  File? get profileImage;
  @override
  String? get profileImageUrl;
  @override
  List<String> get selectedServices;
  @override
  double get serviceDistance;
  @override
  String get schoolName;
  @override
  String get grade;

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserModelImplCopyWith<_$UserModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
