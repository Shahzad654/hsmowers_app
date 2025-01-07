// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hsmowers_app/models/auth_user_model.dart';
import 'package:hsmowers_app/screens/auth.dart';
import 'package:hsmowers_app/theme.dart';
import 'package:hsmowers_app/widgets/google_maps.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _resetEmailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  Future<void> storeUserDataInPreferences(Map<String, dynamic> userData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (userData['serviceArea'] != null) {
      if (userData['serviceArea']['path'] != null) {
        await prefs.setString(
            'serviceArea', jsonEncode(userData['serviceArea']['path']));
      } else {
        await prefs.setString(
            'serviceArea', jsonEncode(userData['serviceArea']));
      }
    }
  }

  Future<String?> login({
    required String email,
    required String password,
    required WidgetRef ref,
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

        ref.read(authUserProvider.notifier).updateUser(
              AuthUserModel(
                uid: userCredential.user!.uid,
                fullName: userData['displayName'],
                userName: userData['userName'],
                phoneNumber: userData['phoneNumber'],
                selectedServices: List<String>.from(userData['services']),
                serviceDistance: userData['serviceDistance'],
                schoolName: userData['schoolName'],
                photoURL: userData['photoURL'],
                selectedGrade: userData['grade'],
                description: userData['description'],
                zipCode: userData['zipCode'],
                isLoggedIn: true,
              ),
            );

        ref.read(authUserProvider.notifier).loadUserData();

        if (userData['serviceArea'] != null &&
            userData['serviceArea'] is Map &&
            userData['serviceArea']['path'] != null &&
            userData['serviceArea']['path'] is List &&
            (userData['serviceArea']['path'] as List).isNotEmpty) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const AuthScreen(),
            ),
          );
          return 'Successfully Logged In';
        } else {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const GoogleMaps(),
            ),
          );
          return 'Success-maps';
        }
      } else {
        return 'User data not found.';
      }
    } on FirebaseAuthException catch (e) {
      return _getReadableErrorMessage(e.code);
    } catch (e) {
      return 'Unable to sign in. Please try again later.';
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  String _getReadableErrorMessage(String errorCode) {
    switch (errorCode) {
      case 'user-not-found':
      case 'wrong-password':
      case 'invalid-email':
        return 'Invalid email or password.';
      case 'user-disabled':
        return 'This account has been disabled.';
      case 'too-many-requests':
        return 'Too many failed attempts. Please try again later.';
      case 'network-request-failed':
        return 'Network error. Please check your connection.';
      case 'email-already-in-use':
        return 'An account already exists with this email.';
      default:
        return 'Unable to sign in. Please try again later.';
    }
  }

  Future<void> _resetPassword() async {
    final String email = _resetEmailController.text.trim();
    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter your email address')),
      );
      return;
    }

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Password reset email sent!')),
      );
      Navigator.of(context).pop();
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.message}')),
      );
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
    return Consumer(
      builder: (context, ref, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                        height: 80,
                        image: AssetImage('images/hsmowerslogo.png')),
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
                            ref: ref,
                          );
                          if (message != null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(message),
                                backgroundColor:
                                    message.contains('Successfully Logged In')
                                        ? Colors.green
                                        : Colors.red,
                                duration: const Duration(seconds: 3),
                                behavior: SnackBarBehavior.floating,
                                margin: const EdgeInsets.only(
                                    top: 10, left: 10, right: 10),
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
                                ? SizedBox(
                                    width: 22,
                                    height: 22,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
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
                    TextButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('Reset Password'),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                buildInputField(
                                  controller: _resetEmailController,
                                  hintText: 'Enter your email',
                                  icon: Icons.email,
                                ),
                              ],
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: _resetPassword,
                                child: Text('Send Reset Link'),
                              ),
                            ],
                          ),
                        );
                      },
                      child: Text(
                        'Forgot Password?',
                        style: AppTextStyles.h5.copyWith(
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
