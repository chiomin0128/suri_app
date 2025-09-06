import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_sizes.dart';
import '../../constants/app_text_styles.dart';

/// 하단 네비게이션 바 위젯
class BottomNavigation extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavigation({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            offset: const Offset(0, -2),
            blurRadius: 4,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildNavItem(
              icon: Icons.home,
              label: '홈',
              index: 0,
              isSelected: currentIndex == 0,
            ),
            _buildNavItem(
              icon: Icons.chat,
              label: '채팅',
              index: 1,
              isSelected: currentIndex == 1,
            ),
            _buildNavItem(
              icon: Icons.list_alt,
              label: '요청 목록',
              index: 2,
              isSelected: currentIndex == 2,
            ),
            _buildNavItem(
              icon: Icons.person,
              label: '프로필',
              index: 3,
              isSelected: currentIndex == 3,
            ),
          ],
        ),
      ),
    );
  }

  /// 네비게이션 아이템 위젯
  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required int index,
    required bool isSelected,
  }) {
    return GestureDetector(
      onTap: () => onTap(index),
      child: Container(
        padding: const EdgeInsets.all(2),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 22,
              color: isSelected ? AppColors.primary : AppColors.textSecondary,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: AppTextStyles.cardDescription.copyWith(
                fontSize: 11,
                color: isSelected ? AppColors.primary : AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
