// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:hsmowers_app/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hsmowers_app/widgets/google_maps.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<Map<String, dynamic>> getUserInfo() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String? userInfoString = prefs.getString('UserInfo_Shared_Perference');

      if (userInfoString != null) {
        return jsonDecode(userInfoString);
      } else {
        return {};
      }
    } catch (e) {
      print('Error retrieving shared preference: $e');
      return {};
    }
  }

  Future<String?> registration({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return 'Success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      } else {
        return e.message;
      }
    } catch (e) {
      return e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image(height: 80, image: AssetImage('images/hsmowerslogo.png')),
              SizedBox(
                height: 30,
              ),
              Text(
                'Sign up',
                style: AppTextStyles.h2,
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: EdgeInsets.only(left: 30, right: 30),
                child: TextFormField(
                  cursorColor: AppColors.textColorLight,
                  controller: _emailController,
                  decoration: InputDecoration(
                      filled: true,
                      hintText: 'Email',
                      prefixIcon: Icon(
                        Icons.email,
                        color: AppColors.primary,
                      ),
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: AppColors.borderColor,
                            width: 2,
                          )),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                              color: AppColors.borderColor, width: 2))),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: EdgeInsets.only(left: 30, right: 30),
                child: TextFormField(
                  cursorColor: AppColors.textColorLight,
                  controller: _passwordController,
                  decoration: InputDecoration(
                      filled: true,
                      hintText: 'Password',
                      prefixIcon: Icon(
                        Icons.visibility,
                        color: AppColors.primary,
                      ),
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: AppColors.borderColor,
                            width: 2,
                          )),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                              color: AppColors.borderColor, width: 2))),
                ),
              ),
              SizedBox(
                height: 30,
              ),

              InkWell(
                onTap: () async {
                  final message = await registration(
                    email: _emailController.text,
                    password: _passwordController.text,
                  );
                  if (message!.contains('Success')) {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const GoogleMaps()));
                  }
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(message),
                    ),
                  );
                },
                child: Padding(
                  padding: EdgeInsets.only(left: 30, right: 30),
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(24)),
                    child: Center(
                        child: Text('Sign up',
                            style: AppTextStyles.h4
                                .copyWith(color: Colors.white))),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),

              // Text('Forget Password?', style: AppTextStyles.h5.copyWith(decoration: TextDecoration.underline)),
              //  SizedBox(
              //   height: 20,
              // ),
              Text('Signup using', style: AppTextStyles.h6),
              Image(height: 50, image: AssetImage('images/google.jpg'))
            ],
          ),
        ),
      ),
    );
  }
}
