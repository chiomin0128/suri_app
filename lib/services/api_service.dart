import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';

/// API 응답 모델
class ApiResponse {
  final bool success;
  final String message;
  final Map<String, dynamic>? data;
  final int? statusCode;

  const ApiResponse({
    required this.success,
    required this.message,
    this.data,
    this.statusCode,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json, int statusCode) {
    return ApiResponse(
      success: statusCode >= 200 && statusCode < 300,
      message: json['message'] ?? 'Unknown error',
      data: json,
      statusCode: statusCode,
    );
  }
}

/// 이메일 중복 체크 응답 모델
class EmailCheckResponse {
  final bool available;
  final String message;
  final String email;
  final String timestamp;

  const EmailCheckResponse({
    required this.available,
    required this.message,
    required this.email,
    required this.timestamp,
  });

  factory EmailCheckResponse.fromJson(Map<String, dynamic> json) {
    return EmailCheckResponse(
      available: json['available'] ?? false,
      message: json['message'] ?? '',
      email: json['email'] ?? '',
      timestamp: json['timestamp'] ?? '',
    );
  }
}

/// 회원가입 응답 모델
class SignupResponse {
  final bool success;
  final String message;
  final MemberInfo member;
  final String verificationToken;
  final String timestamp;

  const SignupResponse({
    required this.success,
    required this.message,
    required this.member,
    required this.verificationToken,
    required this.timestamp,
  });

  factory SignupResponse.fromJson(Map<String, dynamic> json) {
    return SignupResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      member: MemberInfo.fromJson(json['member'] ?? {}),
      verificationToken: json['verification_token'] ?? '',
      timestamp: json['timestamp'] ?? '',
    );
  }
}

/// 회원 정보 모델
class MemberInfo {
  final int id;
  final String email;
  final String username;
  final String fullName;
  final String? phone;
  final String? region;
  final String grade;
  final bool isVerified;
  final String createdAt;

  const MemberInfo({
    required this.id,
    required this.email,
    required this.username,
    required this.fullName,
    this.phone,
    this.region,
    required this.grade,
    required this.isVerified,
    required this.createdAt,
  });

  factory MemberInfo.fromJson(Map<String, dynamic> json) {
    return MemberInfo(
      id: json['id'] ?? 0,
      email: json['email'] ?? '',
      username: json['username'] ?? '',
      fullName: json['full_name'] ?? '',
      phone: json['phone'],
      region: json['region'],
      grade: json['grade'] ?? 'consumer',
      isVerified: json['is_verified'] ?? false,
      createdAt: json['created_at'] ?? '',
    );
  }
}

/// API 서비스 클래스
class ApiService {
  /// 이메일 중복 체크
  static Future<EmailCheckResponse> checkEmailAvailability(String email) async {
    try {
      final response = await http.get(
        Uri.parse(ApiConfig.getCheckEmailUrl(email)),
        headers: {'Content-Type': 'application/json'},
      );

      final responseData = json.decode(response.body) as Map<String, dynamic>;

      if (response.statusCode == 200) {
        return EmailCheckResponse.fromJson(responseData);
      } else {
        throw Exception(
          '이메일 중복 체크 실패: ${responseData['message'] ?? 'Unknown error'}',
        );
      }
    } on http.ClientException {
      throw Exception('네트워크 연결을 확인해주세요.');
    } catch (e) {
      throw Exception('이메일 중복 체크 중 오류가 발생했습니다: $e');
    }
  }

  /// 회원가입 API
  static Future<SignupResponse> registerMember({
    required String email,
    required String password,
    required String username,
    required String fullName,
    String? phone,
    String? region,
    required String grade,
    List<int> specialtyIds = const [],
  }) async {
    try {
      final requestBody = <String, dynamic>{
        'email': email,
        'username': username,
        'password': password,
        'full_name': fullName,
        'grade': grade,
      };

      // 선택적 필드 추가
      if (phone != null && phone.isNotEmpty) {
        requestBody['phone'] = phone;
      }
      if (region != null && region.isNotEmpty) {
        requestBody['region'] = region;
      }

      // specialty_ids는 항상 전송 (빈 배열이라도)
      requestBody['specialty_ids'] = specialtyIds;

      print('=== API 요청 데이터 ===');
      print('URL: ${ApiConfig.getSignupUrl()}');
      print('Request Body: ${json.encode(requestBody)}');

      final response = await http.post(
        Uri.parse(ApiConfig.getSignupUrl()),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(requestBody),
      );

      final responseData = json.decode(response.body) as Map<String, dynamic>;

      if (response.statusCode == 201) {
        return SignupResponse.fromJson(responseData);
      } else {
        // API 가이드에 따른 오류 처리
        String errorMessage = 'Unknown error';
        if (responseData.containsKey('detail')) {
          if (responseData['detail'] is String) {
            errorMessage = responseData['detail'];
          } else if (responseData['detail'] is List) {
            // 422 오류의 경우 detail 배열에서 메시지 추출
            final details = responseData['detail'] as List;
            if (details.isNotEmpty && details[0] is Map) {
              final firstError = details[0] as Map<String, dynamic>;
              errorMessage = firstError['msg'] ?? errorMessage;
            }
          }
        }
        throw Exception('회원가입 실패: $errorMessage');
      }
    } on http.ClientException {
      throw Exception('네트워크 연결을 확인해주세요.');
    } catch (e) {
      throw Exception('회원가입 중 오류가 발생했습니다: $e');
    }
  }

  /// 전문분야 목록 조회
  static Future<List<Map<String, dynamic>>> getSpecialties() async {
    try {
      final response = await http.get(
        Uri.parse('${ApiConfig.baseUrl}/api/v1/specialties/'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> specialties = json.decode(response.body);
        return specialties.cast<Map<String, dynamic>>();
      } else {
        throw Exception('전문분야 조회 실패: ${response.statusCode}');
      }
    } on http.ClientException {
      throw Exception('네트워크 연결을 확인해주세요.');
    } catch (e) {
      throw Exception('전문분야 조회 중 오류가 발생했습니다: $e');
    }
  }
}
