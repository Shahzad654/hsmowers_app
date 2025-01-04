// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, curly_braces_in_flow_control_structures

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hsmowers_app/providers/user_info_provider.dart';
import 'package:hsmowers_app/screens/user_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hsmowers_app/screens/signup.dart';
import 'package:hsmowers_app/theme.dart';
import 'package:hsmowers_app/utils/code_to_latlang.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:convert';

class EditProfile extends StatefulWidget {
  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();
  int currentStep = 0;

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController phoneNumController = TextEditingController();
  final TextEditingController schoolNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController addressCodeController = TextEditingController();

  List<String> selectedServices = [];
  double serviceDistance = 0;
  String? selectedGrade;
  File? profileImage;
  String? photoURL;
  String? grade;
  String? description;
  String? services;

  @override
  void initState() {
    super.initState();
    _getUserData();
    _getPhotoURL();
  }

  @override
  void dispose() {
    fullNameController.dispose();
    userNameController.dispose();
    phoneNumController.dispose();
    schoolNameController.dispose();
    descriptionController.dispose();
    addressCodeController.dispose();
    super.dispose();
  }

  bool validateCurrentStep() {
    switch (currentStep) {
      case 0:
        return fullNameController.text.isNotEmpty &&
            userNameController.text.isNotEmpty &&
            phoneNumController.text.isNotEmpty &&
            phoneNumController.text.length >= 10;
      case 1:
        return selectedServices.isNotEmpty && serviceDistance > 0;
      case 2:
        return schoolNameController.text.isNotEmpty && selectedGrade != null;
      case 3:
        return addressCodeController.text.isNotEmpty;
      default:
        return false;
    }
  }

