// user_provider.dart
import 'dart:io';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:hsmowers_app/models/user_model.dart';

part 'user_provider.g.dart';

@riverpod
class User extends _$User {
  @override
  List<UserModel> build() {
    return [];
  }

  Future<void> createUser({
    required String fullName,
    required String userName,
    required String email,
    required String phoneNum,
    required String address,
    required String description,
    String? zipCode,
    required List<String> selectedServices,
    required double serviceDistance,
    required String schoolName,
    required String grade,
  }) async {
    final newUser = UserModel(
      fullName: fullName,
      userName: userName,
      email: email,
      phoneNum: phoneNum,
      address: address,
      description: description,
      zipCode: zipCode,
      selectedServices: selectedServices,
      serviceDistance: serviceDistance,
      schoolName: schoolName,
      grade: grade,
    );
    
    state = [...state, newUser];
  }

  Future<void> updateUserImage(int userIndex, File imageFile) async {
    try {
      if (userIndex >= 0 && userIndex < state.length) {
        final updatedUsers = [...state];
        updatedUsers[userIndex] = updatedUsers[userIndex].copyWith(
          profileImage: imageFile,
        );
        state = updatedUsers;
      }
    } catch (e) {
      throw Exception('Failed to update user image: $e');
    }
  }

  Future<void> uploadProfileImage(int userIndex) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      
      if (image != null) {
        final File imageFile = File(image.path);
        await updateUserImage(userIndex, imageFile);
      }
    } catch (e) {
      throw Exception('Failed to upload image: $e');
    }
  }
}


@riverpod
class FormStepStatus extends _$FormStepStatus {
  @override
  Map<int, bool> build() {
    return {
      0: false, 
      1: false, 
      2: false, 
      3: false, 
    };
  }

  void updateStepStatus(int step, bool isCompleted) {
    state = {...state, step: isCompleted};
  }

  bool get isFormComplete => state.values.every((status) => status);
}