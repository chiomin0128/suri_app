import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_sizes.dart';

/// 아바타 이미지가 없을 때 사용할 플레이스홀더 위젯
class AvatarPlaceholder extends StatelessWidget {
  const AvatarPlaceholder({super.key, this.size, this.color, this.icon});

  /// 아바타 크기
  final double? size;

  /// 배경 색상
  final Color? color;

  /// 표시할 아이콘
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size ?? AppSizes.avatarSize,
      height: size ?? AppSizes.avatarSize,
      decoration: BoxDecoration(
        color: color ?? Colors.white,
        shape: BoxShape.circle,
      ),
      child: icon != null
          ? Icon(
              icon,
              size: (size ?? AppSizes.avatarSize) * 0.5,
              color: AppColors.primary,
            )
          : null,
    );
  }
}