  void nextStep(BuildContext context, WidgetRef ref) {
    if (!validateCurrentStep()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please complete all required fields'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (currentStep < 3) {
      setState(() => currentStep++);
    } else {
      submitForm(context, ref);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => UserProfile()),
      );
    }
  }

  void previousStep() {
    if (currentStep > 0) {
      setState(() => currentStep--);
    }
  }

  Future<void> _getPhotoURL() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedPhotoURL = prefs.getString('photoURL');
    setState(() {
      photoURL = storedPhotoURL;
    });
  }

  Future<void> _getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedDisplayName = prefs.getString('displayName');
    String? storedUserName = prefs.getString('userName');
    String? storedPhoneNum = prefs.getString('phoneNum');
    String? storedDescription = prefs.getString('description');
    String? storedGrade = prefs.getString('grade');
    String? storedServices = prefs.getString('services');
    String? storedServiceDistance = prefs.getString('serviceDistance');
    String? storedSchoolName = prefs.getString('schoolName');
    String? storedZipCode = prefs.getString('zipCode');

    List<dynamic>? decodedServices;
    if (storedServices != null) {
      try {
        decodedServices = jsonDecode(storedServices);
      } catch (e) {
        print("Error decoding services: $e");
      }
    }

    setState(() {
      fullNameController.text = storedDisplayName ?? '';
      userNameController.text = storedUserName ?? '';
      phoneNumController.text = storedPhoneNum ?? '';
      schoolNameController.text = storedSchoolName ?? '';
      descriptionController.text = storedDescription ?? '';
      addressCodeController.text = storedZipCode ?? '';
      selectedGrade = storedGrade;
      serviceDistance = storedServiceDistance != null
          ? double.tryParse(storedServiceDistance) ?? 0
          : 0;
      services = decodedServices?.join(', ') ?? 'No services';
      services = decodedServices?.join(', ') ?? 'No services';
      selectedServices = List<String>.from(decodedServices ?? []);
    });
  }

  Future<void> submitForm(BuildContext context, WidgetRef ref) async {
    if (!_formKey.currentState!.validate()) return;

    final addressCode = addressCodeController.text.trim();
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('uid');

    if (userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('User ID not found')),
      );
      return;
    }

    try {
      Map<String, double> latLong = await convertZipToLatLong(addressCode);
      String imageUrl = '';

      if (profileImage != null) {
        try {
          String fileName = 'profilePics/$userId.jpg';
          final storageRef = FirebaseStorage.instance.ref().child(fileName);

          final metadata = SettableMetadata(
              contentType: 'image/jpeg', customMetadata: {'userId': userId});
          await storageRef.putFile(profileImage!, metadata);
          imageUrl = await storageRef.getDownloadURL();
        } catch (e) {
          print('Error uploading image: $e');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to upload profile image')),
          );
          return;
        }
      }

      final userData = {
        'displayName': fullNameController.text,
        'userName': userNameController.text,
        'phoneNumber': phoneNumController.text,
        'services': selectedServices,
        'serviceDistance': serviceDistance,
        'schoolName': schoolNameController.text,
        'grade': selectedGrade,
        'description': descriptionController.text,
        'zipCode': addressCode,
        'latitude': latLong['latitude'],
        'longitude': latLong['longitude'],
        'updatedAt': FieldValue.serverTimestamp(),
      };

      if (imageUrl.isNotEmpty) {
        userData['photoURL'] = imageUrl;
      }

      await FirebaseFirestore.instance
          .collection('userInfo')
          .doc(userId)
          .set(userData, SetOptions(merge: true));

      await prefs.setString('displayName', fullNameController.text);
      await prefs.setString('userName', userNameController.text);
      await prefs.setString('phoneNum', phoneNumController.text);
      await prefs.setString('schoolName', schoolNameController.text);
      await prefs.setString('grade', selectedGrade ?? '');
      await prefs.setString('description', descriptionController.text);
      await prefs.setString('zipCode', addressCode);

      if (selectedServices.isNotEmpty) {
        await prefs.setString('services', jsonEncode(selectedServices));
      }

      await prefs.setString('serviceDistance', serviceDistance.toString());

      if (imageUrl.isNotEmpty) {
        await prefs.setString('photoURL', imageUrl);
      }

      ref.read(userInfoProvider.notifier).addUserInfo(
            fullName: fullNameController.text,
            userName: userNameController.text,
            phoneNumber: phoneNumController.text,
            selectedServices: selectedServices,
            serviceDistance: serviceDistance,
            schoolName: schoolNameController.text,
            selectedGrade: selectedGrade,
            profileImage: profileImage,
            description: descriptionController.text,
            zipCode: addressCode,
          );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Profile updated successfully')),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => UserProfile()),
      );
    } catch (e) {
      print('Error saving user data: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update profile: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, WidgetRef ref, Widget? child) {
        final userInfo = ref.watch(userInfoProvider);
        print(userInfo);

        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: AppColors.primary,
              title: Text(
                'Edit Profile',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              centerTitle: true,
            ),
            body: Form(
              key: _formKey,
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Edit your business profile',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 30),
                    _buildCurrentStep(),
                    SizedBox(height: 30),
                    _buildNavigationButtons(context, ref),
                    SizedBox(height: 20),
                    _buildProgressIndicator(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCurrentStep() {
    switch (currentStep) {
      case 0:
        return Step1Widget(
          fullNameController: fullNameController,
          userNameController: userNameController,
          phoneNumController: phoneNumController,
        );
      case 1:
        return Step2Widget(
          onServicesChanged: (services) =>
              setState(() => selectedServices = services),
          onDistanceChanged: (distance) =>
              setState(() => serviceDistance = distance),
          initialServices: selectedServices,
          initialDistance: serviceDistance,
        );
      case 2:
        return Step3Widget(
          schoolNameController: schoolNameController,
          onGradeChanged: (grade) => setState(() => selectedGrade = grade),
          onImageSelected: (file) => setState(() => profileImage = file),
          selectedGrade: selectedGrade,
          currentImage: profileImage,
          photoURL: photoURL,
        );
      case 3:
        return Step4Widget(
          descriptionController: descriptionController,
          addressCodeController: addressCodeController,
        );
      default:
        return SizedBox();
    }
  }

  Widget _buildNavigationButtons(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (currentStep > 0)
          ElevatedButton(
            onPressed: previousStep,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryDark,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            ),
            child: Icon(Icons.arrow_back, color: Colors.white),
          ),
        if (currentStep > 0) SizedBox(width: 20),
        ElevatedButton(
          onPressed: () => nextStep(context, ref),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryDark,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          ),
          child: Icon(
            currentStep < 3 ? Icons.arrow_forward : Icons.check,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildProgressIndicator() {
    return LinearProgressIndicator(
      value: (currentStep + 1) / 4,
      backgroundColor: Colors.grey[300],
      color: AppColors.primary,
    );
  }
}

class Step1Widget extends StatelessWidget {
  final TextEditingController fullNameController;
  final TextEditingController userNameController;
  final TextEditingController phoneNumController;

  const Step1Widget({
    required this.fullNameController,
    required this.userNameController,
    required this.phoneNumController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CustomTextField(
          controller: fullNameController,
          label: 'Full Name',
          validator: (value) =>
              value?.isEmpty ?? true ? 'Please enter your name' : null,
        ),
        SizedBox(height: 20),
        CustomTextField(
          controller: userNameController,
          label: 'Username',
          validator: (value) =>
              value?.isEmpty ?? true ? 'Please enter a username' : null,
        ),
        SizedBox(height: 20),
        CustomTextField(
          controller: phoneNumController,
          label: 'Phone Number',
          keyboardType: TextInputType.phone,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          validator: (value) {
            if (value?.isEmpty ?? true) return 'Please enter your phone number';
            if (value!.length < 10) return 'Please enter a valid phone number';
            return null;
          },
        ),
      ],
    );
  }
}

class Step2Widget extends StatefulWidget {
  final Function(List<String>) onServicesChanged;
  final Function(double) onDistanceChanged;
  final List<String> initialServices;
  final double initialDistance;

  const Step2Widget({
    required this.onServicesChanged,
    required this.onDistanceChanged,
    required this.initialServices,
    required this.initialDistance,
  });

  @override
  State<Step2Widget> createState() => _Step2WidgetState();
}

class _Step2WidgetState extends State<Step2Widget> {
  late List<String> selectedServices;
  late double distance;

  final List<String> availableServices = [
    'Mowing',
    'Weeding',
    'Snow Removal',
    'Baby Sitting',
    'Edging',
    'Leaf Removal',
    'Dog Walking',
    'Window Cleaning',
  ];

  @override
  void initState() {
    super.initState();
    selectedServices = List.from(widget.initialServices);
    distance = widget.initialDistance;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select Services',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: availableServices.map((service) {
            String formattedService =
                service.toLowerCase().replaceAll(' ', '-');
            final isSelected = selectedServices.contains(formattedService);
            return FilterChip(
              selectedColor: AppColors.primary,
              label: Text(service),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  if (selected) {
                    selectedServices.add(formattedService);
                  } else {
                    selectedServices.remove(formattedService);
                  }
                });
                widget.onServicesChanged(selectedServices);
              },
            );
          }).toList(),
        ),
        SizedBox(height: 24),
        Text(
          'Service Distance: ${distance.toStringAsFixed(1)} Miles',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Slider(
          value: distance,
          min: 0,
          max: 50,
          divisions: 50,
          label: '${distance.toStringAsFixed(1)} Miles',
          onChanged: (value) {
            setState(() => distance = value);
            widget.onDistanceChanged(value);
          },
        ),
      ],
    );
  }
}

