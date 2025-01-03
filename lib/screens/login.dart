// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hsmowers_app/screens/user_profile.dart';
import 'package:hsmowers_app/theme.dart';
import 'package:hsmowers_app/widgets/google_maps.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (isLoggedIn) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const UserProfile(),
        ),
      );
    }
  }

  Future<void> storeUserDataInPreferences(Map<String, dynamic> userData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString('userName', userData['userName'] ?? '');
    await prefs.setString('email', userData['email'] ?? '');
    await prefs.setString('photoURL', userData['photoURL'] ?? '');
    await prefs.setString('uid', userData['uid'] ?? '');
    await prefs.setString('displayName', userData['displayName'] ?? '');
    await prefs.setString('grade', userData['grade'] ?? '');
    await prefs.setString('description', userData['description'] ?? '');

    if (userData['serviceArea'] != null && userData['serviceArea'] is List) {
      String serviceAreaJson = jsonEncode(userData['serviceArea']);
      await prefs.setString('serviceArea', serviceAreaJson);
    }

    if (userData['services'] != null && userData['services'] is List) {
      String servicesJson = jsonEncode(userData['services']);
      await prefs.setString('services', servicesJson);
    }

    await prefs.setBool('isLoggedIn', true);
  }

  Future<String?> login({
    required String email,
    required String password,
  }) async {
    setState(() {
      _isLoading = true;
    });

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('userInfo')
          .doc(userCredential.user?.uid)
          .get();

      if (userSnapshot.exists) {
        var userData = userSnapshot.data() as Map<String, dynamic>;
        await storeUserDataInPreferences(userData);

        if (userData['serviceArea'] != null &&
            userData['serviceArea'] is List &&
            userData['serviceArea'].isNotEmpty) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const UserProfile(),
            ),
          );
        } else {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const GoogleMaps(),
            ),
          );
        }

        return 'Success';
      } else {
        return 'User data not found.';
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided for that user.';
      } else {
        return e.message ?? 'An unknown error occurred.';
      }
    } catch (e) {
      return 'An error occurred. Please try again.';
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Widget buildInputField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    bool obscureText = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: TextFormField(
        controller: controller,
        cursorColor: AppColors.textColorLight,
        obscureText: obscureText,
        decoration: InputDecoration(
          filled: true,
          hintText: hintText,
          prefixIcon: Icon(icon, color: AppColors.primary),
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: AppColors.borderColor,
              width: 2,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: AppColors.borderColor,
              width: 2,
            ),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '$hintText is required.';
          }
          return null;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                      height: 80, image: AssetImage('images/hsmowerslogo.png')),
                  SizedBox(height: 30),
                  Text('Login', style: AppTextStyles.h2),
                  SizedBox(height: 30),
                  buildInputField(
                    controller: _emailController,
                    hintText: 'Email',
                    icon: Icons.email,
                  ),
                  SizedBox(height: 20),
                  buildInputField(
                    controller: _passwordController,
                    hintText: 'Password',
                    icon: Icons.lock,
                    obscureText: true,
                  ),
                  SizedBox(height: 30),
                  InkWell(
                    onTap: () async {
                      if (_formKey.currentState?.validate() ?? false) {
                        final message = await login(
                          email: _emailController.text.trim(),
                          password: _passwordController.text.trim(),
                        );

                        if (message == 'Success') {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => const GoogleMaps(),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(message!),
                              backgroundColor: message.contains('Success')
                                  ? Colors.green
                                  : Colors.red,
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
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Center(
                          child: _isLoading
                              ? CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : Text(
                                  'Login',
                                  style: AppTextStyles.h4
                                      .copyWith(color: Colors.white),
                                ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Forget Password?',
                    style: AppTextStyles.h5.copyWith(
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text('Login using', style: AppTextStyles.h6),
                  Image(
                      height: 50,
                      image: AssetImage('images/continuewithgoogle.png')),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
