import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_sizes.dart';
import '../../constants/app_text_styles.dart';
import '../../models/signup_data.dart';
import '../../models/user_type.dart';

/// 회원가입 폼 위젯
class SignupForm extends StatefulWidget {
  const SignupForm({
    super.key,
    required this.userType,
    required this.onSubmit,
    this.isLoading = false,
  });

  /// 사용자 타입
  final UserType userType;

  /// 제출 콜백
  final Function(SignupData) onSubmit;

  /// 로딩 상태
  final bool isLoading;

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _isEmailChecked = false;
  bool _isEmailChecking = false;
  String? _selectedRegion;
  bool _isPasswordValid = false;
  bool _isConfirmPasswordValid = false;
  bool _isPasswordFocused = false;

  // 지역 목록
  final List<String> _regions = [
    '서울특별시',
    '부산광역시',
    '대구광역시',
    '인천광역시',
    '광주광역시',
    '대전광역시',
    '울산광역시',
    '세종특별자치시',
    '경기도',
    '강원도',
    '충청북도',
    '충청남도',
    '전라북도',
    '전라남도',
    '경상북도',
    '경상남도',
    '제주특별자치도',
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  /// 폼 제출 처리
  void _handleSubmit() {
    if (_formKey.currentState!.validate() &&
        _isEmailChecked &&
        _selectedRegion != null) {
      final signupData = SignupData(
        email: _emailController.text.trim(),
        password: _passwordController.text,
        confirmPassword: _confirmPasswordController.text,
        region: _selectedRegion!,
        userType: widget.userType,
      );
      widget.onSubmit(signupData);
    }
  }

  /// 비밀번호 표시 토글
  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  /// 비밀번호 확인 표시 토글
  void _toggleConfirmPasswordVisibility() {
    setState(() {
      _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
    });
  }

  /// 비밀번호 유효성 검사
  bool _validatePassword(String password) {
    // 최소 8자, 대문자, 소문자, 숫자, 특수문자 포함
    if (password.length < 8) return false;
    if (!password.contains(RegExp(r'[A-Z]'))) return false;
    if (!password.contains(RegExp(r'[a-z]'))) return false;
    if (!password.contains(RegExp(r'[0-9]'))) return false;
    if (!password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) return false;
    return true;
  }

  /// 비밀번호 확인 검사
  bool _validateConfirmPassword(String confirmPassword) {
    return confirmPassword == _passwordController.text &&
        confirmPassword.isNotEmpty;
  }

  /// 비밀번호 입력 변경 시 호출
  void _onPasswordChanged(String password) {
    setState(() {
      _isPasswordValid = _validatePassword(password);
      _isConfirmPasswordValid = _validateConfirmPassword(
        _confirmPasswordController.text,
      );
    });
  }

  /// 비밀번호 확인 입력 변경 시 호출
  void _onConfirmPasswordChanged(String confirmPassword) {
    setState(() {
      _isConfirmPasswordValid = _validateConfirmPassword(confirmPassword);
    });
  }

  /// 이메일 중복체크
  Future<void> _checkEmailDuplicate() async {
    if (_emailController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('이메일을 먼저 입력해주세요')));
      return;
    }

