// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:hsmowers_app/theme.dart';

class PricingScreen extends StatefulWidget {
  const PricingScreen({super.key});

  @override
  State<PricingScreen> createState() => _PricingScreenState();
}

class _PricingScreenState extends State<PricingScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(
          'Pricing',
          style: AppTextStyles.h4,
        ),
        backgroundColor: AppColors.primary,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Choose your plan',
            style: AppTextStyles.h3.copyWith(color: Colors.black),
          ),
          SizedBox(
            height: 40,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.publish,
                    size: 30,
                    color: AppColors.primary,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    'Publish Profile',
                    style: AppTextStyles.h5.copyWith(color: Colors.black),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.people,
                    size: 30,
                    color: AppColors.primary,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    'Gain Customers',
                    style: AppTextStyles.h5.copyWith(color: Colors.black),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.ads_click,
                    size: 30,
                    color: AppColors.primary,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    'No ads',
                    style: AppTextStyles.h5.copyWith(color: Colors.black),
                  )
                ],
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(24)),
              child: Column(
                children: [
                  Text(
                    'Subscribe Annually',
                    style: AppTextStyles.h5.copyWith(color: Colors.white),
                  ),
                  Text(
                    '\$12.00 per year',
                    style: AppTextStyles.para.copyWith(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.secondary,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                children: [
                  Text(
                    'Subscribe Monthly',
                    style: AppTextStyles.h5.copyWith(color: Colors.white),
                  ),
                  Text(
                    '\$4.00 per month',
                    style: AppTextStyles.para.copyWith(color: Colors.white),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      // bottomNavigationBar:
      // Material(
      //    elevation: 10.0,
      // color: Colors
      //     .transparent,
      // borderRadius: BorderRadius.only(
      //   topLeft: Radius.circular(50.0),
      //   topRight: Radius.circular(50.0),
      // ),
      //   child: BottomNavigationBar(items: [
      //   BottomNavigationBarItem(
      //     icon: Icon(
      //       Icons.home,
      //       color: AppColors.primary,
      //     ),
      //     label: 'Home',
      //     tooltip: 'Home',
      //   ),
      //   BottomNavigationBarItem(
      //     icon: InkWell(
      //       onTap: () {
      //         Navigator.push(
      //           context,
      //           MaterialPageRoute(builder: (context) => PricingScreen()),
      //         );
      //       },
      //       child: Icon(Icons.subscriptions_outlined),
      //     ),
      //     label: 'Pricing',
      //     tooltip: 'Pricing',
      //   ),
      //   BottomNavigationBarItem(
      //     icon: InkWell(
      //       onTap: () {
      //         Navigator.push(
      //           context,
      //           MaterialPageRoute(builder: (context) => Login()),
      //         );
      //       },
      //       child: Icon(Icons.login),
      //     ),
      //     label: 'Login',
      //     tooltip: 'Login',
      //   ),

      //         ]),
      // ),
    ));
  }
}
