// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_info_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UserInfoModel _$UserInfoModelFromJson(Map<String, dynamic> json) {
  return _UserInfoModel.fromJson(json);
}

/// @nodoc
mixin _$UserInfoModel {
  String get fullName => throw _privateConstructorUsedError;
  String get userName => throw _privateConstructorUsedError;
  String get phoneNumber => throw _privateConstructorUsedError;
  List<String> get selectedServices => throw _privateConstructorUsedError;
  double get serviceDistance => throw _privateConstructorUsedError;
  String get schoolName => throw _privateConstructorUsedError;
  String? get selectedGrade => throw _privateConstructorUsedError;
  @FileConverter()
  File? get profileImage => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get zipCode => throw _privateConstructorUsedError;

  /// Serializes this UserInfoModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserInfoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserInfoModelCopyWith<UserInfoModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserInfoModelCopyWith<$Res> {
  factory $UserInfoModelCopyWith(
          UserInfoModel value, $Res Function(UserInfoModel) then) =
      _$UserInfoModelCopyWithImpl<$Res, UserInfoModel>;
  @useResult
  $Res call(
      {String fullName,
      String userName,
      String phoneNumber,
      List<String> selectedServices,
      double serviceDistance,
      String schoolName,
      String? selectedGrade,
      @FileConverter() File? profileImage,
      String description,
      String zipCode});
}

/// @nodoc
class _$UserInfoModelCopyWithImpl<$Res, $Val extends UserInfoModel>
    implements $UserInfoModelCopyWith<$Res> {
  _$UserInfoModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserInfoModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fullName = null,
    Object? userName = null,
    Object? phoneNumber = null,
    Object? selectedServices = null,
    Object? serviceDistance = null,
    Object? schoolName = null,
    Object? selectedGrade = freezed,
    Object? profileImage = freezed,
    Object? description = null,
    Object? zipCode = null,
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
      phoneNumber: null == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
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
      selectedGrade: freezed == selectedGrade
          ? _value.selectedGrade
          : selectedGrade // ignore: cast_nullable_to_non_nullable
              as String?,
      profileImage: freezed == profileImage
          ? _value.profileImage
          : profileImage // ignore: cast_nullable_to_non_nullable
              as File?,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      zipCode: null == zipCode
          ? _value.zipCode
          : zipCode // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserInfoModelImplCopyWith<$Res>
    implements $UserInfoModelCopyWith<$Res> {
  factory _$$UserInfoModelImplCopyWith(
          _$UserInfoModelImpl value, $Res Function(_$UserInfoModelImpl) then) =
      __$$UserInfoModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String fullName,
      String userName,
      String phoneNumber,
      List<String> selectedServices,
      double serviceDistance,
      String schoolName,
      String? selectedGrade,
      @FileConverter() File? profileImage,
      String description,
      String zipCode});
}

