// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, use_super_parameters

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hsmowers_app/theme.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OtherUsers extends StatefulWidget {
  final String username;

  const OtherUsers({required this.username, Key? key}) : super(key: key);

  @override
  _OtherUsersState createState() => _OtherUsersState();
}

class _OtherUsersState extends State<OtherUsers> {
  Map<String, dynamic>? userData;
  bool isLoading = true;
  String? staticMapUrl;

  String weedingIcon = 'images/weeding.svg';
  String mowersIcon = 'images/mowers.svg';
  String leafremovalIcon = 'images/leafremoval.svg';
  String dogwalkingIcon = 'images/dogwalking.svg';
  String edgingIcon = 'images/edging.svg';
  String snowremovalIcon = 'images/snowremoval.svg';
  String babysittingIcon = 'images/babysitting.svg';
  String windowcleaningIcon = 'images/windowcleaning.svg';

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('userInfo')
          .where('userName', isEqualTo: widget.username)
          .get();

      if (snapshot.docs.isNotEmpty) {
        setState(() {
          userData = snapshot.docs.first.data();
          print(userData!['services']);
          isLoading = false;
        });
      } else {
        setState(() {
          userData = null;
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error fetching user data: $e');
    }
  }

  void _generateStaticMapUrl(dynamic serviceAreaData) {
    try {
      if (serviceAreaData != null && serviceAreaData is Map) {
        print("ServiceArea data: $serviceAreaData");

        var pathPoints = serviceAreaData['path'];
        if (pathPoints != null && pathPoints is List) {
          String apiKey = 'AIzaSyDfDJ9e4SK6WIpdbLtq4LrztIXu7lywgb0';
          String pathCoords = pathPoints.map((coord) {
            print("Coordinate: $coord");
            return '${coord["lat"]},${coord["lng"]}';
          }).join('|');

          setState(() {
            staticMapUrl =
                'https://maps.googleapis.com/maps/api/staticmap?size=600x400&path=color:0xff0000|weight:5|$pathCoords&key=$apiKey';
          });
        }
      }
    } catch (e) {
      print("Error generating map URL: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (userData != null && userData!['serviceArea'] != null) {
      _generateStaticMapUrl(userData!['serviceArea']);
    }

    return SafeArea(
      child: Scaffold(
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(
                color: AppColors.primary,
              ))
            : userData != null
                ? SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 20),
                        Center(
                          child: CircleAvatar(
                            maxRadius: 60,
                            backgroundImage: userData!['photoURL'] != null
                                ? NetworkImage(userData!['photoURL'])
                                : AssetImage('images/profile.jpg')
                                    as ImageProvider,
                          ),
                        ),
                        SizedBox(height: 10),
                        Center(
                          child: Text(
                            userData!['displayName'] ?? '',
                            style:
                                AppTextStyles.h3.copyWith(color: Colors.black),
                          ),
                        ),
                        SizedBox(height: 10),
                        Center(
                          child: Text(
                            userData!['grade'] ?? '',
                            style:
                                AppTextStyles.h6.copyWith(color: Colors.black),
                          ),
                        ),
                        SizedBox(height: 10),
                        Center(
                          child: ConstrainedBox(
                            constraints: BoxConstraints(maxWidth: 350),
                            child: Text(
                              userData!['description'] ?? '',
                              textAlign: TextAlign.center,
                              style: AppTextStyles.para
                                  .copyWith(color: Colors.black),
                            ),
                          ),
                        ),
                        SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
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
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 50),
                        if (staticMapUrl != null)
                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(24),
                              child: Image.network(staticMapUrl!),
                            ),
                          ),
                        SizedBox(height: 50),
                        Text(
                          'Services',
                          style: AppTextStyles.h3.copyWith(color: Colors.black),
                        ),
                        SizedBox(height: 20),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Center(
                              child: Wrap(
                                alignment: WrapAlignment.center,
                                spacing: 15,
                                runSpacing: 15,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      if (userData!['services']
                                              .map((service) => service.trim())
                                              .contains('Weeding') ||
                                          userData!['services']
                                              .map((service) => service.trim())
                                              .contains('weeding'))
                                        Column(
                                          children: [
                                            Container(
                                              height: 50,
                                              width: 50,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                color: AppColors.primary,
                                              ),
                                              child: SvgPicture.asset(
                                                weedingIcon,
                                                width: 40,
                                                height: 40,
                                              ),
                                            ),
                                            Text('Weeding')
                                          ],
                                        ),
                                      SizedBox(width: 15),
                                      if (userData!['services']
                                              .map((service) => service.trim())
                                              .contains('Mowers') ||
                                          userData!['services']
                                              .map((service) => service.trim())
                                              .contains('mowing'))
                                        Column(
                                          children: [
                                            Container(
                                              height: 50,
                                              width: 50,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                color: AppColors.primary,
                                              ),
                                              child: SvgPicture.asset(
                                                mowersIcon,
                                                width: 40,
                                                height: 40,
                                              ),
                                            ),
                                            Text('Mowers')
                                          ],
                                        ),
                                      SizedBox(width: 15),
                                      if (userData!['services']
                                              .map((service) => service.trim())
                                              .contains('Edging') ||
                                          userData!['services']
                                              .map((service) => service.trim())
                                              .contains('edging'))
                                        Column(
                                          children: [
                                            Container(
                                              height: 50,
                                              width: 50,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                color: AppColors.primary,
                                              ),
                                              child: SvgPicture.asset(
                                                edgingIcon,
                                                width: 40,
                                                height: 40,
                                              ),
                                            ),
                                            Text('Edging')
                                          ],
                                        ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      if (userData!['services']
                                              .map((service) => service.trim())
                                              .contains('Window Cleaning') ||
                                          userData!['services']
                                              .map((service) => service.trim())
                                              .contains('window-cleaning'))
                                        Column(
                                          children: [
                                            Container(
                                              height: 50,
                                              width: 50,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                color: AppColors.primary,
                                              ),
                                              child: SvgPicture.asset(
                                                windowcleaningIcon,
                                                width: 40,
                                                height: 40,
                                              ),
                                            ),
                                            Text('Window Cleaning')
                                          ],
                                        ),
                                      SizedBox(width: 15),
                                      if (userData!['services']
                                              .map((service) => service.trim())
                                              .contains('Snow Removal') ||
                                          userData!['services']
                                              .map((service) => service.trim())
                                              .contains('snow-removal'))
                                        Column(
                                          children: [
                                            Container(
                                              height: 50,
                                              width: 50,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                color: AppColors.primary,
                                              ),
                                              child: SvgPicture.asset(
                                                snowremovalIcon,
                                                width: 40,
                                                height: 40,
                                              ),
                                            ),
                                            Text('Snow Removal')
                                          ],
                                        ),
                                      SizedBox(width: 15),
                                      if (userData!['services']
                                              .map((service) => service.trim())
                                              .contains('Baby Sitting') ||
                                          userData!['services']
                                              .map((service) => service.trim())
                                              .contains('baby-sitting'))
                                        Column(
                                          children: [
                                            Container(
                                              height: 50,
                                              width: 50,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                color: AppColors.primary,
                                              ),
                                              child: SvgPicture.asset(
                                                babysittingIcon,
                                                width: 40,
                                                height: 40,
                                              ),
                                            ),
                                            Text('Baby Sitting')
                                          ],
                                        ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      if (userData!['services']
                                              .map((service) => service.trim())
                                              .contains('Leaf Removal') ||
                                          userData!['services']
                                              .map((service) => service.trim())
                                              .contains('leaf-removal'))
                                        Column(
                                          children: [
                                            Container(
                                              height: 50,
                                              width: 50,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                color: AppColors.primary,
                                              ),
                                              child: SvgPicture.asset(
                                                leafremovalIcon,
                                                width: 40,
                                                height: 40,
                                              ),
                                            ),
                                            Text('Leaf Removal')
                                          ],
                                        ),
                                      SizedBox(width: 15),
                                      if (userData!['services']
                                              .map((service) => service.trim())
                                              .contains('Dog Walking') ||
                                          userData!['services']
                                              .map((service) => service.trim())
                                              .contains('dog-walking'))
                                        Column(
                                          children: [
                                            Container(
                                              height: 50,
                                              width: 50,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                color: AppColors.primary,
                                              ),
                                              child: SvgPicture.asset(
                                                dogwalkingIcon,
                                                width: 40,
                                                height: 40,
                                              ),
                                            ),
                                            Text('Dog Walking')
                                          ],
                                        ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                : Center(
                    child: Text(
                      'User not found',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
      ),
    );
  }
}
