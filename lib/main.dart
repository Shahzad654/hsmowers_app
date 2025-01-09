// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:hsmowers_app/screens/login.dart';
import 'package:hsmowers_app/screens/home.dart';
import 'package:hsmowers_app/models/auth_user_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp();
    await FirebaseAuth.instance.setPersistence(Persistence.LOCAL);
    await FirebaseAppCheck.instance.activate();
    print("Firebase initialized successfully");

    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      print("User is logged in: ${user.uid}");
    } else {
      print("No user is logged in");
    }
  } catch (e) {
    print("Error initializing Firebase: $e");
  }
  // final authUserNotifier = AuthUserNotifier();
  // await authUserNotifier.loadUserData();
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authUserNotifier = ref.read(authUserProvider.notifier);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      authUserNotifier.loadUserData();
    });
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'hsmowers app',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomeScreen(),
    );
  }
}
