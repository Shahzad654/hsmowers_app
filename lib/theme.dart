import 'package:flutter/material.dart';


class AppColors {
  static const Color primary = Color(0xff1dbf73);
  static const Color primaryLight = Color(0xff84dfb5);
  static const Color primaryDark = Color(0xff1ca251);
  static const Color secondary = Color(0xfff9ad3e); 
  static const Color secondaryLight = Color(0xfffbc76d);
  static const Color secondaryDark = Color(0xffd68a2d);
  static const Color accent = Color(0xffe94c4f);
  static const Color accentLight = Color(0xfff19092);
  static const Color accentDark = Color(0xffe31f22);
  static const Color textColor = Color(0xff002140);
  static const Color textColorLight = Color(0xff72767E);
  static const Color borderColor = Color(0xffc6c6c6);
}


class AppTextSizes {
  
  static const double h1 = 32.0; // Large heading
  static const double h2 = 28.0; // Second-level heading
  static const double h3 = 24.0; // Third-level heading
  static const double h4 = 20.0; // Fourth-level heading
  static const double h5 = 18.0; // Fifth-level heading
  static const double h6 = 16.0; // Sixth-level heading


  static const double para = 14.0; // Body text (default paragraph)
}

class AppTextStyles {
  static const TextStyle h1 = TextStyle(
    fontFamily: 'Poppins',
    fontSize: AppTextSizes.h1,
    fontWeight:
        FontWeight.bold, 
    color: AppColors.textColor,
  );
  static const TextStyle h2 = TextStyle(
    fontFamily: 'Poppins',
    fontSize: AppTextSizes.h2,
    fontWeight: FontWeight.bold,
    color: AppColors.textColor,
  );
  static const TextStyle h3 = TextStyle(
    fontFamily: 'Poppins',
    fontSize: AppTextSizes.h3,
    color: AppColors.textColor,
  );
  static const TextStyle h4 = TextStyle(
    fontFamily: 'Poppins',
    fontSize: AppTextSizes.h4,
    color: AppColors.textColor,
  );
  static const TextStyle h5 = TextStyle(
    fontFamily: 'Poppins',
    fontSize: AppTextSizes.h5,
    color: AppColors.textColor,
  );
  static const TextStyle h6 = TextStyle(
    fontFamily: 'Poppins',
    fontSize: AppTextSizes.h6,
    color: AppColors.textColor,
  );
  static const TextStyle para = TextStyle(
    fontFamily: 'Poppins',
    fontSize: AppTextSizes.para,
    fontWeight: FontWeight.normal,
    color: AppColors.textColorLight,
  );
}
