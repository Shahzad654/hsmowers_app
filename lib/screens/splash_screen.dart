// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hsmowers_app/screens/home.dart';
import 'package:hsmowers_app/theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    redirectToLogin();
  }

  void redirectToLogin() {
    Timer.periodic(Duration(seconds: 4), (timer) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
              child: Image(
                  height: 200, image: AssetImage('images/hsmowerslogo.png'))),
          SizedBox(
            height: 25,
          ),
          Center(
              child: Text('HS Mowers',
                  style: AppTextStyles.h2.copyWith(color: Colors.white)))
        ],
      ),
    );
  }
}
