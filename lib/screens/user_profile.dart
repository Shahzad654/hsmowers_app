// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hsmowers_app/models/auth_user_model.dart';
import 'package:hsmowers_app/screens/edit_profile.dart';
import 'package:hsmowers_app/screens/login.dart';
import 'package:hsmowers_app/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen>
    with WidgetsBindingObserver {
  String? serviceArea;
  String? staticMapUrl;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _getUserData();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _getUserData();
    }
  }

  Future<void> _getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedServiceArea = prefs.getString('serviceArea');
    print(storedServiceArea);

    List<dynamic>? decodedServiceArea;
    if (storedServiceArea != null) {
      try {
        decodedServiceArea = jsonDecode(storedServiceArea);

        if (decodedServiceArea != null && decodedServiceArea.isNotEmpty) {
          _generateStaticMapUrl(decodedServiceArea);
        }
      } catch (e) {
        print("Error decoding serviceArea: $e");
      }
    }

    setState(() {
      if (decodedServiceArea != null && decodedServiceArea.isNotEmpty) {
        serviceArea = decodedServiceArea
            .map((coord) => '${coord["lat"]}, ${coord["lng"]}')
            .join('; ');
      } else {
        serviceArea = 'No service area';
      }
      print(serviceArea);
    });
  }

  void _generateStaticMapUrl(List<dynamic>? serviceArea) {
    if (serviceArea != null && serviceArea.isNotEmpty) {
      String apiKey = 'AIzaSyDfDJ9e4SK6WIpdbLtq4LrztIXu7lywgb0';
      String path = serviceArea.map((coord) {
        return '${coord["lat"]},${coord["lng"]}';
      }).join('|');
      setState(() {
        staticMapUrl =
            'https://maps.googleapis.com/maps/api/staticmap?size=600x400&path=color:0xff0000|weight:5|$path&key=$apiKey';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final authUser = ref.watch(authUserProvider);
    print('ProfileScreen - Auth User State: ${authUser.toJson()}');

    const String weedingIcon = 'images/weeding.svg';
    const String mowersIcon = 'images/mowers.svg';
    const String leafremovalIcon = 'images/leafremoval.svg';
    const String dogwalkingIcon = 'images/dogwalking.svg';
    const String edgingIcon = 'images/edging.svg';
    const String snowremovalIcon = 'images/snowremoval.svg';
    const String babysittingIcon = 'images/babysitting.svg';
    const String windowcleaningIcon = 'images/windowcleaning.svg';

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              ref.read(authUserProvider.notifier).clearUser();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const Login()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage:
                    authUser.photoURL != null && authUser.photoURL!.isNotEmpty
                        ? NetworkImage(authUser.photoURL!) as ImageProvider
                        : const AssetImage('assets/default_avatar.png'),
              ),
              const SizedBox(height: 20),
              Text(
                authUser.fullName,
                style: AppTextStyles.h3.copyWith(color: Colors.black),
              ),
              Text(
                authUser.userName,
                style: AppTextStyles.h5.copyWith(color: Colors.black),
              ),
              Text(
                {
                      '9': 'Freshman',
                      '10': 'Sophomore',
                      '11': 'Junior',
                      '12': 'Senior',
                    }[authUser.selectedGrade] ??
                    'No Grade',
                style: AppTextStyles.h6.copyWith(color: Colors.black),
              ),
              Text(
                authUser.description,
                style: AppTextStyles.h5.copyWith(color: Colors.black),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(
                    AppColors.secondaryDark,
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditProfile(),
                    ),
                  );
                },
                child: const Text(
                  'Edit Profile',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 40),
              Text(
                'Service Area',
                style: AppTextStyles.h4,
              ),
              const SizedBox(height: 20),
              if (staticMapUrl != null)
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: Image.network(staticMapUrl!),
                  ),
                ),
              const SizedBox(height: 40),
              Text(
                'Services',
                style: AppTextStyles.h4.copyWith(color: Colors.black),
              ),
              const SizedBox(height: 20),
              if (authUser.selectedServices.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 15,
                    runSpacing: 15,
                    children: [
                      if (authUser.selectedServices.contains('weeding'))
                        buildServiceIcon(weedingIcon, 'Weeding'),
                      if (authUser.selectedServices.contains('mowing'))
                        buildServiceIcon(mowersIcon, 'Mowing'),
                      if (authUser.selectedServices.contains('edging'))
                        buildServiceIcon(edgingIcon, 'Edging'),
                      if (authUser.selectedServices.contains('window-cleaning'))
                        buildServiceIcon(windowcleaningIcon, 'Window Cleaning'),
                      if (authUser.selectedServices.contains('snow-removal'))
                        buildServiceIcon(snowremovalIcon, 'Snow Removal'),
                      if (authUser.selectedServices.contains('baby-sitting'))
                        buildServiceIcon(babysittingIcon, 'Baby Sitting'),
                      if (authUser.selectedServices.contains('leaf-removal'))
                        buildServiceIcon(leafremovalIcon, 'Leaf Removal'),
                      if (authUser.selectedServices.contains('dog-walking'))
                        buildServiceIcon(dogwalkingIcon, 'Dog Walking'),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildServiceIcon(String iconPath, String label) {
    return Column(
      children: [
        Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: AppColors.primary,
          ),
          child: SvgPicture.asset(
            iconPath,
            width: 40,
            height: 40,
          ),
        ),
        Text(label),
      ],
    );
  }
}
