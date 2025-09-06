import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
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

  // 배너 데이터 (임시)
  final List<BannerData> _banners = [
    BannerData(color: const Color(0xFFD9D9D9), title: '첫 번째 배너'),
    BannerData(color: const Color(0xFFC0C0C0), title: '두 번째 배너'),
    BannerData(color: const Color(0xFFA0A0A0), title: '세 번째 배너'),
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
        color: banner.color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          banner.title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black54,
          ),
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
  final Color color;
  final String title;

  BannerData({required this.color, required this.title});
}
