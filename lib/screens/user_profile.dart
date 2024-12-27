// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:hsmowers_app/screens/pricing_screen.dart';
import 'package:hsmowers_app/theme.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            actions: [
             
              PopupMenuButton(
                icon: Icon(Icons.more_vert, size: 35,),
                itemBuilder: (context)=>[
                
                PopupMenuItem(
                  value: 1,
                  child: Text(('Logout'), style: AppTextStyles.h5.copyWith(color: Colors.black),)
                  )
              ])
            ],
          ),
          
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: CircleAvatar(
                    maxRadius: 60,
                    backgroundImage: AssetImage('images/profile.jpg'),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                    child: Text(
                  'Muhammad Shahzad',
                  style: AppTextStyles.h3.copyWith(color: Colors.black),
                )),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: Text(
                    'Freshman.UET',
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
                      'Hello, I am Muhammad Shahzad providing mowers service. For any queries please contact me.',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.para.copyWith(color: Colors.black),
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
                          style: AppTextStyles.h5.copyWith(color: Colors.white),
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
                          style: AppTextStyles.h5.copyWith(color: Colors.white),
                        )),
                  ],
                ),
                // ElevatedButton(
                //     style: ButtonStyle(
                //         backgroundColor:
                //             MaterialStateProperty.all(AppColors.primaryDark)),
                //     onPressed: () {},
                //     child: Text(
                //       'Contact',
                //       style: AppTextStyles.h5.copyWith(color: Colors.white),
                //     )),
                SizedBox(
                  height: 50,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Image(
                    image: AssetImage('images/map.png'),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      maxRadius: 40,
                      backgroundImage: NetworkImage(
                          'https://cdn.pixabay.com/photo/2022/07/07/20/57/woman-7308033_640.jpg'),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    CircleAvatar(
                      maxRadius: 40,
                      backgroundImage: AssetImage('images/mowers1.jpg'),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    CircleAvatar(
                      maxRadius: 40,
                      backgroundImage: NetworkImage(
                          'https://cdn.pixabay.com/photo/2018/03/15/22/37/siberia-3229747_1280.jpg'),
                    )
                  ],
                )
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
              // BottomNavigationBarItem(
              //   icon: InkWell(
              //     onTap: () {

              //     },
              //     child: Icon(Icons.login),
              //   ),
              //   label: 'Login',
              //   tooltip: 'Login',
              // ),
            ]),
          )),
    );
  }
}
