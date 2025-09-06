# 수리모아 (Suri Moa) - Flutter 앱

## 📱 프로젝트 개요
수리모아는 AI 기반 스마트 매칭을 통해 고객과 수리기사를 연결하는 혁신적인 플랫폼 앱입니다. 고객은 AI가 최적의 수리기사를 자동으로 찾아주는 서비스를 이용할 수 있으며, 수리기사는 전문성을 바탕으로 고객에게 서비스를 제공할 수 있습니다.

## ✨ 주요 기능

### 🎯 핵심 기능
- **AI 스마트 매칭**: LLM과 VLM을 활용한 지능형 수리기사 매칭
- **사진 기반 진단**: AI가 사진을 분석하여 문제를 진단하고 최적의 수리기사 추천
- **실시간 견적 요청**: 즉시 견적을 받을 수 있는 스마트 요청 시스템
- **다양한 수리 서비스**: 배관, 전기, 가전, 도배, 타일 등 종합 수리 서비스

### 👥 사용자 타입
- **고객**: 수리 서비스 요청 및 AI 매칭 이용
- **수리기사**: 전문 서비스 제공 및 수익 창출

### 🎨 UI/UX 특징
- **Soomgo 스타일 디자인**: 깔끔하고 모던한 인터페이스
- **반응형 디자인**: 다양한 화면 크기에 최적화
- **직관적 네비게이션**: 사용자 친화적인 화면 구성
- **커스텀 폰트**: Gasoek One, Pretendard 폰트로 브랜드 아이덴티티 강화

## 🏗️ 프로젝트 구조

```
lib/
├── constants/                    # 앱 상수 정의
│   ├── app_colors.dart          # 색상 시스템
│   ├── app_sizes.dart           # 크기 및 간격 상수
│   └── app_text_styles.dart     # 텍스트 스타일 시스템
├── models/                      # 데이터 모델
│   ├── signup_data.dart         # 회원가입 데이터 모델
│   └── user_type.dart           # 사용자 타입 정의
├── screens/                     # 화면 위젯
│   ├── ai_request_screen.dart   # AI 스마트 견적 요청 화면
│   ├── customer_home_screen.dart # 고객 홈 화면
│   ├── onboarding_screen.dart   # 온보딩 화면
│   └── signup_screen.dart       # 회원가입 화면
├── widgets/                     # 재사용 가능한 위젯
│   ├── common/                  # 공통 위젯
│   │   ├── avatar_placeholder.dart    # 아바타 플레이스홀더
│   │   └── chevron_forward_icon.dart # 화살표 아이콘
│   ├── customer/                # 고객 관련 위젯
│   │   ├── banner_slider.dart         # 배너 슬라이더
│   │   ├── bottom_navigation.dart     # 하단 네비게이션
│   │   ├── quote_notification.dart    # 견적 알림
│   │   ├── recommended_services.dart  # 추천 서비스
│   │   └── service_categories.dart    # 서비스 카테고리
│   ├── onboarding/              # 온보딩 관련 위젯
│   │   ├── logo_header.dart           # 로고 및 헤더
│   │   └── user_type_card.dart        # 사용자 타입 선택 카드
│   └── signup/                  # 회원가입 관련 위젯
│       └── signup_form.dart           # 회원가입 폼
└── main.dart                    # 앱 진입점
```

## 🎯 주요 화면 및 기능

### 1. 온보딩 화면 (`onboarding_screen.dart`)
- 사용자 타입 선택 (고객/수리기사)
- 직관적인 카드 기반 선택 인터페이스
- 개발자용 네비게이션 버튼 (개발 단계)

### 2. 회원가입 화면 (`signup_screen.dart`)
- **이메일 중복 체크**: 실시간 이메일 유효성 검사
- **비밀번호 확인**: 비밀번호 일치 검증
- **지역 선택**: 2단계 드롭다운 (시/도 → 시/군/구)
- **비밀번호 규칙**: 동적 비밀번호 규칙 표시
- **AI 가이드라인**: 사진 촬영 및 설명 가이드

