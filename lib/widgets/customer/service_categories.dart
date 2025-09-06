import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_sizes.dart';
import '../../constants/app_text_styles.dart';

/// 서비스 카테고리 위젯
class ServiceCategories extends StatefulWidget {
  const ServiceCategories({super.key});

  @override
  State<ServiceCategories> createState() => _ServiceCategoriesState();
}

class _ServiceCategoriesState extends State<ServiceCategories> {
  String _selectedCategory = '전체보기';

  // 서비스 카테고리 데이터
  final List<CategoryData> _categories = [
    CategoryData(name: '전체보기', isWide: true),
    CategoryData(name: '누수', isWide: true),
    CategoryData(name: '에어컨', isWide: true),
    CategoryData(name: '보일러', isWide: true),
    CategoryData(name: '전기', isWide: false),
    CategoryData(name: '가전 설치', isWide: false),
    CategoryData(name: '기타 설비', isWide: false),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppSizes.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 서브 타이틀
          Text(
            '서비스 카테고리',
            style: AppTextStyles.cardTitle.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: AppSizes.md),

          // 카테고리 그리드
          _buildCategoryGrid(),
        ],
      ),
    );
  }

  /// 카테고리 그리드 위젯
  Widget _buildCategoryGrid() {
    return Column(
      children: [
        // 첫 번째 행 (전체보기, 누수)
        Row(
          children: [
            Expanded(child: _buildCategoryChip(_categories[0])),
            const SizedBox(width: AppSizes.sm),
            Expanded(child: _buildCategoryChip(_categories[1])),
          ],
        ),

        const SizedBox(height: AppSizes.sm),

        // 두 번째 행 (에어컨, 보일러)
        Row(
          children: [
            Expanded(child: _buildCategoryChip(_categories[2])),
            const SizedBox(width: AppSizes.sm),
            Expanded(child: _buildCategoryChip(_categories[3])),
          ],
        ),

        const SizedBox(height: AppSizes.sm),

        // 세 번째 행 (전기, 가전 설치, 기타 설비)
        Row(
          children: [
            Expanded(child: _buildCategoryChip(_categories[4])),
            const SizedBox(width: AppSizes.sm),
            Expanded(child: _buildCategoryChip(_categories[5])),
            const SizedBox(width: AppSizes.sm),
            Expanded(child: _buildCategoryChip(_categories[6])),
          ],
        ),
      ],
    );
  }

  /// 카테고리 칩 위젯
  Widget _buildCategoryChip(CategoryData category) {
    final isSelected = _selectedCategory == category.name;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedCategory = category.name;
        });
      },
      child: Container(
        height: category.isWide ? 62 : 74,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: Colors.black.withValues(alpha: 0.1),
            width: 1,
          ),
        ),
        child: Center(
          child: Text(
            category.name,
            style: AppTextStyles.cardDescription.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: isSelected ? AppColors.primary : AppColors.textPrimary,
            ),
          ),
        ),
      ),
    );
  }
}

/// 카테고리 데이터 모델
class CategoryData {
  final String name;
  final bool isWide; // 넓은 칩인지 여부

  CategoryData({required this.name, required this.isWide});
}