    if (!RegExp(
      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
    ).hasMatch(_emailController.text)) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('올바른 이메일 형식을 입력해주세요')));
      return;
    }

    setState(() {
      _isEmailChecking = true;
    });

    try {
      // TODO: 실제 이메일 중복체크 API 호출
      await Future.delayed(const Duration(seconds: 1)); // 임시 딜레이

      if (mounted) {
        setState(() {
          _isEmailChecked = true;
        });

        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('사용 가능한 이메일입니다')));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('이메일 중복체크 중 오류가 발생했습니다: $e')));
      }
    } finally {
      setState(() {
        _isEmailChecking = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // 이메일 입력
          _buildEmailField(),

          const SizedBox(height: AppSizes.lg),

          // 비밀번호 입력
          _buildPasswordField(),

          const SizedBox(height: AppSizes.lg),

          // 비밀번호 확인 입력
          _buildConfirmPasswordField(),

          const SizedBox(height: AppSizes.lg),

          // 지역 선택
          _buildRegionField(),

          const SizedBox(height: AppSizes.xxl),

          // 회원가입 버튼
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: widget.isLoading ? null : _handleSubmit,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.background,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    AppSizes.cardBorderRadius,
                  ),
                ),
                elevation: 0,
              ),
              child: widget.isLoading
                  ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        color: AppColors.background,
                        strokeWidth: 2,
                      ),
                    )
                  : Text(
                      '${widget.userType == UserType.customer ? '고객' : '수리기사'} 회원가입',
                      style: AppTextStyles.cardTitle.copyWith(
                        color: AppColors.background,
                        fontSize: 16,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  /// 비밀번호 입력 필드 (규칙 표시 포함)
  Widget _buildPasswordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '비밀번호',
          style: AppTextStyles.cardTitle.copyWith(
            fontSize: 14,
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: AppSizes.sm),
        Focus(
          onFocusChange: (hasFocus) {
            setState(() {
              _isPasswordFocused = hasFocus;
            });
          },
          child: TextFormField(
            controller: _passwordController,
            obscureText: !_isPasswordVisible,
            onChanged: _onPasswordChanged,
            style: AppTextStyles.cardDescription.copyWith(
              fontSize: 16,
              color: AppColors.textPrimary,
            ),
            decoration: InputDecoration(
              hintText: '비밀번호를 입력하세요',
              hintStyle: AppTextStyles.cardDescription.copyWith(
                fontSize: 16,
                color: AppColors.textSecondary,
              ),
              suffixIcon: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (_isPasswordValid)
                    const Padding(
                      padding: EdgeInsets.only(right: 8),
                      child: Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 20,
                      ),
                    ),
                  IconButton(
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: AppColors.textSecondary,
                    ),
                    onPressed: _togglePasswordVisibility,
                  ),
                ],
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSizes.cardBorderRadius),
                borderSide: BorderSide(
                  color: AppColors.textSecondary.withValues(alpha: 0.3),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSizes.cardBorderRadius),
                borderSide: BorderSide(
                  color: AppColors.textSecondary.withValues(alpha: 0.3),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSizes.cardBorderRadius),
                borderSide: BorderSide(color: AppColors.primary, width: 2),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSizes.cardBorderRadius),
                borderSide: const BorderSide(color: Colors.red),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSizes.cardBorderRadius),
                borderSide: const BorderSide(color: Colors.red, width: 2),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: AppSizes.md,
                vertical: AppSizes.md,
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '비밀번호를 입력해주세요';
              }
              if (!_validatePassword(value)) {
                return '비밀번호는 8자 이상, 대소문자, 숫자, 특수문자를 포함해야 합니다';
              }
              return null;
            },
          ),
        ),
        // 비밀번호 규칙 표시 (포커스되고 입력할 때만)
        if (_isPasswordFocused && _passwordController.text.isNotEmpty) ...[
          const SizedBox(height: AppSizes.sm),
          _buildPasswordRules(),
        ],
      ],
    );
  }

  /// 비밀번호 확인 입력 필드
  Widget _buildConfirmPasswordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '비밀번호 확인',
          style: AppTextStyles.cardTitle.copyWith(
            fontSize: 14,
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: AppSizes.sm),
        TextFormField(
          controller: _confirmPasswordController,
          obscureText: !_isConfirmPasswordVisible,
          onChanged: _onConfirmPasswordChanged,
          style: AppTextStyles.cardDescription.copyWith(
            fontSize: 16,
            color: AppColors.textPrimary,
          ),
          decoration: InputDecoration(
            hintText: '비밀번호를 다시 입력하세요',
            hintStyle: AppTextStyles.cardDescription.copyWith(
              fontSize: 16,
              color: AppColors.textSecondary,
            ),
            suffixIcon: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (_isConfirmPasswordValid)
                  const Padding(
                    padding: EdgeInsets.only(right: 8),
                    child: Icon(
                      Icons.check_circle,
                      color: Colors.green,
                      size: 20,
                    ),
                  ),
                IconButton(
                  icon: Icon(
                    _isConfirmPasswordVisible
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: AppColors.textSecondary,
                  ),
                  onPressed: _toggleConfirmPasswordVisibility,
                ),
              ],
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSizes.cardBorderRadius),
              borderSide: BorderSide(
                color: AppColors.textSecondary.withValues(alpha: 0.3),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSizes.cardBorderRadius),
              borderSide: BorderSide(
                color: AppColors.textSecondary.withValues(alpha: 0.3),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSizes.cardBorderRadius),
              borderSide: BorderSide(color: AppColors.primary, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSizes.cardBorderRadius),
              borderSide: const BorderSide(color: Colors.red),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSizes.cardBorderRadius),
              borderSide: const BorderSide(color: Colors.red, width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: AppSizes.md,
              vertical: AppSizes.md,
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return '비밀번호 확인을 입력해주세요';
            }
            if (value != _passwordController.text) {
              return '비밀번호가 일치하지 않습니다';
            }
            return null;
          },
        ),
      ],
    );
  }

  /// 비밀번호 규칙 표시
  Widget _buildPasswordRules() {
    return Container(
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.security, size: 16, color: AppColors.primary),
              const SizedBox(width: 6),
              Text(
                '비밀번호 규칙',
                style: AppTextStyles.cardDescription.copyWith(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildRuleItem('최소 8자 이상', _passwordController.text.length >= 8),
          _buildRuleItem(
            '대문자 포함',
            _passwordController.text.contains(RegExp(r'[A-Z]')),
          ),
          _buildRuleItem(
            '소문자 포함',
            _passwordController.text.contains(RegExp(r'[a-z]')),
          ),
          _buildRuleItem(
            '숫자 포함',
            _passwordController.text.contains(RegExp(r'[0-9]')),
          ),
          _buildRuleItem(
            '특수문자 포함',
            _passwordController.text.contains(
              RegExp(r'[!@#$%^&*(),.?":{}|<>]'),
            ),
          ),
        ],
      ),
    );
  }

  /// 비밀번호 규칙 항목
  Widget _buildRuleItem(String text, bool isValid) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isValid
                  ? Colors.green
                  : AppColors.textSecondary.withValues(alpha: 0.2),
            ),
            child: isValid
                ? const Icon(Icons.check, size: 12, color: Colors.white)
                : null,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: AppTextStyles.cardDescription.copyWith(
                fontSize: 13,
                color: isValid
                    ? Colors.green
                    : AppColors.textSecondary.withValues(alpha: 0.6),
                fontWeight: isValid ? FontWeight.w500 : FontWeight.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 이메일 입력 필드 (중복체크 버튼 포함)
  Widget _buildEmailField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '이메일',
          style: AppTextStyles.cardTitle.copyWith(
            fontSize: 14,
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: AppSizes.sm),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                enabled: !_isEmailChecked,
                style: AppTextStyles.cardDescription.copyWith(
                  fontSize: 16,
                  color: AppColors.textPrimary,
                ),
                decoration: InputDecoration(
                  hintText: 'example@email.com',
                  hintStyle: AppTextStyles.cardDescription.copyWith(
                    fontSize: 16,
                    color: AppColors.textSecondary,
                  ),
                  suffixIcon: _isEmailChecked
                      ? const Icon(Icons.check_circle, color: Colors.green)
                      : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      AppSizes.cardBorderRadius,
                    ),
                    borderSide: BorderSide(
                      color: AppColors.textSecondary.withValues(alpha: 0.3),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      AppSizes.cardBorderRadius,
                    ),
                    borderSide: BorderSide(
                      color: AppColors.textSecondary.withValues(alpha: 0.3),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      AppSizes.cardBorderRadius,
                    ),
                    borderSide: BorderSide(color: AppColors.primary, width: 2),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      AppSizes.cardBorderRadius,
                    ),
                    borderSide: const BorderSide(color: Colors.red),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      AppSizes.cardBorderRadius,
                    ),
                    borderSide: const BorderSide(color: Colors.red, width: 2),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.md,
                    vertical: AppSizes.md,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '이메일을 입력해주세요';
                  }
                  if (!RegExp(
                    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                  ).hasMatch(value)) {
                    return '올바른 이메일 형식을 입력해주세요';
                  }
                  if (!_isEmailChecked) {
                    return '이메일 중복체크를 해주세요';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(width: AppSizes.sm),
            SizedBox(
              height: 56,
              child: ElevatedButton(
                onPressed: _isEmailChecked || _isEmailChecking
                    ? null
                    : _checkEmailDuplicate,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.background,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      AppSizes.cardBorderRadius,
                    ),
                  ),
                  elevation: 0,
                ),
                child: _isEmailChecking
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          color: AppColors.background,
                          strokeWidth: 2,
                        ),
                      )
                    : Text(
                        _isEmailChecked ? '완료' : '중복체크',
                        style: AppTextStyles.cardDescription.copyWith(
                          color: AppColors.background,
                          fontSize: 14,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// 지역 선택 필드
  Widget _buildRegionField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '지역',
          style: AppTextStyles.cardTitle.copyWith(
            fontSize: 14,
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: AppSizes.sm),
        GestureDetector(
          onTap: () => _showRegionBottomSheet(),
          child: Container(
            height: 56,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSizes.cardBorderRadius),
              border: Border.all(
                color: _selectedRegion != null
                    ? AppColors.primary
                    : AppColors.textSecondary.withValues(alpha: 0.3),
                width: _selectedRegion != null ? 2 : 1,
              ),
              color: AppColors.background,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.md,
              vertical: AppSizes.md,
            ),
            child: Row(
              children: [
                Icon(
                  Icons.location_on_outlined,
                  size: 20,
                  color: _selectedRegion != null
                      ? AppColors.primary
                      : AppColors.textSecondary.withValues(alpha: 0.7),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    _selectedRegion ?? '지역을 선택하세요',
                    style: AppTextStyles.cardDescription.copyWith(
                      fontSize: 16,
                      color: _selectedRegion != null
                          ? AppColors.textPrimary
                          : AppColors.textSecondary,
                    ),
                  ),
                ),
                Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: AppColors.textSecondary,
                  size: 24,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// 지역 선택 바텀시트 표시
  void _showRegionBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.6,
        decoration: const BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          children: [
            // 핸들 바
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: AppColors.textSecondary.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            // 제목
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Text(
                '지역 선택',
                style: AppTextStyles.cardTitle.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const Divider(height: 1),
            // 지역 목록
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 8),
                itemCount: _regions.length,
                itemBuilder: (context, index) {
                  final region = _regions[index];
                  final isSelected = _selectedRegion == region;

                  return Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.primary.withValues(alpha: 0.1)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: Icon(
                        Icons.location_on_outlined,
                        size: 20,
                        color: isSelected
                            ? AppColors.primary
                            : AppColors.textSecondary.withValues(alpha: 0.7),
                      ),
                      title: Text(
                        region,
                        style: AppTextStyles.cardDescription.copyWith(
                          fontSize: 16,
                          color: isSelected
                              ? AppColors.primary
                              : AppColors.textPrimary,
                          fontWeight: isSelected
                              ? FontWeight.w600
                              : FontWeight.normal,
                        ),
                      ),
                      trailing: isSelected
                          ? Icon(
                              Icons.check_circle,
                              color: AppColors.primary,
                              size: 20,
                            )
                          : null,
                      onTap: () {
                        setState(() {
                          _selectedRegion = region;
                        });
                        Navigator.pop(context);
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 입력 필드 위젯 생성
  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required String hintText,
    TextInputType? keyboardType,
    bool obscureText = false,
    Widget? suffixIcon,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.cardTitle.copyWith(
            fontSize: 14,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: AppSizes.sm),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscureText,
          maxLines: maxLines,
          validator: validator,
          style: AppTextStyles.cardDescription.copyWith(
            fontSize: 16,
            color: AppColors.textPrimary,
          ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: AppTextStyles.cardDescription.copyWith(
              fontSize: 16,
              color: AppColors.textSecondary,
            ),
            suffixIcon: suffixIcon,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSizes.cardBorderRadius),
              borderSide: BorderSide(
                color: AppColors.textSecondary.withValues(alpha: 0.3),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSizes.cardBorderRadius),
              borderSide: BorderSide(
                color: AppColors.textSecondary.withValues(alpha: 0.3),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSizes.cardBorderRadius),
              borderSide: BorderSide(color: AppColors.primary, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSizes.cardBorderRadius),
              borderSide: BorderSide(color: Colors.red),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSizes.cardBorderRadius),
              borderSide: BorderSide(color: Colors.red, width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: AppSizes.md,
              vertical: AppSizes.md,
            ),
          ),
        ),
      ],
    );
  }
}
