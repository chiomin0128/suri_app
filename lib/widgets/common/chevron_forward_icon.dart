import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_sizes.dart';

/// 화살표 아이콘을 표시하는 재사용 가능한 위젯
class ChevronForwardIcon extends StatelessWidget {
  const ChevronForwardIcon({
    super.key,
    this.color,
    this.size,
  });

  /// 아이콘 색상
  final Color? color;
  
  /// 아이콘 크기
  final double? size;

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.arrow_forward_ios,
      color: color ?? AppColors.iconPrimary,
      size: size ?? AppSizes.iconSize,
    );
  }
}
