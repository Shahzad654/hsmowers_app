// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:hsmowers_app/screens/login.dart';
import 'package:hsmowers_app/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

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
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final prefs = await SharedPreferences.getInstance();
      String? userInfoString = prefs.getString('UserInfo_Shared_Perference');

      if (userInfoString != null) {
        Map<String, dynamic> userInfo = jsonDecode(userInfoString);

        userInfo['email'] = email;
        userInfo['createdAt'] = FieldValue.serverTimestamp();
        userInfo['uid'] = userCredential.user?.uid;

        await FirebaseFirestore.instance
            .collection('userInfo')
            .doc(userCredential.user?.uid)
            .set(userInfo);

        print('User info saved to Firestore successfully');
      }

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

  void _handleSignup() async {
    setState(() {
      _isLoading = true;
    });

    final message = await registration(
      email: _emailController.text,
      password: _passwordController.text,
    );

    setState(() {
      _isLoading = false;
    });

    if (message!.contains('Success')) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const Login()),
      );
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor:
            message.contains('Success') ? Colors.green : Colors.red,
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        action: SnackBarAction(
          label: 'Dismiss',
          textColor: Colors.white,
          onPressed: () {},
        ),
      ),
    );
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
                onTap: _handleSignup, // Call the signup method
                child: Padding(
                  padding: EdgeInsets.only(left: 30, right: 30),
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(24)),
                    child: Center(
                      child: _isLoading // Check loading state
                          ? CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : Text(
                              'Sign up',
                              style: AppTextStyles.h4
                                  .copyWith(color: Colors.white),
                            ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text('Signup using', style: AppTextStyles.h6),
              Image(height: 50, image: AssetImage('images/google.jpg'))
            ],
          ),
        ),
      ),
    );
  }
}
