import 'user_type.dart';

/// 회원가입 데이터 모델
class SignupData {
  final String email;
  final String password;
  final String confirmPassword;
  final String region; // 서울, 부산, 경기도 등
  final UserType userType;

  const SignupData({
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.region,
    required this.userType,
  });

  /// 빈 데이터로 초기화
  factory SignupData.empty(UserType userType) {
    return SignupData(
      email: '',
      password: '',
      confirmPassword: '',
      region: '',
      userType: userType,
    );
  }

  /// 데이터 복사본 생성
  SignupData copyWith({
    String? email,
    String? password,
    String? confirmPassword,
    String? region,
    UserType? userType,
  }) {
    return SignupData(
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      region: region ?? this.region,
      userType: userType ?? this.userType,
    );
  }

  /// 유효성 검사
  bool get isValid {
    return email.isNotEmpty &&
        password.isNotEmpty &&
        confirmPassword.isNotEmpty &&
        region.isNotEmpty;
  }

  /// 이메일 유효성 검사
  bool get isEmailValid {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  /// 비밀번호 유효성 검사 (최소 8자)
  bool get isPasswordValid {
    return password.length >= 8;
  }

  /// 비밀번호 확인 유효성 검사
  bool get isConfirmPasswordValid {
    return password == confirmPassword;
  }
}
