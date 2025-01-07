// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AuthUserModel _$AuthUserModelFromJson(Map<String, dynamic> json) {
  return _AuthUserModel.fromJson(json);
}

/// @nodoc
mixin _$AuthUserModel {
  String get uid => throw _privateConstructorUsedError;
  String get fullName => throw _privateConstructorUsedError;
  String get userName => throw _privateConstructorUsedError;
  String get phoneNumber => throw _privateConstructorUsedError;
  List<String> get selectedServices => throw _privateConstructorUsedError;
  double get serviceDistance => throw _privateConstructorUsedError;
  String get schoolName => throw _privateConstructorUsedError;
  String? get photoURL => throw _privateConstructorUsedError;
  String? get selectedGrade => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get zipCode => throw _privateConstructorUsedError;
  bool get isLoggedIn => throw _privateConstructorUsedError;

  /// Serializes this AuthUserModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AuthUserModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AuthUserModelCopyWith<AuthUserModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthUserModelCopyWith<$Res> {
  factory $AuthUserModelCopyWith(
          AuthUserModel value, $Res Function(AuthUserModel) then) =
      _$AuthUserModelCopyWithImpl<$Res, AuthUserModel>;
  @useResult
  $Res call(
      {String uid,
      String fullName,
      String userName,
      String phoneNumber,
      List<String> selectedServices,
      double serviceDistance,
      String schoolName,
      String? photoURL,
      String? selectedGrade,
      String description,
      String zipCode,
      bool isLoggedIn});
}