### 3. 고객 홈 화면 (`customer_home_screen.dart`)
- **Soomgo 스타일 디자인**: 깔끔하고 모던한 인터페이스
- **배너 슬라이더**: 프로모션 및 공지사항
- **서비스 카테고리**: 8개 주요 수리 서비스
- **AI 스마트 매칭**: AI 기반 수리기사 매칭 섹션
- **추천 서비스**: 인기 수리 서비스 추천
- **견적 알림**: 새로운 견적 도착 알림

### 4. AI 스마트 견적 요청 (`ai_request_screen.dart`)
- **사진 업로드**: 최대 5장까지 수리 부위 사진 업로드
- **상세 설명**: LLM을 위한 구체적인 문제 설명
- **위치 선택**: 2단계 지역 선택 (시/도 → 시/군/구)
- **수리기사 조건**: 슬라이더 기반 세밀한 조건 설정
  - 별점: 1.0~5.0점 (0.1점 단위)
  - 리뷰 수: 0~500개 (50개 단위)
  - 경험: 0~10년 (1년 단위)
- **긴급도 선택**: 수수료 정보와 함께 긴급도 설정

## 🎨 디자인 시스템

### 색상 시스템 (`app_colors.dart`)
- **Primary**: 메인 브랜드 컬러
- **Secondary**: 보조 컬러
- **Text Primary/Secondary**: 텍스트 계층
- **Background**: 배경색 시스템
- **Success/Warning/Error**: 상태별 색상

### 타이포그래피 (`app_text_styles.dart`)
- **Gasoek One**: 로고 및 브랜드 텍스트
- **Pretendard**: 본문 및 UI 텍스트
- **체계적인 폰트 크기**: 10px~24px 범위
- **일관된 폰트 웨이트**: Regular, Medium, SemiBold, Bold

### 크기 시스템 (`app_sizes.dart`)
- **일관된 간격**: 4px, 8px, 12px, 16px, 20px, 24px
- **컴포넌트 크기**: 버튼, 카드, 아이콘 등 표준 크기
- **반응형 브레이크포인트**: 다양한 화면 크기 대응

## 🚀 설치 및 실행

### 필수 요구사항
- **Flutter SDK**: 3.9.0 이상
- **Dart SDK**: 3.9.0 이상
- **Android Studio**: 최신 버전 권장
- **Xcode**: iOS 개발 시 (macOS만)

### 폰트 설치
앱을 실행하기 전에 `fonts/` 디렉토리에 필요한 폰트 파일들을 설치해야 합니다:

```
fonts/
├── GasoekOne-Regular.ttf
├── Pretendard-Regular.otf
├── Pretendard-Medium.otf
├── Pretendard-SemiBold.otf
└── Pretendard-Bold.otf
```

### 설치 및 실행 방법

```bash
# 저장소 클론
git clone [repository-url]
cd suri_app

# 의존성 설치
flutter pub get

# 폰트 파일 확인
ls fonts/

# 앱 실행 (디버그 모드)
flutter run

# 특정 디바이스에서 실행
flutter run -d [device-id]

# 릴리즈 빌드
flutter build apk --release
flutter build ios --release
```

## 🛠️ 개발 가이드라인

### 1. 코드 스타일 규칙

#### 📝 네이밍 컨벤션
```dart
// 클래스명: PascalCase
class CustomerHomeScreen extends StatefulWidget {}

// 변수명/함수명: camelCase
String userName = '';
void handleUserLogin() {}

// 상수: UPPER_SNAKE_CASE
const String API_BASE_URL = 'https://api.surimoa.com';

// 파일명: snake_case
customer_home_screen.dart
signup_form.dart

// 위젯 함수: _build + PascalCase
Widget _buildTopBar() {}
Widget _buildCategoryChip() {}
```

