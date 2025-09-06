import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_sizes.dart';
import '../../constants/app_text_styles.dart';
import '../../screens/ai_request_screen.dart';

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
    CategoryData(
      name: '전체보기',
      isWide: true,
      icon: Icons.apps,
      color: const Color(0xFF2451BA),
    ),
    CategoryData(
      name: '누수',
      isWide: true,
      icon: Icons.water_drop,
      color: const Color(0xFF00BCD4),
    ),
    CategoryData(
      name: '에어컨',
      isWide: true,
      icon: Icons.ac_unit,
      color: const Color(0xFF2196F3),
    ),
    CategoryData(
      name: '보일러',
      isWide: true,
      icon: Icons.local_fire_department,
      color: const Color(0xFFFF5722),
    ),
    CategoryData(
      name: '전기',
      isWide: false,
      icon: Icons.electrical_services,
      color: const Color(0xFFFFC107),
    ),
    CategoryData(
      name: '가전 설치',
      isWide: false,
      icon: Icons.home_repair_service,
      color: const Color(0xFF9C27B0),
    ),
    CategoryData(
      name: '기타 설비',
      isWide: false,
      icon: Icons.build,
      color: const Color(0xFF607D8B),
    ),
    CategoryData(
      name: 'AI 자동요청',
      isWide: false,
      icon: Icons.smart_toy,
      color: const Color(0xFF4CAF50),
    ),
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

  /// 카테고리 그리드 위젯 (개선된 디자인)
  Widget _buildCategoryGrid() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.15),
            offset: const Offset(0, 6),
            blurRadius: 20,
          ),
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.05),
            offset: const Offset(0, 2),
            blurRadius: 8,
          ),
        ],
      ),
      child: Column(
        children: [
          // AI 매칭 섹션
          _buildAIMatchingSection(),

          const SizedBox(height: 24),

          // 카테고리 그리드
          _buildCategoriesGrid(),
        ],
      ),
    );
  }

  /// AI 매칭 섹션
  Widget _buildAIMatchingSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF4CAF50).withValues(alpha: 0.1),
            const Color(0xFF4CAF50).withValues(alpha: 0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF4CAF50).withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: const Color(0xFF4CAF50),
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Icon(Icons.psychology, size: 24, color: Colors.white),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'AI 스마트 매칭',
                  style: AppTextStyles.cardTitle.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF4CAF50),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'AI가 최적의 수리기사를 자동으로 찾아드려요',
                  style: AppTextStyles.cardDescription.copyWith(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const AIRequestScreen(),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFF4CAF50),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '시작하기',
                style: AppTextStyles.cardDescription.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 카테고리 그리드
  Widget _buildCategoriesGrid() {
    return Column(
      children: [
        // 첫 번째 행 (4개)
        Row(
          children: [
            Expanded(child: _buildCategoryChip(_categories[0])),
            const SizedBox(width: 12),
            Expanded(child: _buildCategoryChip(_categories[1])),
            const SizedBox(width: 12),
            Expanded(child: _buildCategoryChip(_categories[2])),
            const SizedBox(width: 12),
            Expanded(child: _buildCategoryChip(_categories[3])),
          ],
        ),

        const SizedBox(height: 16),

        // 두 번째 행 (4개)
        Row(
          children: [
            Expanded(child: _buildCategoryChip(_categories[4])),
            const SizedBox(width: 12),
            Expanded(child: _buildCategoryChip(_categories[5])),
            const SizedBox(width: 12),
            Expanded(child: _buildCategoryChip(_categories[6])),
            const SizedBox(width: 12),
            Expanded(
              child: _categories.length > 7
                  ? _buildCategoryChip(_categories[7])
                  : const SizedBox(),
            ),
          ],
        ),
      ],
    );
  }

  /// 카테고리 칩 위젯 (이전 스타일)
  Widget _buildCategoryChip(CategoryData category) {
    final isSelected = _selectedCategory == category.name;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedCategory = category.name;
        });
      },
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          color: isSelected
              ? category.color.withValues(alpha: 0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 아이콘
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: category.color,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(category.icon, size: 24, color: Colors.white),
              ),
            ),
            const SizedBox(height: 8),
            // 텍스트
            Text(
              category.name,
              style: AppTextStyles.cardDescription.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

/// 카테고리 데이터 모델
class CategoryData {
  final String name;
  final bool isWide; // 넓은 칩인지 여부
  final IconData icon;
  final Color color;

  CategoryData({
    required this.name,
    required this.isWide,
    required this.icon,
    required this.color,
  });
}
