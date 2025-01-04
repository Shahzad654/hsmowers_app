// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:hsmowers_app/theme.dart';

class ContactUsers extends StatefulWidget {
  const ContactUsers({super.key});

  @override
  State<ContactUsers> createState() => _ContactUsersState();
}

class _ContactUsersState extends State<ContactUsers> {
  int _selectedConsent = 0;
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
            Text(
              'Request Service',
              style: AppTextStyles.h4.copyWith(color: Colors.black),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: CustomTextField(
                label: 'Message',
                maxLines: 5,
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Please enter your message' : null,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Column(
              children: [
                Text(
                  'How should I reply?',
                  style: AppTextStyles.h5,
                ),
                Row(
                  children: [
                    Radio(
                      value: 1,
                      groupValue: _selectedConsent,
                      onChanged: (int? value) {
                        setState(() {
                          _selectedConsent = value!;
                        });
                      },
                    ),
                    Text(
                      'Phone Number',
                      style: AppTextStyles.para,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Radio(
                      value: 2,
                      groupValue: _selectedConsent,
                      onChanged: (int? value) {
                        setState(() {
                          _selectedConsent = value!;
                        });
                      },
                    ),
                    Text(
                      'SMS',
                      style: AppTextStyles.para,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Radio(
                      value: 3,
                      groupValue: _selectedConsent,
                      onChanged: (int? value) {
                        setState(() {
                          _selectedConsent = value!;
                        });
                      },
                    ),
                    Text(
                      'Email',
                      style: AppTextStyles.para,
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: CustomTextField(
                label: 'Email',
                maxLines: 1,
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Please enter your email' : null,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      WidgetStatePropertyAll(AppColors.primaryDark),
                ),
                onPressed: () {},
                child: Text(
                  'Submit',
                  style: TextStyle(color: Colors.white),
                ))
          ],
        ),
      ),
    ));
  }
}

class CustomTextField extends StatelessWidget {
  // final TextEditingController controller;
  final String label;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  // final List<TextInputFormatter>? inputFormatters;
  final int? maxLines;

  const CustomTextField({
    // required this.controller,
    required this.label,
    this.validator,
    this.keyboardType,
    // this.inputFormatters,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // controller: controller,
      cursorColor: AppColors.textColorLight,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppColors.primary)),
        filled: true,
        fillColor: Colors.white,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.primary, width: 2),
        ),
      ),
      validator: validator,
      keyboardType: keyboardType,
      // inputFormatters: inputFormatters,
      maxLines: maxLines,
    );
  }
}
