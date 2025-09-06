import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_sizes.dart';
import '../models/user_type.dart';
import '../widgets/onboarding/logo_header.dart';
import '../widgets/onboarding/user_type_card.dart';
import 'signup_screen.dart';
import 'customer_home_screen.dart';

/// 온보딩 화면
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  UserType? _selectedUserType;

  /// 사용자 타입 선택 처리
  void _onUserTypeSelected(UserType userType) {
    setState(() {
      _selectedUserType = userType;
    });

    // 회원가입 화면으로 이동
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => SignupScreen(userType: userType)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.md),
          child: Column(
            children: [
              // 개발자용 홈 버튼들
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // 고객 홈페이지 버튼
                  Container(
                    margin: const EdgeInsets.only(right: AppSizes.sm),
                    decoration: BoxDecoration(
                      color: Colors.blue.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Colors.blue.withValues(alpha: 0.3),
                        width: 1,
                      ),
                    ),
                    child: IconButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const CustomerHomeScreen(),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.person,
                        color: Colors.blue,
                        size: 24,
                      ),
                      tooltip: '고객 홈페이지',
                    ),
                  ),

                  // 기사 홈페이지 버튼
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.orange.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Colors.orange.withValues(alpha: 0.3),
                        width: 1,
                      ),
                    ),
                    child: IconButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('기사 홈페이지 - 추후 기사 메인 화면으로 이동'),
                            duration: Duration(seconds: 2),
                            backgroundColor: Colors.orange,
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.build,
                        color: Colors.orange,
                        size: 24,
                      ),
                      tooltip: '기사 홈페이지',
                    ),
                  ),
                ],
              ),

              const SizedBox(height: AppSizes.md),

              // 로고 및 헤더
              const LogoHeader(),

              const Spacer(),

              // 사용자 타입 선택 카드들
              Column(
                children: [
                  // 고객 카드
                  UserTypeCard(
                    userType: UserType.customer,
                    onTap: () => _onUserTypeSelected(UserType.customer),
                    isSelected: _selectedUserType == UserType.customer,
                  ),

                  const SizedBox(height: AppSizes.lg),

                  // 수리기사 카드
                  UserTypeCard(
                    userType: UserType.technician,
                    onTap: () => _onUserTypeSelected(UserType.technician),
                    isSelected: _selectedUserType == UserType.technician,
                  ),
                ],
              ),

              // 하단 여백
              const SizedBox(height: AppSizes.xxl),
            ],
          ),
        ),
      ),
    );
  }
}
