// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hsmowers_app/screens/auth.dart';
import 'package:hsmowers_app/screens/login.dart';
import 'package:hsmowers_app/screens/other_user_profile.dart';
import 'package:hsmowers_app/screens/user_info_screen.dart';
import 'package:hsmowers_app/screens/user_profile.dart';
import 'package:hsmowers_app/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hsmowers_app/widgets/find_mowers.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int? _selectedConsent;
  bool _loading = true;
  List<Map<String, dynamic>> userData = [];
  String? enteredZipCode;
  String? photoURL;
  String? displayName;
  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    getData();
    _listenAuthChanges();
    _getPhotoURL();
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

  void _listenAuthChanges() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      setState(() {
        if (user != null) {
          isLoggedIn = true;
          _getUserData(user);
        } else {
          isLoggedIn = false;
          _loading = false;
        }
      });
    });
  }

  Future<void> _getUserData(User user) async {
    User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      setState(() {
        isLoggedIn = true;
      });

      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('userInfo')
          .doc(currentUser.uid)
          .get();

      if (userSnapshot.exists) {
        setState(() {
          displayName = userSnapshot['displayName'] ?? 'No Name';
          photoURL = userSnapshot['photoURL'] ?? currentUser.photoURL;
          _loading = false;
        });
      }
    } else {
      setState(() {
        isLoggedIn = false;
        _loading = false;
      });
    }
  }

  Future<void> _getPhotoURL() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedPhotoURL = prefs.getString('photoURL');
    setState(() {
      photoURL = storedPhotoURL;
    });
  }

  Future<void> _refreshData() async {
    setState(() {
      _loading = true;
      userData = [];
    });
    await getData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: isLoggedIn && photoURL != null
                  ? InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AuthScreen(),
                          ),
                        );
                      },
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(photoURL!),
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
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FindMowers()));
                      },
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
                                // actions: [
                                //   TextButton(
                                //     onPressed: () {
                                //       Navigator.of(context).pop();
                                //     },
                                //     child: Text('Close'),
                                //   ),
                                // ],
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
        // bottomNavigationBar: Container(
        //   decoration: BoxDecoration(
        //     color: Colors.white,
        //     boxShadow: [
        //       BoxShadow(
        //         color: Colors.grey.withOpacity(0.2),
        //         spreadRadius: 5,
        //         blurRadius: 10,
        //         offset: Offset(0, -2),
        //       ),
        //     ],
        //     borderRadius: BorderRadius.only(
        //       topLeft: Radius.circular(30.0),
        //       topRight: Radius.circular(30.0),
        //     ),
        //   ),
        //   child: BottomNavigationBar(
        //     backgroundColor: Colors.white,
        //     elevation: 10.0,
        //     selectedItemColor: AppColors.primary,
        //     unselectedItemColor: Colors.grey,
        //     type: BottomNavigationBarType.fixed,
        //     iconSize: 30.0,
        //     onTap: (index) {
        //       setState(() {});
        //       if (index == 0) {
        //         Navigator.pushReplacement(
        //           context,
        //           MaterialPageRoute(builder: (context) => HomeScreen()),
        //         );
        //       } else if (index == 1) {
        //         Navigator.pushReplacement(
        //           context,
        //           MaterialPageRoute(builder: (context) => PricingScreen()),
        //         );
        //       } else if (index == 2) {
        //         Navigator.pushReplacement(
        //           context,
        //           MaterialPageRoute(builder: (context) => Login()),
        //         );
        //       }
        //     },
        //     items: [
        //       BottomNavigationBarItem(
        //         icon: Icon(Icons.home),
        //         label: 'Home',
        //         tooltip: 'Home',
        //       ),
        //       BottomNavigationBarItem(
        //         icon: Icon(Icons.subscriptions_rounded),
        //         label: 'Pricing',
        //         tooltip: 'Pricing',
        //       ),
        //       BottomNavigationBarItem(
        //         icon: Icon(Icons.login),
        //         label: 'Login',
        //         tooltip: 'Login',
        //       ),
        //     ],
        //   ),
        // ),
      ),
    );
  }
}
