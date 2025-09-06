import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_sizes.dart';
import '../../constants/app_text_styles.dart';

/// 추천 서비스 위젯
class RecommendedServices extends StatelessWidget {
  const RecommendedServices({super.key});

  // 추천 서비스 데이터
  final List<ServiceData> _services = const [
    ServiceData(
      title: '누수 전문 수리',
      category: '누수',
      tag: '추천',
      isRecommended: true,
      price: '5만원부터',
      rating: 4.8,
      technicianName: '김수리',
      technicianIcon: Icons.person,
    ),
    ServiceData(
      title: '에어컨 청소',
      category: '에어컨',
      tag: '인기',
      isRecommended: false,
      price: '3만원부터',
      rating: 4.9,
      technicianName: '박에어',
      technicianIcon: Icons.person,
    ),
    ServiceData(
      title: '보일러 점검',
      category: '보일러',
      tag: '인기',
      isRecommended: false,
      price: '2만원부터',
      rating: 4.7,
      technicianName: '이보일',
      technicianIcon: Icons.person,
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
            '추천 서비스',
            style: AppTextStyles.cardTitle.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: AppSizes.md),

          // 서비스 카드 리스트
          SizedBox(
            height: 216,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _services.length,
              itemBuilder: (context, index) {
                return _buildServiceCard(_services[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  /// 서비스 카드 위젯
  Widget _buildServiceCard(ServiceData service) {
    return Container(
      width: 180,
      margin: const EdgeInsets.only(right: AppSizes.md),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.withValues(alpha: 0.1), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            offset: const Offset(0, 2),
            blurRadius: 8,
          ),
        ],
      ),
      child: Stack(
        children: [
          // 태그
          Positioned(
            top: 12,
            left: 12,
            child: _buildTag(service.tag, service.isRecommended),
          ),

          // 서비스 정보
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Text(
                  service.category,
                  style: AppTextStyles.cardDescription.copyWith(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  service.title,
                  style: AppTextStyles.cardDescription.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.star, size: 14, color: Colors.amber[600]),
                    const SizedBox(width: 4),
                    Text(
                      service.rating.toString(),
                      style: AppTextStyles.cardDescription.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                // 수리기사 정보
                Row(
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Icon(
                          service.technicianIcon,
                          size: 14,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        service.technicianName,
                        style: AppTextStyles.cardDescription.copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textSecondary,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Text(
                  service.price,
                  style: AppTextStyles.cardDescription.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 태그 위젯
  Widget _buildTag(String tag, bool isRecommended) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey.withValues(alpha: 0.2),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(8),
          bottomRight: Radius.circular(8),
        ),
      ),
      child: Text(
        tag,
        style: AppTextStyles.cardDescription.copyWith(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: AppColors.textSecondary,
        ),
      ),
    );
  }
}

/// 서비스 데이터 모델
class ServiceData {
  final String title;
  final String category;
  final String tag;
  final bool isRecommended;
  final String price;
  final double rating;
  final String technicianName;
  final IconData technicianIcon;

  const ServiceData({
    required this.title,
    required this.category,
    required this.tag,
    required this.isRecommended,
    required this.price,
    required this.rating,
    required this.technicianName,
    required this.technicianIcon,
  });
}