/// @nodoc
class _$AuthUserModelCopyWithImpl<$Res, $Val extends AuthUserModel>
    implements $AuthUserModelCopyWith<$Res> {
  _$AuthUserModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AuthUserModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? fullName = null,
    Object? userName = null,
    Object? phoneNumber = null,
    Object? selectedServices = null,
    Object? serviceDistance = null,
    Object? schoolName = null,
    Object? photoURL = freezed,
    Object? selectedGrade = freezed,
    Object? description = null,
    Object? zipCode = null,
    Object? isLoggedIn = null,
  }) {
    return _then(_value.copyWith(
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
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
      photoURL: freezed == photoURL
          ? _value.photoURL
          : photoURL // ignore: cast_nullable_to_non_nullable
              as String?,
      selectedGrade: freezed == selectedGrade
          ? _value.selectedGrade
          : selectedGrade // ignore: cast_nullable_to_non_nullable
              as String?,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      zipCode: null == zipCode
          ? _value.zipCode
          : zipCode // ignore: cast_nullable_to_non_nullable
              as String,
      isLoggedIn: null == isLoggedIn
          ? _value.isLoggedIn
          : isLoggedIn // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AuthUserModelImplCopyWith<$Res>
    implements $AuthUserModelCopyWith<$Res> {
  factory _$$AuthUserModelImplCopyWith(
          _$AuthUserModelImpl value, $Res Function(_$AuthUserModelImpl) then) =
      __$$AuthUserModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String uid,
      String fullName,
      String userName,
      String phoneNumber,
      List<String> selectedServices,
      double serviceDistance,
      String schoolName,
      String? photoURL,
      String? selectedGrade,
      String description,
      String zipCode,
      bool isLoggedIn});
}

/// @nodoc
class __$$AuthUserModelImplCopyWithImpl<$Res>
    extends _$AuthUserModelCopyWithImpl<$Res, _$AuthUserModelImpl>
    implements _$$AuthUserModelImplCopyWith<$Res> {
  __$$AuthUserModelImplCopyWithImpl(
      _$AuthUserModelImpl _value, $Res Function(_$AuthUserModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthUserModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? fullName = null,
    Object? userName = null,
    Object? phoneNumber = null,
    Object? selectedServices = null,
    Object? serviceDistance = null,
    Object? schoolName = null,
    Object? photoURL = freezed,
    Object? selectedGrade = freezed,
    Object? description = null,
    Object? zipCode = null,
    Object? isLoggedIn = null,
  }) {
    return _then(_$AuthUserModelImpl(
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
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
      photoURL: freezed == photoURL
          ? _value.photoURL
          : photoURL // ignore: cast_nullable_to_non_nullable
              as String?,
      selectedGrade: freezed == selectedGrade
          ? _value.selectedGrade
          : selectedGrade // ignore: cast_nullable_to_non_nullable
              as String?,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      zipCode: null == zipCode
          ? _value.zipCode
          : zipCode // ignore: cast_nullable_to_non_nullable
              as String,
      isLoggedIn: null == isLoggedIn
          ? _value.isLoggedIn
          : isLoggedIn // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AuthUserModelImpl
    with DiagnosticableTreeMixin
    implements _AuthUserModel {
  const _$AuthUserModelImpl(
      {required this.uid,
      required this.fullName,
      required this.userName,
      required this.phoneNumber,
      required final List<String> selectedServices,
      required this.serviceDistance,
      required this.schoolName,
      this.photoURL,
      this.selectedGrade,
      required this.description,
      required this.zipCode,
      required this.isLoggedIn})
      : _selectedServices = selectedServices;

  factory _$AuthUserModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$AuthUserModelImplFromJson(json);

  @override
  final String uid;
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
  final String? photoURL;
  @override
  final String? selectedGrade;
  @override
  final String description;
  @override
  final String zipCode;
  @override
  final bool isLoggedIn;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AuthUserModel(uid: $uid, fullName: $fullName, userName: $userName, phoneNumber: $phoneNumber, selectedServices: $selectedServices, serviceDistance: $serviceDistance, schoolName: $schoolName, photoURL: $photoURL, selectedGrade: $selectedGrade, description: $description, zipCode: $zipCode, isLoggedIn: $isLoggedIn)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AuthUserModel'))
      ..add(DiagnosticsProperty('uid', uid))
      ..add(DiagnosticsProperty('fullName', fullName))
      ..add(DiagnosticsProperty('userName', userName))
      ..add(DiagnosticsProperty('phoneNumber', phoneNumber))
      ..add(DiagnosticsProperty('selectedServices', selectedServices))
      ..add(DiagnosticsProperty('serviceDistance', serviceDistance))
      ..add(DiagnosticsProperty('schoolName', schoolName))
      ..add(DiagnosticsProperty('photoURL', photoURL))
      ..add(DiagnosticsProperty('selectedGrade', selectedGrade))
      ..add(DiagnosticsProperty('description', description))
      ..add(DiagnosticsProperty('zipCode', zipCode))
      ..add(DiagnosticsProperty('isLoggedIn', isLoggedIn));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthUserModelImpl &&
            (identical(other.uid, uid) || other.uid == uid) &&
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
            (identical(other.photoURL, photoURL) ||
                other.photoURL == photoURL) &&
            (identical(other.selectedGrade, selectedGrade) ||
                other.selectedGrade == selectedGrade) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.zipCode, zipCode) || other.zipCode == zipCode) &&
            (identical(other.isLoggedIn, isLoggedIn) ||
                other.isLoggedIn == isLoggedIn));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      uid,
      fullName,
      userName,
      phoneNumber,
      const DeepCollectionEquality().hash(_selectedServices),
      serviceDistance,
      schoolName,
      photoURL,
      selectedGrade,
      description,
      zipCode,
      isLoggedIn);

  /// Create a copy of AuthUserModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthUserModelImplCopyWith<_$AuthUserModelImpl> get copyWith =>
      __$$AuthUserModelImplCopyWithImpl<_$AuthUserModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AuthUserModelImplToJson(
      this,
    );
  }
}

abstract class _AuthUserModel implements AuthUserModel {
  const factory _AuthUserModel(
      {required final String uid,
      required final String fullName,
      required final String userName,
      required final String phoneNumber,
      required final List<String> selectedServices,
      required final double serviceDistance,
      required final String schoolName,
      final String? photoURL,
      final String? selectedGrade,
      required final String description,
      required final String zipCode,
      required final bool isLoggedIn}) = _$AuthUserModelImpl;

  factory _AuthUserModel.fromJson(Map<String, dynamic> json) =
      _$AuthUserModelImpl.fromJson;

  @override
  String get uid;
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
  String? get photoURL;
  @override
  String? get selectedGrade;
  @override
  String get description;
  @override
  String get zipCode;
  @override
  bool get isLoggedIn;

  /// Create a copy of AuthUserModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthUserModelImplCopyWith<_$AuthUserModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
