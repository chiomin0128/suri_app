import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_sizes.dart';
import '../../constants/app_text_styles.dart';

/// 추천 서비스 위젯
class RecommendedServices extends StatelessWidget {
  const RecommendedServices({super.key});

  // 추천 서비스 데이터
  final List<ServiceData> _services = const [
    ServiceData(title: '설명글', category: '분야', tag: '추천', isRecommended: true),
    ServiceData(title: '설명글', category: '분야', tag: '인기', isRecommended: false),
    ServiceData(title: '설명글', category: '분야', tag: '인기', isRecommended: false),
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
      width: 160,
      margin: const EdgeInsets.only(right: AppSizes.sm),
      decoration: BoxDecoration(
        color: Colors.grey.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.withValues(alpha: 0.2), width: 1),
      ),
      child: Stack(
        children: [
          // 태그
          Positioned(
            top: 8,
            left: 8,
            child: _buildTag(service.tag, service.isRecommended),
          ),

          // 서비스 정보
          Positioned(
            bottom: 12,
            left: 12,
            right: 12,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  service.category,
                  style: AppTextStyles.cardDescription.copyWith(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  service.title,
                  style: AppTextStyles.cardDescription.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textPrimary,
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

  const ServiceData({
    required this.title,
    required this.category,
    required this.tag,
    required this.isRecommended,
  });
}
