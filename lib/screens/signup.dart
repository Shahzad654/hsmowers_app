// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hsmowers_app/provider/user_provider.dart';
import 'package:hsmowers_app/theme.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  int currentStep = 0;

  final List<Widget> steps = [
    Step1(),
    Step2(),
    Step3(),
    Step4(),
  ];

  void nextStep() {
    if (currentStep < steps.length - 1) {
      setState(() {
        currentStep++;
      });
    }
  }

  void previousStep() {
    if (currentStep > 0) {
      setState(() {
        currentStep--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, WidgetRef ref, Widget? child) {
      final users = ref.watch(userProvider);
      final userNotifier = ref.watch(userProvider.notifier);
      final formStatus = ref.watch(formStepStatusProvider);
      return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.primary,
            title: Center(
              child: Text(
                'Profile Setup',
                style: AppTextStyles.h4.copyWith(color: Colors.white),
              ),
            ),
          ),
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Create your business profile',
                    style: AppTextStyles.h4.copyWith(color: Colors.black),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  InkWell(child: steps[currentStep]),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: currentStep > 0 ? previousStep : null,
                          icon: Icon(Icons.arrow_back, color: Colors.white),
                          tooltip: 'Back',
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(
                                currentStep > 0
                                    ? AppColors.primaryDark
                                    : Colors.grey),
                          ),
                        ),
                        SizedBox(width: 20),
                        IconButton(
                          onPressed:
                              currentStep < steps.length - 1 ? nextStep : null,
                          icon: Icon(Icons.arrow_forward, color: Colors.white),
                          tooltip: 'Next',
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(
                                currentStep < steps.length - 1
                                    ? AppColors.primaryDark
                                    : Colors.grey),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  SizedBox(
                    height: 5,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 30, right: 30),
                      child: LinearProgressIndicator(
                        value: (currentStep + 1) / steps.length,
                        backgroundColor: Colors.grey.shade300,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}

class Step1 extends StatelessWidget {
  final fullNameController = TextEditingController();
  final userNameController = TextEditingController();
  final phoneNumController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: TextFormField(
            controller: fullNameController,
            decoration: InputDecoration(
              hintText: 'Enter Full Name',
              filled: true,
              fillColor: Colors.white,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24),
                borderSide: BorderSide(color: AppColors.textColorLight),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24),
                borderSide: BorderSide(color: AppColors.primary),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 25,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: TextFormField(
            controller: userNameController,
            decoration: InputDecoration(
              hintText: 'Enter User Name',
              filled: true,
              fillColor: Colors.white,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24),
                borderSide: BorderSide(color: AppColors.textColorLight),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24),
                borderSide: BorderSide(color: AppColors.primary),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 25,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: TextFormField(
            controller: phoneNumController,
            decoration: InputDecoration(
              hintText: 'Enter Phone Number',
              filled: true,
              fillColor: Colors.white,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24),
                borderSide: BorderSide(color: AppColors.textColorLight),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24),
                borderSide: BorderSide(color: AppColors.primary),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class Step2 extends StatefulWidget {
  const Step2({super.key});

  @override
  State<Step2> createState() => _Step2State();
}

class _Step2State extends State<Step2> {
  List<String> services = [
    'Mowers',
    'Weeding',
    'Snow Removal',
    'Baby Sitting',
    'Edging',
    'Leaf Removal',
    'Dog Walking',
    'Window Cleaning',
  ];

  late List<bool> isSelected;

  @override
  void initState() {
    super.initState();
    isSelected = List.generate(services.length, (index) => false);
  }

  @override
  Widget build(BuildContext context) {
    double sliderValue = 0;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Services',
          style: AppTextStyles.h5.copyWith(color: Colors.black),
        ),
        SizedBox(
          height: 15,
        ),
        Wrap(
          spacing: 10.0,
          runSpacing: 10.0,
          children: services.map((service) {
            int index = services.indexOf(service);
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ToggleButtons(
                isSelected: [isSelected[index]],
                onPressed: (_) {
                  setState(() {
                    isSelected[index] = !isSelected[index];
                  });
                },
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(service),
                  ),
                ],
                borderRadius: BorderRadius.circular(8),
                color: Colors.black,
                borderColor: AppColors.primary,
                selectedColor: Colors.white,
                selectedBorderColor: AppColors.primary,
                fillColor: AppColors.primary,
                borderWidth: 2,
              ),
            );
          }).toList(),
        ),
        SizedBox(
          height: 30,
        ),
        Text(
          'Services Distance',
          style: AppTextStyles.h5.copyWith(color: Colors.black),
        ),
        SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 10,
        ),
        Slider(
            thumbColor: AppColors.primary,
            min: 0,
            max: 5,
            value: sliderValue,
            onChanged: (value) {
              setState(() {
                sliderValue = value;
              });
            })
      ],
    );
  }
}

class Step3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          child: CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(
                'data:image/png;base64,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'),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        ElevatedButton(
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(AppColors.primaryDark),
            ),
            onPressed: () {},
            child: Text(
              'Upload Image',
              style: AppTextStyles.h4.copyWith(color: Colors.white),
            )),
        SizedBox(
          height: 25,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: TextFormField(
            decoration: InputDecoration(
              hintText: 'Enter School Name',
              filled: true,
              fillColor: Colors.white,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24),
                borderSide: BorderSide(color: AppColors.textColorLight),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24),
                borderSide: BorderSide(color: AppColors.primary),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 25,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: DropdownButtonFormField(
            decoration: InputDecoration(
              hintText: 'Select Grade',
              filled: true,
              fillColor: Colors.white,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24),
                borderSide: BorderSide(color: AppColors.textColorLight),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24),
                borderSide: BorderSide(color: AppColors.primary),
              ),
            ),
            items: [
              DropdownMenuItem(value: 'FreshMan', child: Text('FreshMan')),
              DropdownMenuItem(value: 'Senior', child: Text('Senior')),
              DropdownMenuItem(value: 'Sophomore', child: Text('Sophomore')),
              DropdownMenuItem(value: 'Junior', child: Text('Junior')),
            ],
            onChanged: (value) {},
          ),
        ),
      ],
    );
  }
}

class Step4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final descriptionController = TextEditingController();
    final zipCodeController = TextEditingController();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: TextFormField(
            maxLines: 5,
            decoration: InputDecoration(
              hintText: 'Enter Description',
              filled: true,
              fillColor: Colors.white,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24),
                borderSide: BorderSide(color: AppColors.textColorLight),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24),
                borderSide: BorderSide(color: AppColors.primary),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 25,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: TextFormField(
            decoration: InputDecoration(
              hintText: 'Enter zip code or address',
              filled: true,
              fillColor: Colors.white,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24),
                borderSide: BorderSide(color: AppColors.textColorLight),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24),
                borderSide: BorderSide(color: AppColors.primary),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