#### 🎯 함수 작성 규칙
```dart
// 좋은 예: 명확한 함수명과 단일 책임
Widget _buildUserProfileCard(User user) {
  return Container(
    child: Column(
      children: [
        _buildAvatar(user.avatarUrl),
        _buildUserName(user.name),
        _buildUserRating(user.rating),
      ],
    ),
  );
}

// 나쁜 예: 모호한 함수명과 복잡한 로직
Widget build() {
  // 너무 많은 로직이 한 함수에...
}
```

#### 📋 주석 작성 규칙
```dart
/// 사용자 프로필 카드를 생성합니다.
/// 
/// [user] - 표시할 사용자 정보
/// [onTap] - 카드 탭 시 실행될 콜백
/// 
/// Returns: 사용자 프로필 카드 위젯
Widget _buildUserProfileCard({
  required User user,
  VoidCallback? onTap,
}) {
  // 사용자 아바타 표시
  final avatar = _buildAvatar(user.avatarUrl);
  
  // 사용자 이름과 평점을 세로로 배치
  final userInfo = Column(
    children: [
      _buildUserName(user.name),
      _buildUserRating(user.rating),
    ],
  );
  
  return GestureDetector(
    onTap: onTap,
    child: Container(/* ... */),
  );
}
```

### 2. 위젯 설계 원칙

#### 🏗️ 위젯 구조 규칙
```dart
class ServiceCategoryCard extends StatefulWidget {
  // 1. 상수 정의
  static const double cardHeight = 80.0;
  static const double iconSize = 24.0;
  
  // 2. 필수 매개변수
  final String categoryName;
  final IconData icon;
  final Color color;
  
  // 3. 선택적 매개변수
  final bool isSelected;
  final VoidCallback? onTap;
  
  // 4. 생성자
  const ServiceCategoryCard({
    Key? key,
    required this.categoryName,
    required this.icon,
    required this.color,
    this.isSelected = false,
    this.onTap,
  }) : super(key: key);
  
  @override
  State<ServiceCategoryCard> createState() => _ServiceCategoryCardState();
}

class _ServiceCategoryCardState extends State<ServiceCategoryCard> {
  // 1. 상태 변수
  bool _isPressed = false;
  
  // 2. 생명주기 메서드
  @override
  void initState() {
    super.initState();
    // 초기화 로직
  }
  
  @override
  void dispose() {
    // 정리 로직
    super.dispose();
  }
  
  // 3. 빌드 메서드
  @override
  Widget build(BuildContext context) {
    return _buildCard();
  }
  
  // 4. 헬퍼 메서드들
  Widget _buildCard() { /* ... */ }
  Widget _buildIcon() { /* ... */ }
  Widget _buildText() { /* ... */ }
}
```

#### 🎨 UI 컴포넌트 규칙
```dart
// 1. 일관된 패딩과 마진 사용
Container(
  padding: const EdgeInsets.all(AppSizes.md), // 16px
  margin: const EdgeInsets.symmetric(vertical: AppSizes.sm), // 8px
  child: Column(
    children: [
      // 2. 적절한 간격 사용
      const SizedBox(height: AppSizes.sm),
      
      // 3. 조건부 렌더링
      if (widget.showTitle) _buildTitle(),
      
      // 4. 반복 위젯은 별도 메서드로 분리
      ...widget.items.map((item) => _buildItem(item)),
    ],
  ),
)

// 5. 애니메이션은 AnimatedContainer 사용
AnimatedContainer(
  duration: const Duration(milliseconds: 300),
  curve: Curves.easeInOut,
  decoration: BoxDecoration(
    color: _isSelected ? AppColors.primary : Colors.white,
    borderRadius: BorderRadius.circular(AppSizes.sm),
  ),
  child: _buildContent(),
)
```

### 3. 폴더 구조 및 파일 규칙

