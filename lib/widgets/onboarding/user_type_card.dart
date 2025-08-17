import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_sizes.dart';
import '../../constants/app_text_styles.dart';
import '../../models/user_type.dart';
import '../common/avatar_placeholder.dart';
import '../common/chevron_forward_icon.dart';

/// 사용자 타입을 선택할 수 있는 카드 위젯
class UserTypeCard extends StatelessWidget {
  const UserTypeCard({
    super.key,
    required this.userType,
    required this.onTap,
    this.isSelected = false,
  });

  /// 사용자 타입
  final UserType userType;
  
  /// 탭 콜백
  final VoidCallback onTap;
  
  /// 선택된 상태 여부
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: AppSizes.cardHeight,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.cardHorizontalPadding,
          vertical: AppSizes.cardVerticalPadding,
        ),
        decoration: BoxDecoration(
          color: userType == UserType.customer
              ? AppColors.cardBackgroundLight
              : AppColors.cardBackgroundLight,
          borderRadius: BorderRadius.circular(AppSizes.cardBorderRadius),
          border: userType == UserType.customer
              ? Border.all(color: AppColors.primaryBorder, width: 2)
              : Border.all(color: AppColors.primaryBorder, width: 2),
        ),
        child: Row(
          children: [
            // 아바타 이미지
            AvatarPlaceholder(
              size: AppSizes.avatarSize,
            ),
            const SizedBox(width: AppSizes.md),
            
            // 텍스트 정보
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    userType.title,
                    style: AppTextStyles.cardTitle,
                  ),
                  const SizedBox(height: AppSizes.xs),
                  Text(
                    userType.description,
                    style: AppTextStyles.cardDescription,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
