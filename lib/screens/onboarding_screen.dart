import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_sizes.dart';
import '../models/user_type.dart';
import '../widgets/onboarding/logo_header.dart';
import '../widgets/onboarding/user_type_card.dart';

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
    
    // TODO: 선택된 사용자 타입에 따른 다음 화면으로 이동
    _showUserTypeSelection(userType);
  }

  /// 사용자 타입 선택 결과 표시
  void _showUserTypeSelection(UserType userType) {
    final message = userType == UserType.customer
        ? '고객으로 시작하시겠습니까?'
        : '수리기사로 시작하시겠습니까?';
        
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('사용자 타입 선택'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('취소'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              // TODO: 실제 앱에서는 여기서 다음 화면으로 이동
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${userType.title} 화면으로 이동합니다.'),
                ),
              );
            },
            child: const Text('확인'),
          ),
        ],
      ),
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
              // 상단 여백
              const SizedBox(height: AppSizes.xxl),
              
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
