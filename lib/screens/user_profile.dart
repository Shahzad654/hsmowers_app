// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, empty_catches

import 'dart:convert';

import 'package:flutter/material.dart';
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
  String? grade;
  String? description;
  String? serviceArea;
  String? services;
  bool? isAuth;
  String? staticMapUrl;
  bool isLoading = true;

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
    String? storedDescription = prefs.getString('description');
    String? storedGrade = prefs.getString('grade');
    String? storedServiceArea = prefs.getString('serviceArea');
    String? storedServices = prefs.getString('services');
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
      description = storedDescription;
      grade = storedGrade;
      isAuth = storedAuth;
      serviceArea = storedServiceArea;
      serviceArea = decodedServiceArea?.join(', ') ?? 'No service area';
      services = decodedServices?.join(', ') ?? 'No services';
      isLoading = false;
    });
  }

  void _generateStaticMapUrl(List<dynamic>? serviceArea) {
    if (serviceArea != null && serviceArea.isNotEmpty) {
      String apiKey = 'AIzaSyDfDJ9e4SK6WIpdbLtq4LrztIXu7lywgb0';
      String path = serviceArea.map((coord) {
        return '${coord["latitude"]},${coord["longitude"]}';
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
              ? Center(child: CircularProgressIndicator())
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
                              onPressed: () {},
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
                      Text(services != null && services!.isNotEmpty
                          ? services!
                          : 'No services available')

                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   crossAxisAlignment: CrossAxisAlignment.center,
                      //   children: [
                      //     CircleAvatar(
                      //       maxRadius: 40,
                      //       backgroundImage: NetworkImage(
                      //           'https://cdn.pixabay.com/photo/2022/07/07/20/57/woman-7308033_640.jpg'),
                      //     ),
                      //     SizedBox(
                      //       width: 20,
                      //     ),
                      //     CircleAvatar(
                      //       maxRadius: 40,
                      //       backgroundImage: AssetImage('images/mowers1.jpg'),
                      //     ),
                      //     SizedBox(
                      //       width: 20,
                      //     ),
                      //     CircleAvatar(
                      //       maxRadius: 40,
                      //       backgroundImage: NetworkImage(
                      //           'https://cdn.pixabay.com/photo/2018/03/15/22/37/siberia-3229747_1280.jpg'),
                      //     )
                      //   ],
                      // )
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
            child: BottomNavigationBar(items: [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  color: AppColors.primary,
                ),
                label: 'Home',
                tooltip: 'Home',
              ),
              BottomNavigationBarItem(
                icon: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PricingScreen()));
                  },
                  child: Icon(Icons.subscriptions_outlined),
                ),
                label: 'Subscription',
                tooltip: 'Subscription',
              ),
            ]),
          )),
    );
  }
}
