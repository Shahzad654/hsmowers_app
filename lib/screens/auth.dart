// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hsmowers_app/screens/edit_profile.dart';
import 'package:hsmowers_app/theme.dart';
import 'package:hsmowers_app/screens/login.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  User? currentUser;
  String? displayName;
  String? userName;
  String? description;
  String? grade;
  String? photoURL;
  List<String> services = [];
  List<Map<String, double>> serviceArea = [];
  String? staticMapUrl;
  bool isLoading = true;

  String weedingIcon = 'images/weeding.svg';
  String mowersIcon = 'images/mowers.svg';
  String leafremovalIcon = 'images/leafremoval.svg';
  String dogwalkingIcon = 'images/dogwalking.svg';
  String egdingIcon = 'images/edging.svg';
  String snowremovalIcon = 'images/snowremoval.svg';
  String babysittingIcon = 'images/babysitting.svg';
  String windowcleaningIcon = 'images/windowcleaning.svg';

  @override
  void initState() {
    super.initState();
    _getCurrentUser();
  }

  Future<void> _getCurrentUser() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('userInfo')
          .doc(user.uid)
          .get();

      if (userSnapshot.exists) {
        setState(() {
          currentUser = user;
          displayName = userSnapshot['displayName'] ?? 'No Name';
          description = userSnapshot['description'] ?? 'No description';
          isLoading = false;
          userName = userSnapshot['userName'] ?? 'No Username';
          grade = userSnapshot['grade'] ?? 'No grade';
          photoURL = userSnapshot['photoURL'] ?? user.photoURL;

          if (userSnapshot['services'] != null) {
            services = List<String>.from(userSnapshot['services']);
          }
        });
      } else {
        setState(() {
          displayName = 'No Name';
          isLoading = false;
        });
      }
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _logout() async {
    await FirebaseAuth.instance.signOut();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const Login()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: _logout,
          ),
        ],
      ),
      body: Center(
        child: isLoading
            ? CircularProgressIndicator(
                color: AppColors.primary,
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: photoURL != null && photoURL!.isNotEmpty
                        ? NetworkImage(photoURL!) as ImageProvider
                        : AssetImage('assets/default_avatar.png'),
                  ),
                  SizedBox(height: 20),
                  Text(
                    displayName ?? 'No Name',
                    style: AppTextStyles.h3.copyWith(color: Colors.black),
                  ),
                  Text(
                    userName ?? 'No userName',
                    style: AppTextStyles.h5.copyWith(color: Colors.black),
                  ),
                  Text(
                    description ?? 'No description',
                    style: AppTextStyles.h5.copyWith(color: Colors.black),
                  ),
                  Text(
                    {
                          '9': 'Freshman',
                          '10': 'Sophomore',
                          '11': 'Junior',
                          '12': 'Senior',
                        }[grade] ??
                        'No Grade',
                    style: AppTextStyles.h6.copyWith(color: Colors.black),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            WidgetStateProperty.all(AppColors.secondaryDark)),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditProfile()));
                    },
                    child: Text(
                      'Edit Profile',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Services',
                    style: AppTextStyles.h4.copyWith(color: Colors.black),
                  ),
                  if (services.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10),
                          Wrap(
                            alignment: WrapAlignment.center,
                            spacing: 15,
                            runSpacing: 15,
                            children: [
                              if (services.contains('weeding'))
                                buildServiceIcon(weedingIcon, 'Weeding'),
                              if (services.contains('mowing'))
                                buildServiceIcon(mowersIcon, 'Mowing'),
                              if (services.contains('edging'))
                                buildServiceIcon(egdingIcon, 'Edging'),
                              if (services.contains('window-cleaning'))
                                buildServiceIcon(
                                    windowcleaningIcon, 'Window Cleaning'),
                              if (services.contains('snow-removal'))
                                buildServiceIcon(
                                    snowremovalIcon, 'Snow Removal'),
                              if (services.contains('baby-sitting'))
                                buildServiceIcon(
                                    babysittingIcon, 'Baby Sitting'),
                              if (services.contains('leaf-removal'))
                                buildServiceIcon(
                                    leafremovalIcon, 'Leaf Removal'),
                              if (services.contains('dog-walking'))
                                buildServiceIcon(dogwalkingIcon, 'Dog Walking'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  // Display static map if the URL is available
                  // if (staticMapUrl != null)
                  //   Padding(
                  //     padding: const EdgeInsets.only(left: 20, right: 20),
                  //     child: ClipRRect(
                  //       borderRadius: BorderRadius.circular(24),
                  //       child: Image.network(staticMapUrl!),
                  //     ),
                  //   ),
                ],
              ),
      ),
    );
  }
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
