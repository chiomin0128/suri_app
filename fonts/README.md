# 폰트 파일 설치 가이드

이 디렉토리에 다음 폰트 파일들을 다운로드하여 저장해야 합니다:

## 필요한 폰트 파일

### 1. Gasoek One
- **파일명**: `GasoekOne-Regular.ttf`
- **다운로드**: [Google Fonts - Gasoek One](https://fonts.google.com/specimen/Gasoek+One)
- **용도**: 로고 텍스트

### 2. Pretendard
- **파일명**: 
  - `Pretendard-Regular.otf`
  - `Pretendard-Medium.otf`
  - `Pretendard-SemiBold.otf`
  - `Pretendard-Bold.otf`
- **다운로드**: [Pretendard GitHub](https://github.com/orioncactus/pretendard)
- **용도**: 제목, 부제목, 카드 텍스트

## 설치 방법

1. 위 링크에서 폰트 파일들을 다운로드
2. 이 `fonts/` 디렉토리에 저장
3. `flutter pub get` 실행하여 앱 재시작

## 폰트 적용 확인

폰트가 제대로 적용되었는지 확인하려면:
1. 앱을 실행
2. 로고 텍스트가 Gasoek One 폰트로 표시되는지 확인
3. 다른 텍스트들이 Pretendard 폰트로 표시되는지 확인

## 문제 해결

폰트가 적용되지 않는 경우:
1. 파일명이 정확한지 확인
2. `pubspec.yaml`의 폰트 설정이 올바른지 확인
3. 앱을 완전히 재시작 (hot restart가 아닌 완전 재시작)
