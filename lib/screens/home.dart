// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:hsmowers_app/screens/login.dart';
import 'package:hsmowers_app/screens/pricing_screen.dart';
import 'package:hsmowers_app/screens/signup.dart';
import 'package:hsmowers_app/theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int? _selectedConsent;

  void _handleSubmit() {
    if (_selectedConsent == 2 || _selectedConsent == 3) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Confirm Your Status',
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
          context, MaterialPageRoute(builder: (context) => Signup()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
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
                  Padding(
                    padding: const EdgeInsets.only(left: 30, right: 30),
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Enter zip code or address',
                        suffixIcon: Icon(Icons.search),
                        filled: true,
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide:
                              BorderSide(color: AppColors.textColorLight),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide(color: AppColors.primary),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            WidgetStateProperty.all(AppColors.primaryDark),
                      ),
                      onPressed: () {},
                      child: Text(
                        'Find Mower',
                        style: AppTextStyles.h5.copyWith(color: Colors.white),
                      )),
                ],
              ),
              SizedBox(height: 40),
              InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Material(
                        color: Colors.transparent,
                        child: AlertDialog(
                          title: Text('Consent Form', style: AppTextStyles.h4.copyWith(color: Colors.black),),
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
                                  },
                                ),
                                title: Text('No, I am not over 13 years old'),
                              ),
                              ListTile(
                                leading: Radio<int>(
                                  value: 3,
                                  groupValue: _selectedConsent,
                                  onChanged: (int? value) {
                                    setState(() {
                                      _selectedConsent = value;
                                    });
                                  },
                                ),
                                title: Text(
                                    'No, I am not currently enrolled in High School.'),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor: WidgetStateProperty.all(
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
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('Close'),
                            ),
                          ],
                        ),
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
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 4,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.primary),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(10),
                      trailing: CircleAvatar(
                        backgroundImage: AssetImage('images/mowers1.jpg'),
                      ),
                      title: Text('Muhammad Shahzad'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Senior'),
                          SizedBox(height: 4),
                          Text(
                            'Mowing, Weeding, Leaf-Removal',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  );
                },
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
                    MaterialPageRoute(builder: (context) => PricingScreen()),
                  );
                },
                child: Icon(Icons.subscriptions_outlined),
              ),
              label: 'Pricing',
              tooltip: 'Pricing',
            ),
            BottomNavigationBarItem(
              icon: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Login()),
                  );
                },
                child: Icon(Icons.login),
              ),
              label: 'Login',
              tooltip: 'Login',
            ),
          ]),
        ),
      ),
    );
  }
}