#### 📁 폴더 구조 규칙
```
lib/
├── constants/           # 앱 전역 상수
│   ├── app_colors.dart      # 색상 상수만
│   ├── app_sizes.dart       # 크기 상수만
│   └── app_text_styles.dart # 텍스트 스타일만
├── models/              # 데이터 모델
│   ├── user.dart            # 단일 모델 파일
│   └── service.dart         # 단일 모델 파일
├── screens/             # 전체 화면
│   ├── home/                # 기능별 그룹화
│   │   ├── customer_home_screen.dart
│   │   └── technician_home_screen.dart
│   └── auth/
│       ├── login_screen.dart
│       └── signup_screen.dart
├── widgets/             # 재사용 가능한 위젯
│   ├── common/              # 공통 위젯
│   ├── forms/               # 폼 관련 위젯
│   └── cards/               # 카드 위젯들
└── services/            # 비즈니스 로직
    ├── api_service.dart
    └── auth_service.dart
```

#### 📄 파일 명명 규칙
```dart
// 화면 파일: [기능]_screen.dart
customer_home_screen.dart
ai_request_screen.dart
signup_screen.dart

// 위젯 파일: [기능]_widget.dart 또는 [기능명].dart
service_category_card.dart
banner_slider.dart
bottom_navigation.dart

// 모델 파일: [모델명].dart
user.dart
signup_data.dart
service_request.dart

// 서비스 파일: [기능]_service.dart
api_service.dart
auth_service.dart
notification_service.dart
```

### 4. 상태 관리 규칙

#### 🔄 상태 관리 패턴
```dart
class CustomerHomeScreen extends StatefulWidget {
  @override
  State<CustomerHomeScreen> createState() => _CustomerHomeScreenState();
}

class _CustomerHomeScreenState extends State<CustomerHomeScreen> {
  // 1. 상태 변수는 private으로 선언
  String _selectedCategory = '';
  bool _isLoading = false;
  List<Service> _services = [];
  
  // 2. Controller는 dispose에서 해제
  final PageController _pageController = PageController();
  
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
  
  // 3. 상태 업데이트는 setState로
  void _selectCategory(String category) {
    setState(() {
      _selectedCategory = category;
    });
  }
  
  // 4. 비동기 작업은 async/await 사용
  Future<void> _loadServices() async {
    setState(() {
      _isLoading = true;
    });
    
    try {
      final services = await ApiService.getServices();
      setState(() {
        _services = services;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      _showErrorDialog(e.toString());
    }
  }
}
```

#### 📝 폼 상태 관리
```dart
class SignupForm extends StatefulWidget {
  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  // 1. Form key와 Controller들
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  
  // 2. 폼 상태 변수들
  bool _isPasswordVisible = false;
  bool _isEmailValid = false;
  String? _selectedRegion;
  
  @override
  void dispose() {
    // 3. 모든 Controller 해제
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
  
  // 4. 유효성 검사 함수들
  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return '이메일을 입력해주세요';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return '올바른 이메일 형식을 입력해주세요';
    }
    return null;
  }
  
  // 5. 폼 제출 처리
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // 폼 제출 로직
    }
  }
}
```

### 5. 디자인 시스템 규칙

#### 🎨 색상 사용 규칙
```dart
// 1. AppColors 상수만 사용
Container(
  color: AppColors.primary,           // ✅ 좋음
  // color: Color(0xFF4CAF50),       // ❌ 나쁨
)

// 2. 투명도는 withValues 사용
Container(
  color: AppColors.primary.withValues(alpha: 0.1), // ✅ Flutter 3.16+
  // color: AppColors.primary.withOpacity(0.1),    // ❌ deprecated
)

// 3. 그라데이션은 LinearGradient 사용
Container(
  decoration: BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        AppColors.primary,
        AppColors.primary.withValues(alpha: 0.8),
      ],
    ),
  ),
)
```

