import 'package:flutter/material.dart';
import 'app_colors.dart';

/// 앱에서 사용하는 텍스트 스타일을 정의하는 클래스
class AppTextStyles {
  // Private constructor to prevent instantiation
  AppTextStyles._();
  
  // Logo Text Style
  static const TextStyle logo = TextStyle(
    fontFamily: 'Gasoek One',
    fontSize: 40,
    fontWeight: FontWeight.normal,
    color: AppColors.primary,
    height: 1.0,
    letterSpacing: 0.8,
  );
  
  // Title Text Style
  static const TextStyle title = TextStyle(
    fontFamily: 'Pretendard',
    fontSize: 20,
    fontWeight: FontWeight.w600, // SemiBold
    color: AppColors.textPrimary,
    height: 1.0,
  );
  
  // Subtitle Text Style
  static const TextStyle subtitle = TextStyle(
    fontFamily: 'Pretendard',
    fontSize: 16,
    fontWeight: FontWeight.w500, // Medium
    color: AppColors.textSecondary,
    height: 1.0,
  );
  
  // Card Title Text Style
  static const TextStyle cardTitle = TextStyle(
    fontFamily: 'Pretendard',
    fontSize: 16,
    fontWeight: FontWeight.w600, // SemiBold
    color: AppColors.textPrimary,
    height: 1.0,
  );
  
  // Card Description Text Style
  static const TextStyle cardDescription = TextStyle(
    fontFamily: 'Pretendard',
    fontSize: 14,
    fontWeight: FontWeight.w500, // Medium
    color: AppColors.textTertiary,
    height: 1.0,
  );
  
  // Card Description Secondary Text Style
  static const TextStyle cardDescriptionSecondary = TextStyle(
    fontFamily: 'Pretendard',
    fontSize: 14,
    fontWeight: FontWeight.w500, // Medium
    color: AppColors.textQuaternary,
    height: 1.0,
  );
}
