import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_sizes.dart';
import '../constants/app_text_styles.dart';
import '../models/signup_data.dart';
import '../models/user_type.dart';
import '../widgets/signup/signup_form.dart';
import '../services/api_service.dart';
import 'customer_home_screen.dart';

/// 회원가입 화면
class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key, required this.userType});

  /// 사용자 타입
  final UserType userType;

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool _isLoading = false;

  /// 회원가입 처리
  Future<void> _handleSignup(SignupData signupData) async {
    setState(() {
      _isLoading = true;
    });

    try {
      // 서버의 실제 전문분야 ID 확인
      print('=== 서버 전문분야 ID 확인 ===');
      final serverSpecialties = await ApiService.getSpecialties();
      print('서버 전문분야 개수: ${serverSpecialties.length}');

      // 서버의 전문분야 ID 목록 출력
      final serverIds = serverSpecialties.map((s) => s['id'] as int).toList();
      print('서버 전문분야 ID: $serverIds');
      print('클라이언트 선택 ID: ${signupData.specialtyIds}');

      // 유효한 ID만 필터링
      final validSpecialtyIds = signupData.specialtyIds
          .where((id) => serverIds.contains(id))
          .toList();

      print('유효한 전문분야 ID: $validSpecialtyIds');

      if (signupData.userType == UserType.technician &&
          validSpecialtyIds.isEmpty) {
        throw Exception('선택한 전문분야가 서버에 존재하지 않습니다.');
      }

      // 실제 회원가입 API 호출
      final response = await ApiService.registerMember(
        email: signupData.email,
        password: signupData.password,
        username: signupData.username,
        fullName: signupData.fullName,
        phone: signupData.phone,
        region: signupData.region,
        grade: signupData.grade,
        specialtyIds: validSpecialtyIds,
      );

      if (mounted) {
        if (response.success) {
          // 성공 다이얼로그 표시
          _showSuccessDialog(response);
        } else {
          // 실패 스낵바 표시
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(response.message),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        // 에러 스낵바 표시
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('회원가입 중 오류가 발생했습니다: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  /// 성공 다이얼로그 표시
  void _showSuccessDialog(SignupResponse response) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.cardBorderRadius),
        ),
        contentPadding: const EdgeInsets.all(24),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 성공 아이콘
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: Colors.green.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check_circle,
                size: 32,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: AppSizes.lg),

            // 제목
            Text(
              '회원가입 완료',
              style: AppTextStyles.cardTitle.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSizes.sm),

            // 메시지
            Text(
              response.message,
              style: AppTextStyles.cardDescription.copyWith(
                fontSize: 16,
                color: AppColors.textSecondary,
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSizes.lg),

            // 회원 정보 표시
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  width: 1,
                ),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.person, size: 16, color: AppColors.primary),
                      const SizedBox(width: 8),
                      Text(
                        '사용자명: ${response.member.username}',
                        style: AppTextStyles.cardDescription.copyWith(
                          fontSize: 14,
                          color: AppColors.primary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.email, size: 16, color: AppColors.primary),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          '이메일: ${response.member.email}',
                          style: AppTextStyles.cardDescription.copyWith(
                            fontSize: 14,
                            color: AppColors.primary,
                            fontWeight: FontWeight.w500,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.star, size: 16, color: AppColors.primary),
                      const SizedBox(width: 8),
                      Text(
                        '등급: ${response.member.grade == 'consumer' ? '고객' : '수리기사'}',
                        style: AppTextStyles.cardDescription.copyWith(
                          fontSize: 14,
                          color: AppColors.primary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSizes.sm),

            // 이메일 인증 안내
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.orange.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Colors.orange.withValues(alpha: 0.3),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.email_outlined,
                    size: 16,
                    color: Colors.orange[700],
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      '이메일 인증을 진행해주세요',
                      style: AppTextStyles.cardDescription.copyWith(
                        fontSize: 13,
                        color: Colors.orange[700],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // 다이얼로그 닫기
                Navigator.of(context).pop(); // 회원가입 화면 닫기

                // 사용자 타입에 따라 적절한 화면으로 이동
                if (widget.userType == UserType.customer) {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const CustomerHomeScreen(),
                    ),
                  );
                } else {
                  // TODO: 수리기사 홈페이지로 이동
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('수리기사 홈페이지는 준비 중입니다'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.background,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    AppSizes.cardBorderRadius,
                  ),
                ),
                elevation: 0,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: Text(
                '확인',
                style: AppTextStyles.cardTitle.copyWith(
                  color: AppColors.background,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background, // 배경은 여기서만 칠하기
      extendBodyBehindAppBar: false, // 투명 AppBar라도 바디 뒤로 확장하지 않음
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        surfaceTintColor: Colors.transparent, // M3 틴트 제거
        scrolledUnderElevation: 0, // 스크롤 시 색 띠/음영 제거
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.textPrimary),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          '${widget.userType == UserType.customer ? '고객' : '수리기사'} 회원가입',
          style: AppTextStyles.cardTitle.copyWith(
            fontSize: 18,
            color: AppColors.textPrimary,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(
            AppSizes.md,
            AppSizes.md,
            AppSizes.md,
            AppSizes.xxl + 40, // 하단 홈 인디케이터 영역 고려
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // 헤더 섹션
              Center(
                child: Column(
                  children: [
                    // 사용자 타입 아이콘
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: widget.userType == UserType.customer
                            ? AppColors.cardBackgroundLight
                            : AppColors.cardBackgroundDark,
                        shape: BoxShape.circle,
                        border: widget.userType == UserType.customer
                            ? Border.all(
                                color: AppColors.primaryBorder,
                                width: 2,
                              )
                            : null,
                      ),
                      child: Icon(
                        widget.userType.icon,
                        size: 40,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(height: AppSizes.lg),

                    // 제목
                    Text(
                      '${widget.userType == UserType.customer ? '고객' : '수리기사'}으로 시작하기',
                      style: AppTextStyles.title.copyWith(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppSizes.sm),

                    // 부제목
                    Text(
                      widget.userType == UserType.customer
                          ? '수리 서비스를 쉽고 빠르게 받아보세요'
                          : '고객을 만나고 수익을 창출해보세요',
                      style: AppTextStyles.subtitle.copyWith(
                        fontSize: 16,
                        color: AppColors.textSecondary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: AppSizes.xxl),

              // 회원가입 폼
              SignupForm(
                userType: widget.userType,
                onSubmit: _handleSignup,
                isLoading: _isLoading,
              ),

              const SizedBox(height: AppSizes.xxl),

              // 로그인 링크
              Container(
                padding: const EdgeInsets.only(bottom: 20), // 하단 추가 여백
                child: Center(
                  child: RichText(
                    text: TextSpan(
                      style: AppTextStyles.cardDescription.copyWith(
                        fontSize: 14,
                        color: AppColors.textSecondary,
                      ),
                      children: [
                        const TextSpan(text: '이미 계정이 있으신가요? '),
                        WidgetSpan(
                          child: GestureDetector(
                            onTap: () {
                              // TODO: 로그인 화면으로 이동
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('로그인 화면으로 이동합니다')),
                              );
                            },
                            child: Text(
                              '로그인',
                              style: AppTextStyles.cardDescription.copyWith(
                                fontSize: 14,
                                color: AppColors.primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