#### 📏 크기 및 간격 규칙
```dart
// 1. AppSizes 상수만 사용
Container(
  padding: const EdgeInsets.all(AppSizes.md),        // 16px
  margin: const EdgeInsets.symmetric(vertical: AppSizes.sm), // 8px
  child: Column(
    children: [
      const SizedBox(height: AppSizes.lg),           // 24px
      _buildContent(),
    ],
  ),
)

// 2. 일관된 간격 사용
Row(
  children: [
    Expanded(child: _buildLeftWidget()),
    const SizedBox(width: AppSizes.sm),              // 8px
    Expanded(child: _buildRightWidget()),
  ],
)

// 3. 반응형 크기 사용
Container(
  width: MediaQuery.of(context).size.width * 0.8,    // 화면 너비의 80%
  height: 200,                                       // 고정 높이
  child: _buildContent(),
)
```

#### 🔤 타이포그래피 규칙
```dart
// 1. AppTextStyles 상수만 사용
Text(
  '제목 텍스트',
  style: AppTextStyles.cardTitle,                    // ✅ 좋음
  // style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold), // ❌ 나쁨
)

// 2. 텍스트 스타일 조합
Text(
  '설명 텍스트',
  style: AppTextStyles.cardDescription.copyWith(
    fontSize: 14,
    color: AppColors.textSecondary,
    height: 1.4,                                     // 줄 간격
  ),
)

// 3. 텍스트 오버플로우 처리
Text(
  '긴 텍스트가 들어갈 수 있는 내용입니다...',
  style: AppTextStyles.cardDescription,
  maxLines: 2,
  overflow: TextOverflow.ellipsis,
)
```

### 6. 성능 최적화 규칙

#### ⚡ 위젯 최적화
```dart
// 1. const 생성자 사용
const Text(
  '고정 텍스트',
  style: AppTextStyles.cardTitle,
)

// 2. ListView.builder 사용 (많은 아이템)
ListView.builder(
  itemCount: items.length,
  itemBuilder: (context, index) {
    return _buildItem(items[index]);
  },
)

// 3. 불필요한 리빌드 방지
class _OptimizedWidget extends StatefulWidget {
  @override
  State<_OptimizedWidget> createState() => _OptimizedWidgetState();
}

class _OptimizedWidgetState extends State<_OptimizedWidget> {
  @override
  Widget build(BuildContext context) {
    // build 메서드에서 무거운 연산 피하기
    return _buildContent();
  }
  
  Widget _buildContent() {
    // 실제 UI 구성
    return Container();
  }
}
```

#### 🖼️ 이미지 최적화
```dart
// 1. 적절한 이미지 크기 사용
Container(
  width: 100,
  height: 100,
  child: Image.asset(
    'assets/images/avatar.png',
    fit: BoxFit.cover,                               // 적절한 fit 사용
    cacheWidth: 200,                                 // 캐시 크기 지정
    cacheHeight: 200,
  ),
)

// 2. 네트워크 이미지 캐싱
Image.network(
  imageUrl,
  loadingBuilder: (context, child, loadingProgress) {
    if (loadingProgress == null) return child;
    return CircularProgressIndicator(
      value: loadingProgress.expectedTotalBytes != null
          ? loadingProgress.cumulativeBytesLoaded / 
            loadingProgress.expectedTotalBytes!
          : null,
    );
  },
  errorBuilder: (context, error, stackTrace) {
    return Icon(Icons.error);
  },
)
```

### 7. 에러 처리 규칙

#### 🚨 에러 처리 패턴
```dart
// 1. try-catch 사용
Future<void> _loadData() async {
  try {
    setState(() => _isLoading = true);
    final data = await ApiService.getData();
    setState(() {
      _data = data;
      _isLoading = false;
    });
  } on NetworkException catch (e) {
    _showErrorDialog('네트워크 오류: ${e.message}');
  } on ValidationException catch (e) {
    _showErrorDialog('입력 오류: ${e.message}');
  } catch (e) {
    _showErrorDialog('알 수 없는 오류가 발생했습니다.');
  } finally {
    setState(() => _isLoading = false);
  }
}

// 2. 사용자 친화적 에러 메시지
void _showErrorDialog(String message) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('오류'),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('확인'),
        ),
      ],
    ),
  );
}
```

