import 'user_type.dart';

/// 회원가입 데이터 모델
class SignupData {
  final String email;
  final String password;
  final String confirmPassword;
  final String username; // 사용자명 (영문, 숫자, 언더스코어만)
  final String fullName; // 실명
  final String? phone; // 전화번호 (선택사항)
  final String region; // 서울, 부산, 경기도 등
  final UserType userType;
  final String grade; // 등급 (consumer: 고객, technician: 수리기사)
  final List<int> specialtyIds; // 전문분야 ID 목록 (수리기사만)

  const SignupData({
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.username,
    required this.fullName,
    this.phone,
    required this.region,
    required this.userType,
    required this.grade,
    this.specialtyIds = const [],
  });

  /// 빈 데이터로 초기화
  factory SignupData.empty(UserType userType) {
    return SignupData(
      email: '',
      password: '',
      confirmPassword: '',
      username: '',
      fullName: '',
      phone: null,
      region: '',
      userType: userType,
      grade: userType == UserType.customer ? 'consumer' : 'technician',
      specialtyIds: userType == UserType.technician ? [] : [],
    );
  }

  /// 데이터 복사본 생성
  SignupData copyWith({
    String? email,
    String? password,
    String? confirmPassword,
    String? username,
    String? fullName,
    String? phone,
    String? region,
    UserType? userType,
    String? grade,
    List<int>? specialtyIds,
  }) {
    return SignupData(
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      username: username ?? this.username,
      fullName: fullName ?? this.fullName,
      phone: phone ?? this.phone,
      region: region ?? this.region,
      userType: userType ?? this.userType,
      grade: grade ?? this.grade,
      specialtyIds: specialtyIds ?? this.specialtyIds,
    );
  }

  /// 유효성 검사
  bool get isValid {
    bool basicValid =
        email.isNotEmpty &&
        password.isNotEmpty &&
        confirmPassword.isNotEmpty &&
        username.isNotEmpty &&
        fullName.isNotEmpty &&
        region.isNotEmpty;

    // 수리기사인 경우 전문분야 선택 필수
    if (userType == UserType.technician) {
      return basicValid && specialtyIds.isNotEmpty;
    }

    return basicValid;
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

  /// 사용자명 유효성 검사 (영문, 숫자, 언더스코어만)
  bool get isUsernameValid {
    return RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(username) &&
        username.length >= 3;
  }

  /// 실명 유효성 검사 (한글, 영문, 공백 허용)
  bool get isFullNameValid {
    return RegExp(r'^[가-힣a-zA-Z\s]+$').hasMatch(fullName) &&
        fullName.length >= 2;
  }

  /// 전화번호 유효성 검사 (010-1234-5678 형식)
  bool get isPhoneValid {
    if (phone == null || phone!.isEmpty) return true; // 선택사항이므로 빈 값도 유효
    return RegExp(r'^010-\d{4}-\d{4}$').hasMatch(phone!);
  }
}