class Step3Widget extends StatelessWidget {
  final TextEditingController schoolNameController;
  final Function(String?) onGradeChanged;
  final Function(File) onImageSelected;
  final String? selectedGrade;
  final File? currentImage;
  final String? photoURL;

  const Step3Widget({
    required this.schoolNameController,
    required this.onGradeChanged,
    required this.onImageSelected,
    required this.selectedGrade,
    required this.currentImage,
    this.photoURL,
  });

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      onImageSelected(File(image.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, String> gradeMap = {
      '9': 'Freshman',
      '10': 'Sophomore',
      '11': 'Junior',
      '12': 'Senior',
    };

    return Column(
      children: [
        GestureDetector(
          onTap: _pickImage,
          child: CircleAvatar(
            radius: 50,
            backgroundImage: photoURL != null
                ? NetworkImage(photoURL!)
                : currentImage != null
                    ? FileImage(currentImage!)
                    : null,
            child: currentImage == null && photoURL == null
                ? Icon(Icons.camera_alt, size: 30, color: Colors.white)
                : null,
          ),
        ),
        SizedBox(height: 20),
        CustomTextField(
          controller: schoolNameController,
          label: 'School Name',
          validator: (value) =>
              value?.isEmpty ?? true ? 'Please enter school name' : null,
        ),
        SizedBox(height: 20),
        DropdownButtonFormField<String>(
          value: selectedGrade,
          decoration: InputDecoration(
            labelText: 'Grade',
            focusColor: AppColors.primary,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.primary, width: 2.0),
            ),
          ),
          items: gradeMap.entries
              .map((entry) => DropdownMenuItem<String>(
                    value: entry.key,
                    child: Text(entry.value),
                  ))
              .toList(),
          onChanged: onGradeChanged,
        ),
      ],
    );
  }
}

class Step4Widget extends StatelessWidget {
  final TextEditingController descriptionController;
  final TextEditingController addressCodeController;

  const Step4Widget({
    required this.descriptionController,
    required this.addressCodeController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextField(
          controller: descriptionController,
          label: 'Description',
          maxLines: 5,
          validator: (value) =>
              value?.isEmpty ?? true ? 'Please enter a description' : null,
        ),
        SizedBox(height: 20),
        CustomTextField(
          controller: addressCodeController,
          label: 'Zip Code or Address',
          keyboardType: TextInputType.text,
          validator: (value) {
            if (value?.isEmpty ?? true)
              return 'Please enter zip code or address';
            if (value!.length != 5 || value == '')
              return 'Please enter a valid zip code or address';
            return null;
          },
        ),
      ],
    );
  }
}

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLines;

  const CustomTextField({
    required this.controller,
    required this.label,
    this.validator,
    this.keyboardType,
    this.inputFormatters,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      cursorColor: AppColors.textColorLight,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppColors.primary)),
        filled: true,
        fillColor: Colors.white,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.primary, width: 2),
        ),
      ),
      validator: validator,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      maxLines: maxLines,
    );
  }
}
