import 'package:flutter/material.dart';

/// 앱에서 사용하는 색상 상수들을 정의하는 클래스
class AppColors {
  // Private constructor to prevent instantiation
  AppColors._();
  
  // Primary Colors
  static const Color primary = Color(0xFF2451BA);
  static const Color primaryLight = Color(0xFFF3F6FD);
  static const Color primaryBorder = Color(0xFFECF2FF);
  
  // Text Colors
  static const Color textPrimary = Color(0xFF000000);
  static const Color textSecondary = Color(0xFF9E9E9E);
  static const Color textTertiary = Color(0xFF707070);
  static const Color textQuaternary = Color(0xFF707070);
  
  // Background Colors
  static const Color background = Color(0xFFFFFFFF);
  static const Color cardBackground = Color(0xFFE9ECF3);
  static const Color cardBackgroundLight = Color(0xFFFFFFFF);
  static const Color cardBackgroundDark = Color(0xFFF3F6FD);
  
  // Icon Colors
  static const Color iconPrimary = Color(0xFF424242);
}