### 8. 테스트 작성 규칙

#### 🧪 위젯 테스트
```dart
// 1. 테스트 파일 구조
void main() {
  group('CustomerHomeScreen', () {
    testWidgets('should display service categories', (tester) async {
      // Given
      await tester.pumpWidget(MaterialApp(
        home: CustomerHomeScreen(),
      ));
      
      // When
      await tester.pumpAndSettle();
      
      // Then
      expect(find.text('배관'), findsOneWidget);
      expect(find.text('전기'), findsOneWidget);
    });
    
    testWidgets('should navigate to AI request screen', (tester) async {
      // Given
      await tester.pumpWidget(MaterialApp(
        home: CustomerHomeScreen(),
      ));
      
      // When
      await tester.tap(find.text('AI 스마트 매칭'));
      await tester.pumpAndSettle();
      
      // Then
      expect(find.byType(AIRequestScreen), findsOneWidget);
    });
  });
}
```

### 9. Git 커밋 규칙

#### 📝 커밋 메시지 규칙
```bash
# 형식: [타입] [범위]: [설명]

# 기능 추가
feat(auth): add email validation to signup form
feat(ui): implement AI request screen with photo upload

# 버그 수정
fix(ui): resolve pixel overflow in service categories
fix(auth): fix password confirmation validation

# UI 개선
style(ui): update button design to match Soomgo style
style(ui): improve dropdown UI with bottom sheet

# 리팩토링
refactor(ui): extract common dropdown widget
refactor(auth): simplify password validation logic

# 문서 업데이트
docs(readme): add comprehensive development guidelines
docs(api): update API documentation

# 테스트
test(ui): add widget tests for customer home screen
test(auth): add unit tests for signup form validation
```

### 10. 코드 리뷰 체크리스트

#### ✅ 코드 리뷰 체크사항
- [ ] **네이밍**: 변수명과 함수명이 명확한가?
- [ ] **구조**: 위젯이 단일 책임을 가지는가?
- [ ] **재사용성**: 공통 컴포넌트로 분리할 수 있는가?
- [ ] **성능**: 불필요한 리빌드가 없는가?
- [ ] **에러 처리**: 적절한 에러 처리가 있는가?
- [ ] **테스트**: 테스트 코드가 작성되었는가?
- [ ] **문서**: 주석과 문서가 충분한가?
- [ ] **일관성**: 프로젝트 스타일과 일치하는가?

## 🔧 주요 기술 스택

### 프론트엔드
- **Flutter**: 크로스 플랫폼 UI 프레임워크
- **Dart**: 프로그래밍 언어
- **Material Design**: UI 디자인 시스템

### 상태 관리
- **StatefulWidget**: 로컬 상태 관리
- **TextEditingController**: 폼 입력 관리
- **setState**: UI 업데이트

### UI/UX
- **커스텀 폰트**: Gasoek One, Pretendard
- **반응형 디자인**: 다양한 화면 크기 대응
- **애니메이션**: 부드러운 전환 효과
- **그라데이션**: 시각적 깊이감 표현

### AI 통합 (계획)
- **LLM (Large Language Model)**: 텍스트 분석 및 매칭
- **VLM (Vision Language Model)**: 이미지 분석 및 진단
- **스마트 매칭**: AI 기반 수리기사 추천

## 📱 지원 플랫폼

- **Android**: API 21 (Android 5.0) 이상
- **iOS**: iOS 11.0 이상
- **웹**: Chrome, Safari, Firefox (계획)
- **데스크톱**: Windows, macOS, Linux (계획)

## 🧪 테스트

### 단위 테스트
```bash
# 모든 테스트 실행
flutter test

# 특정 테스트 파일 실행
flutter test test/widget_test.dart

# 커버리지 리포트 생성
flutter test --coverage
```

