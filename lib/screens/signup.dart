// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'package:flutter/material.dart';
import 'package:hsmowers_app/screens/login.dart';
import 'package:hsmowers_app/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
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
  final GoogleSignIn _googleSignIn = GoogleSignIn();

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

      try {
        await userCredential.user?.sendEmailVerification();
      } catch (verificationError) {
        print('Error sending verification email: $verificationError');
        return 'Account created but failed to send verification email. Please try requesting it again after logging in.';
      }

      final prefs = await SharedPreferences.getInstance();
      String? userInfoString = prefs.getString('UserInfo_Shared_Perference');

      if (userInfoString != null) {
        Map<String, dynamic> userInfo = jsonDecode(userInfoString);
        userInfo['email'] = email;
        userInfo['createdAt'] = FieldValue.serverTimestamp();
        userInfo['uid'] = userCredential.user?.uid;

        try {
          await FirebaseFirestore.instance
              .collection('userInfo')
              .doc(userCredential.user?.uid)
              .set(userInfo);
          print('User data saved to Firestore successfully');
        } catch (firestoreError) {
          print('Error saving to Firestore: $firestoreError');
          return 'Account created but failed to save user data. Please update your profile after logging in.';
        }

        try {
          await prefs.setString(
              'UserInfo_Shared_Perference', jsonEncode(userInfo));
          print('User data saved to SharedPreferences successfully');
        } catch (prefsError) {
          print('Error saving to SharedPreferences: $prefsError');
        }

        return 'A verification email has been sent to $email. Please verify your email to continue.';
      } else {
        return 'User info not found in SharedPreferences.';
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      } else {
        print('Firebase Auth Error: ${e.code} - ${e.message}');
        return e.message;
      }
    } catch (e) {
      print('Unexpected error during registration: $e');
      return 'An unexpected error occurred. Please try again.';
    }
  }

  void _handleSignup() async {
    setState(() {
      _isLoading = true;
    });

    final message = await registration(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    );

    setState(() {
      _isLoading = false;
    });

    if (message!.contains('verification email')) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 5),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
      _showVerificationDialog();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
    }
  }

  Future<String?> signUpWithGoogle() async {
    try {
      GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      final prefs = await SharedPreferences.getInstance();
      String? userInfoString = prefs.getString('UserInfo_Shared_Perference');

      if (userInfoString != null) {
        Map<String, dynamic> userInfo = jsonDecode(userInfoString);
        userInfo['email'] = userCredential.user?.email;
        userInfo['uid'] = userCredential.user?.uid;
        userInfo['createdAt'] = FieldValue.serverTimestamp();

        await FirebaseFirestore.instance
            .collection('userInfo')
            .doc(userCredential.user?.uid)
            .set(userInfo);
        print('User data saved to Firestore successfully');

        await prefs.setString(
            'UserInfo_Shared_Perference', jsonEncode(userInfo));
        print('User data saved to SharedPreferences successfully');

        return 'Successfully signed in with Google!';
      } else {
        return 'User info not found in SharedPreferences.';
      }
    } catch (e) {
      print('Error during Google sign-in: $e');
      return 'An error occurred during Google sign-in. Please try again.';
    }
  }

  void _showVerificationDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Verify Your Email'),
          content: Text(
              'A verification email has been sent to ${_emailController.text}. Please verify your email and log in.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const Login()),
                );
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
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
                    obscureText: true,
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
                  onTap: _handleSignup,
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
                // Text('Signup using', style: AppTextStyles.h6),
                // InkWell(
                //   onTap: signUpWithGoogle,
                //   child: SizedBox(
                //     height: 50,
                //     width: double.infinity,
                //     child: Image.asset('images/continuewithgoogle.png'),
                //   ),
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
