import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_sizes.dart';
import '../../constants/app_text_styles.dart';

/// 로고와 헤더 텍스트를 표시하는 위젯
class LogoHeader extends StatelessWidget {
  const LogoHeader({
    super.key,
    this.logoText = '수리모아',
    this.title = '편리한 설비 서비스의 시작',
    this.subtitle = '수리모아에서 시작하세요!',
  });

  /// 로고 텍스트
  final String logoText;
  
  /// 제목 텍스트
  final String title;
  
  /// 부제목 텍스트
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 로고
        Text(
          logoText,
          style: AppTextStyles.logo,
          textAlign: TextAlign.center,
          
        ),
        
        const SizedBox(height: AppSizes.lg),
        
        // 제목과 부제목
        Column(
          children: [
            Text(
              title,
              style: AppTextStyles.title,
              textAlign: TextAlign.center,
            ),
            
            const SizedBox(height: AppSizes.sm),
            
            Text(
              subtitle,
              style: AppTextStyles.subtitle,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ],
    );
  }
}