### 위젯 테스트
- 각 화면의 주요 기능 테스트
- 사용자 상호작용 시나리오 테스트
- 폼 유효성 검사 테스트

## 🚀 배포

### Android 배포
```bash
# APK 빌드
flutter build apk --release

# App Bundle 빌드 (Google Play Store)
flutter build appbundle --release
```

### iOS 배포
```bash
# iOS 빌드
flutter build ios --release

# Xcode에서 아카이브 및 업로드
```

## 📈 성능 최적화

### 이미지 최적화
- **적절한 해상도**: 화면 크기에 맞는 이미지 사용
- **캐싱**: 자주 사용되는 이미지 캐싱
- **지연 로딩**: 필요할 때만 이미지 로드

### 메모리 관리
- **Controller 해제**: `dispose()` 메서드에서 적절한 해제
- **위젯 최적화**: 불필요한 리빌드 방지
- **상태 관리**: 효율적인 상태 업데이트

## 🔮 향후 개발 계획

### 단기 목표 (1-2개월)
- [ ] **수리기사 앱**: 수리기사용 전용 앱 개발
- [ ] **실시간 채팅**: 고객-수리기사 간 실시간 소통
- [ ] **푸시 알림**: 견적 도착, 채팅 메시지 알림
- [ ] **결제 시스템**: 안전한 결제 처리

### 중기 목표 (3-6개월)
- [ ] **AI 모델 통합**: 실제 LLM/VLM 모델 연동
- [ ] **리뷰 시스템**: 수리기사 평가 및 리뷰
- [ ] **예약 시스템**: 시간대별 수리 예약
- [ ] **지도 통합**: 위치 기반 수리기사 검색

### 장기 목표 (6개월+)
- [ ] **다국어 지원**: 영어, 중국어 등
- [ ] **AR 기능**: AR을 통한 수리 가이드
- [ ] **IoT 연동**: 스마트홈 기기 연동
- [ ] **블록체인**: 투명한 거래 기록 관리

## 🤝 기여 방법

### 개발 참여
1. **이슈 확인**: 기존 이슈 검토 또는 새 이슈 생성
2. **브랜치 생성**: `feature/기능명` 또는 `fix/버그명` 형식
3. **개발 진행**: 코딩 스타일 가이드 준수
4. **테스트**: 충분한 테스트 후 커밋
5. **Pull Request**: 상세한 설명과 함께 PR 생성

### 코드 리뷰
- **명확한 설명**: 변경 사항과 이유를 명확히 기술
- **테스트 결과**: 테스트 케이스와 결과 포함
- **스크린샷**: UI 변경 시 Before/After 이미지

### 버그 리포트
- **재현 단계**: 버그 재현을 위한 상세한 단계
- **환경 정보**: OS, Flutter 버전, 디바이스 정보
- **로그**: 에러 로그 및 스크린샷

## 📄 라이선스

이 프로젝트는 **MIT 라이선스** 하에 배포됩니다.

```
MIT License

Copyright (c) 2024 수리모아

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

## 📞 연락처 및 지원

### 프로젝트 관련 문의
- **이슈 트래커**: GitHub Issues를 통한 버그 리포트 및 기능 요청
- **토론**: GitHub Discussions를 통한 일반적인 질문 및 아이디어 공유
- **이메일**: [프로젝트 이메일]

### 개발자 정보
- **메인 개발자**: [개발자명]
- **기여자**: [기여자 목록]

### 커뮤니티
- **Discord**: [Discord 서버 링크]
- **Slack**: [Slack 워크스페이스 링크]
- **공식 웹사이트**: [웹사이트 링크]

---

## 📚 추가 문서

- [API 문서](./docs/api.md)
- [디자인 가이드](./docs/design-guide.md)
- [배포 가이드](./docs/deployment.md)
- [기여 가이드](./docs/contributing.md)
- [변경 로그](./CHANGELOG.md)

---

**수리모아**와 함께 더 나은 수리 서비스를 만들어가세요! 🛠️✨