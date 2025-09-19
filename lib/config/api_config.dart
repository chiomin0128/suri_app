/// API 설정 클래스
class ApiConfig {
  // 개발 환경
  static const String devBaseUrl = 'http://localhost:8000';

  // 프로덕션 환경 (실제 서버 URL로 변경 필요)
  static const String prodBaseUrl = 'http://127.0.0.1:8000/';

  // 현재 사용할 기본 URL (개발 환경)
  static const String baseUrl = devBaseUrl;

  // API 엔드포인트
  static const String checkEmailEndpoint = '/api/v1/members/check-email';
  static const String signupEndpoint = '/api/v1/members/register';

  /// 전체 URL 생성
  static String getCheckEmailUrl(String email) {
    return '$baseUrl$checkEmailEndpoint/$email';
  }

  static String getSignupUrl() {
    return '$baseUrl$signupEndpoint';
  }
}
