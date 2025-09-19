import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_sizes.dart';
import '../../constants/app_text_styles.dart';
import '../../models/signup_data.dart';
import '../../models/user_type.dart';
import '../../services/api_service.dart';
import 'repair_fields_selector.dart';

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
  final _usernameController = TextEditingController();
  final _fullNameController = TextEditingController();
  final _phoneController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _isEmailChecked = false;
  bool _isEmailChecking = false;
  String? _selectedRegion;
  bool _isPasswordValid = false;
  bool _isConfirmPasswordValid = false;
  bool _isPasswordFocused = false;
  bool _isUsernameValid = false;
  bool _isFullNameValid = false;
  bool _isPhoneValid = false;
  List<int> _selectedSpecialtyIds = [];

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
    _usernameController.dispose();
    _fullNameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  /// 폼 제출 처리
  void _handleSubmit() {
    print('=== 회원가입 버튼 클릭 ===');
    print('사용자 타입: ${widget.userType}');
    print('이메일 중복 체크: $_isEmailChecked');
    print('선택된 지역: $_selectedRegion');
    print('선택된 전문분야: $_selectedSpecialtyIds');

    // 수리기사인 경우 수리 분야 선택 확인
    if (widget.userType == UserType.technician &&
        _selectedSpecialtyIds.isEmpty) {
      print('❌ 수리기사인데 전문분야가 선택되지 않음');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('수리 가능한 분야를 최소 1개 이상 선택해주세요'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // 폼 유효성 검사
    final isFormValid = _formKey.currentState!.validate();
    print('폼 유효성 검사: $isFormValid');

    if (!isFormValid) {
      print('❌ 폼 유효성 검사 실패');
      return;
    }

    if (!_isEmailChecked) {
      print('❌ 이메일 중복 체크가 완료되지 않음');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('이메일 중복 체크를 완료해주세요'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (_selectedRegion == null) {
      print('❌ 지역이 선택되지 않음');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('지역을 선택해주세요'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    print('✅ 모든 조건 통과, API 요청 시작');
    final signupData = SignupData(
      email: _emailController.text.trim(),
      password: _passwordController.text,
      confirmPassword: _confirmPasswordController.text,
      username: _usernameController.text.trim(),
      fullName: _fullNameController.text.trim(),
      phone: _phoneController.text.trim().isEmpty
          ? null
          : _phoneController.text.trim(),
      region: _selectedRegion!,
      userType: widget.userType,
      grade: widget.userType == UserType.customer ? 'consumer' : 'technician',
      specialtyIds: _selectedSpecialtyIds,
    );
    widget.onSubmit(signupData);
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

  /// 사용자명 유효성 검사
  bool _validateUsername(String username) {
    return RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(username) &&
        username.length >= 3;
  }

  /// 실명 유효성 검사
  bool _validateFullName(String fullName) {
    return RegExp(r'^[가-힣a-zA-Z\s]+$').hasMatch(fullName) &&
        fullName.length >= 2;
  }

  /// 전화번호 유효성 검사
  bool _validatePhone(String phone) {
    if (phone.isEmpty) return true; // 선택사항이므로 빈 값도 유효
    return RegExp(r'^010-\d{4}-\d{4}$').hasMatch(phone);
  }

  /// 사용자명 입력 변경 시 호출
  void _onUsernameChanged(String username) {
    setState(() {
      _isUsernameValid = _validateUsername(username);
    });
  }

  /// 실명 입력 변경 시 호출
  void _onFullNameChanged(String fullName) {
    setState(() {
      _isFullNameValid = _validateFullName(fullName);
    });
  }

  /// 전화번호 입력 변경 시 호출
  void _onPhoneChanged(String phone) {
    setState(() {
      _isPhoneValid = _validatePhone(phone);
    });
  }

  /// 이메일 사용 불가 다이얼로그 표시
  void _showEmailUnavailableDialog(String message) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.cardBorderRadius),
        ),
        contentPadding: const EdgeInsets.all(24),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 아이콘
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: Colors.red.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.email_outlined,
                size: 32,
                color: Colors.red,
              ),
            ),
            const SizedBox(height: AppSizes.lg),

            // 제목
            Text(
              '이메일 사용 불가',
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
              message,
              style: AppTextStyles.cardDescription.copyWith(
                fontSize: 16,
                color: AppColors.textSecondary,
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSizes.lg),
          ],
        ),
        actions: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                // 이메일 필드에 포커스
                FocusScope.of(context).requestFocus(FocusNode());
                Future.delayed(const Duration(milliseconds: 100), () {
                  _emailController.clear();
                  setState(() {
                    _isEmailChecked = false;
                  });
                });
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
                '다시 입력하기',
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
      // 실제 이메일 중복체크 API 호출
      final response = await ApiService.checkEmailAvailability(
        _emailController.text.trim(),
      );

      if (mounted) {
        if (response.available) {
          setState(() {
            _isEmailChecked = true;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(response.message),
              backgroundColor: Colors.green,
            ),
          );
        } else {
          setState(() {
            _isEmailChecked = false;
          });
          // 이메일이 사용 중일 때 중앙에 알림 다이얼로그 표시
          _showEmailUnavailableDialog(response.message);
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isEmailChecked = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('이메일 중복체크 중 오류가 발생했습니다: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isEmailChecking = false;
        });
      }
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

          // 사용자명 입력
          _buildUsernameField(),

          const SizedBox(height: AppSizes.lg),

          // 실명 입력
          _buildFullNameField(),

          const SizedBox(height: AppSizes.lg),

          // 전화번호 입력
          _buildPhoneField(),

          const SizedBox(height: AppSizes.lg),

          // 비밀번호 입력
          _buildPasswordField(),

          const SizedBox(height: AppSizes.lg),

          // 비밀번호 확인 입력
          _buildConfirmPasswordField(),

          const SizedBox(height: AppSizes.lg),

          // 지역 선택
          _buildRegionField(),

          // 수리기사인 경우 수리 분야 선택
          if (widget.userType == UserType.technician) ...[
            const SizedBox(height: AppSizes.lg),
            RepairFieldsSelector(
              selectedSpecialtyIds: _selectedSpecialtyIds,
              onSpecialtyIdsChanged: (specialtyIds) {
                setState(() {
                  _selectedSpecialtyIds = specialtyIds;
                });
              },
            ),
          ],

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

  /// 사용자명 입력 필드
  Widget _buildUsernameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '사용자명',
          style: AppTextStyles.cardTitle.copyWith(
            fontSize: 14,
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: AppSizes.sm),
        TextFormField(
          controller: _usernameController,
          onChanged: _onUsernameChanged,
          style: AppTextStyles.cardDescription.copyWith(
            fontSize: 16,
            color: AppColors.textPrimary,
          ),
          decoration: InputDecoration(
            hintText: '영문, 숫자, 언더스코어만 사용 (3자 이상)',
            hintStyle: AppTextStyles.cardDescription.copyWith(
              fontSize: 16,
              color: AppColors.textSecondary,
            ),
            suffixIcon: _isUsernameValid
                ? const Icon(Icons.check_circle, color: Colors.green)
                : null,
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
              return '사용자명을 입력해주세요';
            }
            if (!_validateUsername(value)) {
              return '영문, 숫자, 언더스코어만 사용하고 3자 이상 입력해주세요';
            }
            return null;
          },
        ),
      ],
    );
  }

  /// 실명 입력 필드
  Widget _buildFullNameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '실명',
          style: AppTextStyles.cardTitle.copyWith(
            fontSize: 14,
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: AppSizes.sm),
        TextFormField(
          controller: _fullNameController,
          onChanged: _onFullNameChanged,
          style: AppTextStyles.cardDescription.copyWith(
            fontSize: 16,
            color: AppColors.textPrimary,
          ),
          decoration: InputDecoration(
            hintText: '한글 또는 영문으로 입력 (2자 이상)',
            hintStyle: AppTextStyles.cardDescription.copyWith(
              fontSize: 16,
              color: AppColors.textSecondary,
            ),
            suffixIcon: _isFullNameValid
                ? const Icon(Icons.check_circle, color: Colors.green)
                : null,
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
              return '실명을 입력해주세요';
            }
            if (!_validateFullName(value)) {
              return '한글 또는 영문으로 2자 이상 입력해주세요';
            }
            return null;
          },
        ),
      ],
    );
  }

  /// 전화번호 입력 필드
  Widget _buildPhoneField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '전화번호 (선택사항)',
          style: AppTextStyles.cardTitle.copyWith(
            fontSize: 14,
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: AppSizes.sm),
        TextFormField(
          controller: _phoneController,
          onChanged: _onPhoneChanged,
          keyboardType: TextInputType.phone,
          style: AppTextStyles.cardDescription.copyWith(
            fontSize: 16,
            color: AppColors.textPrimary,
          ),
          decoration: InputDecoration(
            hintText: '010-1234-5678',
            hintStyle: AppTextStyles.cardDescription.copyWith(
              fontSize: 16,
              color: AppColors.textSecondary,
            ),
            suffixIcon: _isPhoneValid && _phoneController.text.isNotEmpty
                ? const Icon(Icons.check_circle, color: Colors.green)
                : null,
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
            if (value != null && value.isNotEmpty && !_validatePhone(value)) {
              return '010-1234-5678 형식으로 입력해주세요';
            }
            return null;
          },
        ),
      ],
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
                onChanged: (value) {
                  // 이메일이 변경되면 중복 체크 상태 초기화
                  if (_isEmailChecked) {
                    setState(() {
                      _isEmailChecked = false;
                    });
                  }
                  // 버튼 상태 업데이트를 위해 setState 호출
                  setState(() {});
                },
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
                onPressed:
                    _isEmailChecking ||
                        _emailController.text.isEmpty ||
                        !RegExp(
                          r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                        ).hasMatch(_emailController.text)
                    ? null
                    : _checkEmailDuplicate,
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      _isEmailChecking ||
                          _emailController.text.isEmpty ||
                          !RegExp(
                            r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                          ).hasMatch(_emailController.text)
                      ? AppColors.textSecondary.withValues(alpha: 0.3)
                      : _isEmailChecked
                      ? Colors.green
                      : AppColors.primary,
                  foregroundColor:
                      _isEmailChecking ||
                          _emailController.text.isEmpty ||
                          !RegExp(
                            r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                          ).hasMatch(_emailController.text)
                      ? AppColors.textSecondary.withValues(alpha: 0.6)
                      : AppColors.background,
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
                    : Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (_isEmailChecked) ...[
                            const Icon(Icons.check, size: 16),
                            const SizedBox(width: 4),
                          ],
                          Text(
                            _isEmailChecked ? '완료' : '중복체크',
                            style: AppTextStyles.cardDescription.copyWith(
                              color: AppColors.background,
                              fontSize: 14,
                            ),
                          ),
                        ],
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
}
