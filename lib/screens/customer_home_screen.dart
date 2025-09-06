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
                    const SizedBox(height: AppSizes.sm),

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

  /// 상단바 위젯
  Widget _buildTopBar() {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.08),
            offset: const Offset(0, 2),
            blurRadius: 4,
          ),
        ],
      ),
      child: Row(
        children: [
          const SizedBox(width: AppSizes.md),

          // 로고
          Text(
            '수리모아',
            style: AppTextStyles.logo.copyWith(
              fontSize: 22,
              color: AppColors.primary,
            ),
          ),

          const Spacer(),
        ],
      ),
    );
  }
}
