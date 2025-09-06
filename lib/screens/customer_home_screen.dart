import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_sizes.dart';
import '../constants/app_text_styles.dart';
import '../widgets/customer/banner_slider.dart';
import '../widgets/customer/service_categories.dart';
import '../widgets/customer/recommended_services.dart';
import '../widgets/customer/quote_notification.dart';
import '../widgets/customer/bottom_navigation.dart';

/// 고객 홈페이지 화면
class CustomerHomeScreen extends StatefulWidget {
  const CustomerHomeScreen({super.key});

  @override
  State<CustomerHomeScreen> createState() => _CustomerHomeScreenState();
}

class _CustomerHomeScreenState extends State<CustomerHomeScreen> {
  int _currentIndex = 0; // 하단 네비게이션 현재 인덱스

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // 상단바 (로고, 상태바)
            _buildTopBar(),

            // 메인 콘텐츠
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    const SizedBox(height: AppSizes.md),

                    // 검색바
                    _buildSearchBar(),

                    const SizedBox(height: AppSizes.lg),

                    // 배너 슬라이더
                    const BannerSlider(),

                    const SizedBox(height: AppSizes.xxl),

                    // 서비스 카테고리
                    const ServiceCategories(),

                    const SizedBox(height: AppSizes.xxl),

                    // 추천 서비스
                    const RecommendedServices(),

                    const SizedBox(height: AppSizes.xxl),

                    // 견적서 도착 알림
                    const QuoteNotification(),

                    const SizedBox(height: AppSizes.xxl),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigation(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }

  /// 상단바 위젯 (숨고 스타일)
  Widget _buildTopBar() {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            offset: const Offset(0, 2),
            blurRadius: 8,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            // 로고
            Text(
              '수리모아',
              style: AppTextStyles.logo.copyWith(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),

            const Spacer(),

            // 알림 아이콘
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.grey.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Stack(
                children: [
                  Center(
                    child: Icon(
                      Icons.notifications_outlined,
                      size: 20,
                      color: Colors.grey[600],
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 12),

            // 기사전환 버튼
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.grey.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                '기사전환',
                style: AppTextStyles.cardDescription.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[700],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 검색바 위젯 (숨고 스타일)
  Widget _buildSearchBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppSizes.md),
      height: 48,
      decoration: BoxDecoration(
        color: Colors.grey.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          const SizedBox(width: 16),
          Icon(Icons.search, size: 20, color: Colors.grey[600]),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              '어떤 서비스가 필요하세요?',
              style: AppTextStyles.cardDescription.copyWith(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
