import 'package:flutter/material.dart';
import '../../constants/app_sizes.dart';

/// 배너 슬라이더 위젯
class BannerSlider extends StatefulWidget {
  const BannerSlider({super.key});

  @override
  State<BannerSlider> createState() => _BannerSliderState();
}

class _BannerSliderState extends State<BannerSlider> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // 배너 데이터 (개선된 디자인)
  final List<BannerData> _banners = [
    BannerData(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFF2451BA), Color(0xFF4A6CF7)],
      ),
      title: '수리 서비스',
      subtitle: '전문가와 함께하는\n안전한 수리',
      icon: Icons.build_circle,
    ),
    BannerData(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFF00C851), Color(0xFF00E676)],
      ),
      title: '빠른 견적',
      subtitle: '24시간 내\n견적서 도착',
      icon: Icons.speed,
    ),
    BannerData(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFFFF6B35), Color(0xFFFF8A65)],
      ),
      title: '전국 서비스',
      subtitle: '어디든 찾아가는\n수리 서비스',
      icon: Icons.location_on,
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      margin: const EdgeInsets.symmetric(horizontal: AppSizes.md),
      child: Stack(
        children: [
          // 배너 페이지뷰
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemCount: _banners.length,
            itemBuilder: (context, index) {
              return _buildBannerItem(_banners[index]);
            },
          ),

          // 페이지 인디케이터
          Positioned(
            bottom: 16,
            left: 0,
            right: 0,
            child: _buildPageIndicator(),
          ),
        ],
      ),
    );
  }

  /// 배너 아이템 위젯
  Widget _buildBannerItem(BannerData banner) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        gradient: banner.gradient,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color:
                (banner.gradient?.colors.first ?? banner.color ?? Colors.blue)
                    .withValues(alpha: 0.3),
            offset: const Offset(0, 4),
            blurRadius: 12,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    banner.title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    banner.subtitle,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.white70,
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              banner.icon,
              size: 48,
              color: Colors.white.withValues(alpha: 0.9),
            ),
          ],
        ),
      ),
    );
  }

  /// 페이지 인디케이터 위젯
  Widget _buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        _banners.length,
        (index) => Container(
          margin: const EdgeInsets.symmetric(horizontal: 2),
          width: _currentPage == index ? 20 : 4,
          height: 4,
          decoration: BoxDecoration(
            color: _currentPage == index
                ? Colors.white
                : Colors.white.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ),
    );
  }
}

/// 배너 데이터 모델
class BannerData {
  final LinearGradient? gradient;
  final Color? color;
  final String title;
  final String subtitle;
  final IconData icon;

  BannerData({
    this.gradient,
    this.color,
    required this.title,
    required this.subtitle,
    required this.icon,
  });
}
