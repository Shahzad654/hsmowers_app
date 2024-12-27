// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:hsmowers_app/theme.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
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
              Text('Login', style: AppTextStyles.h2,),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: EdgeInsets.only(left: 30, right: 30),
                child: TextFormField(
                  cursorColor: AppColors.textColorLight,
                  decoration: InputDecoration(
                      filled: true,
                      hintText: 'Email',
                      prefixIcon: Icon(Icons.email,
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
                  decoration: InputDecoration(
                      filled: true,
                      hintText: 'Password',
                      prefixIcon: Icon(Icons.visibility, color: AppColors.primary,),
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
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(24)

                  ),
                 
                  child: Center(child: Text('Login', style: AppTextStyles.h4.copyWith(color: Colors.white))),
                ),
              ),
              SizedBox(
                height: 20,
              ),

              Text('Forget Password?', style: AppTextStyles.h5.copyWith(decoration: TextDecoration.underline)),
               SizedBox(
                height: 20,
              ),
              Text('Login using',
                  style: AppTextStyles.h6),
                  Image(
                    height: 50,
                    image: AssetImage('images/google.jpg')
                    )
             
            ],
          ),
        ),
      ),
    );
  }
}
