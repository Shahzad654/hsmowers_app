// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, empty_catches, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hsmowers_app/screens/edit_profile.dart';
import 'package:hsmowers_app/screens/home.dart';
import 'package:hsmowers_app/screens/login.dart';
import 'package:hsmowers_app/screens/pricing_screen.dart';
import 'package:hsmowers_app/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  String? photoURL;
  String? displayName;
  String? userName;
  String? phoneNum;
  String? schoolName;
  String? grade;
  String? description;
  String? serviceArea;
  String? services;
  String? serviceDistance;
  bool? isAuth;
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
    _getPhotoURL();
    _getUserData();
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
    String? storedServiceArea = prefs.getString('serviceArea');
    print(storedServiceArea);
    String? storedServices = prefs.getString('services');
    String? stroedServiceDistance = prefs.getString('serviceDistance');
    String? storedSchoolname = prefs.getString('schoolName');
    bool? storedAuth = prefs.getBool('isLoggedIn');

    List<dynamic>? decodedServiceArea;
    if (storedServiceArea != null) {
      try {
        decodedServiceArea = jsonDecode(storedServiceArea);
        _generateStaticMapUrl(decodedServiceArea);
      } catch (e) {
        print("Error decoding serviceArea: $e");
      }
    }

    List<dynamic>? decodedServices;
    if (storedServices != null) {
      try {
        decodedServices = jsonDecode(storedServices);
      } catch (e) {
        print("Error decoding services: $e");
      }
    }

    setState(() {
      displayName = storedDisplayName;
      userName = storedUserName;
      phoneNum = storedPhoneNum;
      description = storedDescription;
      grade = storedGrade;
      isAuth = storedAuth;
      serviceArea = storedServiceArea;
      serviceArea = decodedServiceArea?.join(', ') ?? 'No service area';
      print(serviceArea);
      services = decodedServices?.join(', ') ?? 'No services';
      serviceDistance = stroedServiceDistance;
      schoolName = storedSchoolname;

      isLoading = false;
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
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            actions: [
              PopupMenuButton(
                  icon: Icon(
                    Icons.more_vert,
                    size: 35,
                  ),
                  itemBuilder: (context) => [
                        PopupMenuItem(
                            onTap: () async {
                              try {
                                await FirebaseAuth.instance.signOut();

                                SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                await prefs.setBool('isLoggedIn', false);
                                await prefs.remove('userName');
                                await prefs.remove('email');
                                await prefs.remove('photoURL');
                                await prefs.remove('uid');
                                await prefs.remove('displayName');
                                await prefs.remove('grade');
                                await prefs.remove('description');
                                await prefs.remove('serviceArea');
                                await prefs.remove('services');

                                setState(() {
                                  isAuth = false;
                                });

                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Login()));
                              } catch (e) {
                                print("Error during logout: $e");
                              }
                            },
                            value: 1,
                            child: Text(
                              ('Logout'),
                              style: AppTextStyles.h5
                                  .copyWith(color: Colors.black),
                            ))
                      ]),
            ],
          ),
          body: isLoading
              ? Center(
                  child: CircularProgressIndicator(
                  color: AppColors.primary,
                ))
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: CircleAvatar(
                          maxRadius: 60,
                          backgroundImage: photoURL != null
                              ? NetworkImage(photoURL!)
                              : AssetImage('images/profile.jpg')
                                  as ImageProvider,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Center(
                          child: Text(
                        displayName ?? 'No Name',
                        style: AppTextStyles.h3.copyWith(color: Colors.black),
                      )),
                      SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: Text(
                          grade ?? 'no grade',
                          style: AppTextStyles.h6.copyWith(color: Colors.black),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(maxWidth: 350),
                          child: Text(
                            description ?? 'no description',
                            textAlign: TextAlign.center,
                            style: AppTextStyles.para
                                .copyWith(color: Colors.black),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: WidgetStateProperty.all(
                                      AppColors.primaryDark)),
                              onPressed: () {},
                              child: Text(
                                'Contact',
                                style: AppTextStyles.h5
                                    .copyWith(color: Colors.white),
                              )),
                          SizedBox(
                            width: 20,
                          ),
                          ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: WidgetStateProperty.all(
                                      AppColors.secondaryDark)),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => EditProfile()));
                              },
                              child: Text(
                                'Edit Profile',
                                style: AppTextStyles.h5
                                    .copyWith(color: Colors.white),
                              )),
                        ],
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      if (staticMapUrl != null)
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(24),
                            child: Image.network(staticMapUrl!),
                          ),
                        ),
                      SizedBox(
                        height: 50,
                      ),
                      Text(
                        'Services',
                        style: AppTextStyles.h3.copyWith(color: Colors.black),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 15,
                        runSpacing: 15,
                        children: [
                          if (services != null && services!.contains('weeding'))
                            buildServiceIcon(weedingIcon, 'Weeding'),
                          if (services != null && services!.contains('mowing'))
                            buildServiceIcon(mowersIcon, 'Mowing'),
                          if (services != null && services!.contains('edging'))
                            buildServiceIcon(egdingIcon, 'Edging'),
                          if (services != null &&
                              services!.contains('window-cleaning'))
                            buildServiceIcon(
                                windowcleaningIcon, 'Window Cleaning'),
                          if (services != null &&
                              services!.contains('snow-removal'))
                            buildServiceIcon(snowremovalIcon, 'Snow Removal'),
                          if (services != null &&
                              services!.contains('baby-sitting'))
                            buildServiceIcon(babysittingIcon, 'Baby Sitting'),
                          if (services != null &&
                              services!.contains('leaf-removal'))
                            buildServiceIcon(leafremovalIcon, 'Leaf Removal'),
                          if (services != null &&
                              services!.contains('dog-walking'))
                            buildServiceIcon(dogwalkingIcon, 'Dog Walking'),
                        ],
                      ),
                    ],
                  ),
                ),
          bottomNavigationBar: Material(
            elevation: 10.0,
            color: Colors.transparent,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50.0),
              topRight: Radius.circular(50.0),
            ),
            child: BottomNavigationBar(
              backgroundColor: Colors.white,
              elevation: 10.0,
              selectedItemColor: AppColors.primary,
              unselectedItemColor: Colors.grey,
              type: BottomNavigationBarType.fixed,
              iconSize: 30.0,
              onTap: (index) {
                setState(() {});
                if (index == 0) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                } else if (index == 1) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => PricingScreen()),
                  );
                }
              },
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                  tooltip: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.subscriptions_outlined),
                  label: 'Subscription',
                  tooltip: 'Subscription',
                ),
              ],
            ),
          )),
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