/// @nodoc
class __$$UserInfoModelImplCopyWithImpl<$Res>
    extends _$UserInfoModelCopyWithImpl<$Res, _$UserInfoModelImpl>
    implements _$$UserInfoModelImplCopyWith<$Res> {
  __$$UserInfoModelImplCopyWithImpl(
      _$UserInfoModelImpl _value, $Res Function(_$UserInfoModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserInfoModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fullName = null,
    Object? userName = null,
    Object? phoneNumber = null,
    Object? selectedServices = null,
    Object? serviceDistance = null,
    Object? schoolName = null,
    Object? selectedGrade = freezed,
    Object? profileImage = freezed,
    Object? description = null,
    Object? zipCode = null,
  }) {
    return _then(_$UserInfoModelImpl(
      fullName: null == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String,
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumber: null == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
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
      selectedGrade: freezed == selectedGrade
          ? _value.selectedGrade
          : selectedGrade // ignore: cast_nullable_to_non_nullable
              as String?,
      profileImage: freezed == profileImage
          ? _value.profileImage
          : profileImage // ignore: cast_nullable_to_non_nullable
              as File?,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      zipCode: null == zipCode
          ? _value.zipCode
          : zipCode // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserInfoModelImpl
    with DiagnosticableTreeMixin
    implements _UserInfoModel {
  const _$UserInfoModelImpl(
      {required this.fullName,
      required this.userName,
      required this.phoneNumber,
      required final List<String> selectedServices,
      required this.serviceDistance,
      required this.schoolName,
      this.selectedGrade,
      @FileConverter() this.profileImage,
      required this.description,
      required this.zipCode})
      : _selectedServices = selectedServices;

  factory _$UserInfoModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserInfoModelImplFromJson(json);

  @override
  final String fullName;
  @override
  final String userName;
  @override
  final String phoneNumber;
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
  final String? selectedGrade;
  @override
  @FileConverter()
  final File? profileImage;
  @override
  final String description;
  @override
  final String zipCode;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'UserInfoModel(fullName: $fullName, userName: $userName, phoneNumber: $phoneNumber, selectedServices: $selectedServices, serviceDistance: $serviceDistance, schoolName: $schoolName, selectedGrade: $selectedGrade, profileImage: $profileImage, description: $description, zipCode: $zipCode)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'UserInfoModel'))
      ..add(DiagnosticsProperty('fullName', fullName))
      ..add(DiagnosticsProperty('userName', userName))
      ..add(DiagnosticsProperty('phoneNumber', phoneNumber))
      ..add(DiagnosticsProperty('selectedServices', selectedServices))
      ..add(DiagnosticsProperty('serviceDistance', serviceDistance))
      ..add(DiagnosticsProperty('schoolName', schoolName))
      ..add(DiagnosticsProperty('selectedGrade', selectedGrade))
      ..add(DiagnosticsProperty('profileImage', profileImage))
      ..add(DiagnosticsProperty('description', description))
      ..add(DiagnosticsProperty('zipCode', zipCode));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserInfoModelImpl &&
            (identical(other.fullName, fullName) ||
                other.fullName == fullName) &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            const DeepCollectionEquality()
                .equals(other._selectedServices, _selectedServices) &&
            (identical(other.serviceDistance, serviceDistance) ||
                other.serviceDistance == serviceDistance) &&
            (identical(other.schoolName, schoolName) ||
                other.schoolName == schoolName) &&
            (identical(other.selectedGrade, selectedGrade) ||
                other.selectedGrade == selectedGrade) &&
            (identical(other.profileImage, profileImage) ||
                other.profileImage == profileImage) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.zipCode, zipCode) || other.zipCode == zipCode));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      fullName,
      userName,
      phoneNumber,
      const DeepCollectionEquality().hash(_selectedServices),
      serviceDistance,
      schoolName,
      selectedGrade,
      profileImage,
      description,
      zipCode);

  /// Create a copy of UserInfoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserInfoModelImplCopyWith<_$UserInfoModelImpl> get copyWith =>
      __$$UserInfoModelImplCopyWithImpl<_$UserInfoModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserInfoModelImplToJson(
      this,
    );
  }
}

abstract class _UserInfoModel implements UserInfoModel {
  const factory _UserInfoModel(
      {required final String fullName,
      required final String userName,
      required final String phoneNumber,
      required final List<String> selectedServices,
      required final double serviceDistance,
      required final String schoolName,
      final String? selectedGrade,
      @FileConverter() final File? profileImage,
      required final String description,
      required final String zipCode}) = _$UserInfoModelImpl;

  factory _UserInfoModel.fromJson(Map<String, dynamic> json) =
      _$UserInfoModelImpl.fromJson;

  @override
  String get fullName;
  @override
  String get userName;
  @override
  String get phoneNumber;
  @override
  List<String> get selectedServices;
  @override
  double get serviceDistance;
  @override
  String get schoolName;
  @override
  String? get selectedGrade;
  @override
  @FileConverter()
  File? get profileImage;
  @override
  String get description;
  @override
  String get zipCode;

  /// Create a copy of UserInfoModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserInfoModelImplCopyWith<_$UserInfoModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
