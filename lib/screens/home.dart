// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:hsmowers_app/models/auth_user_model.dart';
import 'package:hsmowers_app/providers/auth_user_provider.dart';
import 'package:hsmowers_app/screens/login.dart';
import 'package:hsmowers_app/screens/other_user_profile.dart';
import 'package:hsmowers_app/screens/user_info_screen.dart';
import 'package:hsmowers_app/screens/user_profile.dart';
import 'package:hsmowers_app/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hsmowers_app/widgets/find_mowers.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hsmowers_app/models/auth_user_model.dart' as model;
import 'package:hsmowers_app/providers/auth_user_provider.dart' as provider;

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int? _selectedConsent;
  bool _loading = true;
  List<Map<String, dynamic>> userData = [];
  String? enteredZipCode;
  String? initialZipCode;

  @override
  void initState() {
    super.initState();
    getData();
    checkAuthState();
  }

  Future<void> checkAuthState() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      ref.read(model.authUserProvider.notifier).updateUser(
            model.AuthUserModel(
              uid: user.uid,
              fullName: user.displayName ?? '',
              userName: '',
              phoneNumber: '',
              selectedServices: [],
              serviceDistance: 0.0,
              schoolName: '',
              photoURL: user.photoURL,
              selectedGrade: null,
              description: '',
              zipCode: '',
              isLoggedIn: true,
            ),
          );
    }
  }

  Future<void> getData() async {
    final collectionRef = FirebaseFirestore.instance.collection('userInfo');
    final query = collectionRef.orderBy('createdAt', descending: true).limit(4);

    try {
      final querySnapshot = await query.get();
      final List<Map<String, dynamic>> fetchedData = [];

      for (var doc in querySnapshot.docs) {
        print('${doc.id} => ${doc.data()}');
        fetchedData.add({
          'id': doc.id,
          ...doc.data(),
        });
      }

      if (fetchedData.isNotEmpty) {
        setState(() {
          userData = fetchedData;
        });
      }
    } catch (error) {
      print('Error fetching documents: $error');
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  void _handleSubmit() {
    if (_selectedConsent == 2 || _selectedConsent == 3) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'Confirm Your Status',
              style: AppTextStyles.h4.copyWith(color: Colors.black),
            ),
            content: Text('Sorry, we only have jobs for high school students.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } else if (_selectedConsent == 1) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => UserInfoScreen()));
    }
  }

  Future<void> _refreshData() async {
    setState(() {
      _loading = true;
      userData = [];
    });
    await getData();
  }

  Future<void> _getLocation() async {
    PermissionStatus permission = await Permission.location.request();
    if (!permission.isGranted) {
      print("Location permission denied");
      return;
    }

    try {
      double latitude = 39.9566;
      double longitude = -85.9668;

      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);
      if (placemarks.isEmpty) {
        print("No placemarks found");
        return;
      }

      Placemark place = placemarks.first;
      String zipCode = place.postalCode ?? 'No Zip Code Available';

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setDouble('latitude', latitude);
      await prefs.setDouble('longitude', longitude);
      await prefs.setString('zipCode', zipCode);

      setState(() {
        print(
            'User Location: Latitude: $latitude, Longitude: $longitude, Zip Code: $zipCode');
      });

      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => FindMowers(initialZipCode: zipCode)),
      );
    } catch (e) {
      print('Error getting location: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final authUser = ref.watch(model.authUserProvider);
    print(authUser.isLoggedIn);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: authUser.isLoggedIn
                  ? InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfileScreen()));
                      },
                      child: Icon(
                        Icons.person_2_outlined,
                        size: 32,
                      ),
                    )
                  : ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Login()),
                        );
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
            ),

            // InkWell(
            //   onTap: () {
            //     Navigator.push(context,
            //         MaterialPageRoute(builder: (context) => AuthScreen()));
            //   },
            //   child: Icon(Icons.person),
            // )
          ],
        ),
        body: RefreshIndicator(
          onRefresh: _refreshData,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 20),
                Center(
                    child: Image(
                        height: 130,
                        fit: BoxFit.cover,
                        image: AssetImage('images/hsmowerslogo.png'))),
                SizedBox(height: 30),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: 'Find your next',
                        style: AppTextStyles.h2.copyWith(color: Colors.black),
                        children: [
                          TextSpan(
                            text: ' Mower',
                            style: TextStyle(color: AppColors.primary),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 5),
                    Center(
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.only(left: 40, right: 40),
                        child: Text(
                          'No Ads. No SignUp. Support local students & get a great looking lawn',
                          style: AppTextStyles.h6.copyWith(color: Colors.black),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    SizedBox(height: 15),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            WidgetStateProperty.all(AppColors.primaryDark),
                      ),
                      onPressed: _getLocation,
                      child: Text(
                        'Find Mower',
                        style: AppTextStyles.h5.copyWith(color: Colors.white),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 40),
                InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return StatefulBuilder(
                          builder: (context, setState) {
                            return Material(
                              color: Colors.transparent,
                              child: AlertDialog(
                                title: Row(
                                  children: [
                                    Text(
                                      'Consent Form',
                                      style: AppTextStyles.h4
                                          .copyWith(color: Colors.black),
                                    ),
                                    SizedBox(
                                      width: 60,
                                    ),
                                    InkWell(
                                        onTap: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Icon(Icons.close)),
                                  ],
                                ),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ListTile(
                                      leading: Radio<int>(
                                        value: 1,
                                        groupValue: _selectedConsent,
                                        onChanged: (int? value) {
                                          setState(() {
                                            _selectedConsent = value;
                                          });
                                          this.setState(() {});
                                        },
                                      ),
                                      title: Text(
                                          'Yes, I am over 13 years old and I am currently enrolled in High School'),
                                    ),
                                    ListTile(
                                      leading: Radio<int>(
                                        value: 2,
                                        groupValue: _selectedConsent,
                                        onChanged: (int? value) {
                                          setState(() {
                                            _selectedConsent = value;
                                          });
                                          this.setState(() {});
                                        },
                                      ),
                                      title: Text(
                                          'No, I am not over 13 years old'),
                                    ),
                                    ListTile(
                                      leading: Radio<int>(
                                        value: 3,
                                        groupValue: _selectedConsent,
                                        onChanged: (int? value) {
                                          setState(() {
                                            _selectedConsent = value;
                                          });
                                          this.setState(() {});
                                        },
                                      ),
                                      title: Text(
                                          'No, I am not currently enrolled in High School.'),
                                    ),
                                    SizedBox(height: 10),
                                    ElevatedButton(
                                      style: ButtonStyle(
                                          backgroundColor:
                                              WidgetStateProperty.all(
                                                  AppColors.primaryDark)),
                                      onPressed: _handleSubmit,
                                      child: Text(
                                        'Submit',
                                        style: AppTextStyles.h5
                                            .copyWith(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                  child: Text(
                    'Student? Signup!',
                    style: AppTextStyles.h5.copyWith(
                        decoration: TextDecoration.underline,
                        color: Colors.black),
                  ),
                ),
                SizedBox(height: 40),
                Text(
                  'Recently Created Profiles',
                  style: AppTextStyles.h4.copyWith(color: Colors.black),
                ),
                SizedBox(height: 20),
                _loading
                    ? Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primary,
                        ),
                      )
                    : userData.isEmpty
                        ? Center(
                            child: Text(
                              'No profiles available',
                              style: AppTextStyles.h5,
                            ),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: userData.length,
                            itemBuilder: (context, index) {
                              final username =
                                  userData[index]['userName'] ?? 'No Username';
                              return Container(
                                margin: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 16),
                                decoration: BoxDecoration(
                                  border: Border.all(color: AppColors.primary),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: ListTile(
                                  contentPadding: EdgeInsets.all(10),
                                  trailing: CircleAvatar(
                                    backgroundImage:
                                        userData[index]['photoURL'] != null
                                            ? NetworkImage(
                                                userData[index]['photoURL'])
                                            : AssetImage('images/mowers1.jpg')
                                                as ImageProvider,
                                  ),
                                  title: Text(
                                    userData[index]['displayName'] ?? 'No Name',
                                    style: AppTextStyles.h5
                                        .copyWith(color: Colors.black),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        {
                                              '9': 'Freshman',
                                              '10': 'Sophomore',
                                              '11': 'Junior',
                                              '12': 'Senior',
                                            }[userData[index]['grade']] ??
                                            'No Grade',
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        userData[index]['services']
                                                ?.join(', ') ??
                                            'No Services Listed',
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            OtherUsers(username: username),
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                          ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
