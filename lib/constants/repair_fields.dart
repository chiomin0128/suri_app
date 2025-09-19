/// 수리 분야 모델
class RepairField {
  final int id;
  final String name;
  final String description;
  final String icon;

  const RepairField({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
  });
}

/// 대분류 모델
class RepairCategory {
  final String id;
  final String name;
  final String icon;
  final List<RepairSubCategory> subCategories;

  const RepairCategory({
    required this.id,
    required this.name,
    required this.icon,
    required this.subCategories,
  });
}

/// 중분류 모델
class RepairSubCategory {
  final String id;
  final String name;
  final List<RepairField> fields;

  const RepairSubCategory({
    required this.id,
    required this.name,
    required this.fields,
  });
}

/// 수리 가능한 분야 목록 (계층 구조)
class RepairFields {
  static const List<RepairCategory> categories = [
    // 1. 설비·수리 분야
    RepairCategory(
      id: 'facility_repair',
      name: '설비·수리',
      icon: '🔧',
      subCategories: [
        RepairSubCategory(
          id: 'water_plumbing',
          name: '수도·배관',
          fields: [
            RepairField(
              id: 1,
              name: '누수 탐지 및 수리',
              description: '누수 탐지, 파이프 누수, 벽체 누수, 방수 작업',
              icon: '💧',
            ),
            RepairField(
              id: 2,
              name: '배관 교체/설치',
              description: '상하수도 배관, 급수관, 배수관 교체 및 신규 설치',
              icon: '🔧',
            ),
            RepairField(
              id: 3,
              name: '하수구 막힘·배수 문제',
              description: '하수구 막힘, 배관 청소, 역류 방지, 배수 시설 수리',
              icon: '🚰',
            ),
            RepairField(
              id: 4,
              name: '변기 수리',
              description: '변기 막힘, 물탱크 수리, 교체 작업',
              icon: '🚽',
            ),
            RepairField(
              id: 5,
              name: '싱크대 수리',
              description: '싱크대 배수구 막힘, 수도꼭지 교체, 배수관 수리',
              icon: '🍽️',
            ),
            RepairField(
              id: 6,
              name: '샤워기·욕실 수리',
              description: '샤워기 수압 조절, 헤드 교체, 욕조 배수 문제, 실리콘 보수',
              icon: '🛁',
            ),
          ],
        ),
        RepairSubCategory(
          id: 'boiler_heating',
          name: '보일러·난방',
          fields: [
            RepairField(
              id: 7,
              name: '가정용 보일러 설치·수리',
              description: '가정용 보일러 설치, 수리, 온도 조절, 가스 점검',
              icon: '🔥',
            ),
            RepairField(
              id: 8,
              name: '산업용 보일러 설치·수리',
              description: '산업용 대형 보일러 설치, 점검, 유지보수',
              icon: '🏭',
            ),
            RepairField(
              id: 9,
              name: '온수기 교체·수리',
              description: '온수기 수리, 교체, 온도 조절, 안전장치 점검',
              icon: '🌡️',
            ),
            RepairField(
              id: 10,
              name: '난방 배관·라디에이터 수리',
              description: '바닥난방 수리, 라디에이터 점검, 온도 조절, 난방 배관 수리',
              icon: '🏠',
            ),
          ],
        ),
        RepairSubCategory(
          id: 'gas_equipment',
          name: '가스 설비',
          fields: [
            RepairField(
              id: 11,
              name: '가스 배관 점검·수리',
              description: '가스 배관 설치, 점검, 수리, 안전 검사',
              icon: '⛽',
            ),
            RepairField(
              id: 12,
              name: '가스 누출 탐지',
              description: '가스 누출 검사, 탐지, 긴급 조치',
              icon: '⚠️',
            ),
            RepairField(
              id: 13,
              name: '가스 기기 설치',
              description: '가스레인지, 가스보일러, 가스온수기 설치 및 연결',
              icon: '🔥',
            ),
          ],
        ),
        RepairSubCategory(
          id: 'electrical_equipment',
          name: '전기 설비',
          fields: [
            RepairField(
              id: 14,
              name: '배선 교체/추가',
              description: '전기 배선 설치, 교체, 추가 배선 작업',
              icon: '⚡',
            ),
            RepairField(
              id: 15,
              name: '콘센트·스위치·차단기 수리',
              description: '콘센트 교체, 스위치 수리, 차단기 점검 및 교체',
              icon: '🔌',
            ),
            RepairField(
              id: 16,
              name: '조명 설치 및 전기 인테리어',
              description: '조명 설치, LED 교체, 전기 인테리어 시공',
              icon: '💡',
            ),
            RepairField(
              id: 17,
              name: '누전·정전 긴급 복구',
              description: '누전 점검, 정전 복구, 전기 안전 점검',
              icon: '🚨',
            ),
            RepairField(
              id: 18,
              name: '분전반 점검',
              description: '분전반 점검, 안전 점검, 전기 용량 확인',
              icon: '🔋',
            ),
          ],
        ),
        RepairSubCategory(
          id: 'appliance_machinery',
          name: '기계·가전',
          fields: [
            RepairField(
              id: 19,
              name: '냉장고 수리',
              description: '냉장고 수리, 압축기 교체, 냉매 충전, 온도 조절',
              icon: '❄️',
            ),
            RepairField(
              id: 20,
              name: '세탁기 수리',
              description: '세탁기 수리, 부품 교체, 배수 문제 해결',
              icon: '🧺',
            ),
            RepairField(
              id: 21,
              name: '에어컨 수리',
              description: '에어컨 설치, 수리, 청소, 가스 충전, 필터 교체',
              icon: '❄️',
            ),
            RepairField(
              id: 22,
              name: '청소기 수리',
              description: '청소기 수리, 부품 교체, 성능 개선',
              icon: '🧹',
            ),
            RepairField(
              id: 23,
              name: '기타 가전 수리',
              description: 'TV, 전자레인지, 오븐, 식기세척기 등 가전제품 수리',
              icon: '📺',
            ),
            RepairField(
              id: 24,
              name: '산업용 기계 점검 및 수리',
              description: '공장 기계, 생산 설비, 산업용 장비 점검 및 수리',
              icon: '🏭',
            ),
            RepairField(
              id: 25,
              name: '엘리베이터·에스컬레이터 점검',
              description: '승강기 유지보수, 안전 점검, 부품 교체',
              icon: '🛗',
            ),
          ],
        ),
      ],
    ),

    // 2. 인테리어·리모델링 분야
    RepairCategory(
      id: 'interior_remodeling',
      name: '인테리어·리모델링',
      icon: '🏠',
      subCategories: [
        RepairSubCategory(
          id: 'interior_construction',
          name: '내부 시공',
          fields: [
            RepairField(
              id: 26,
              name: '도배·장판',
              description: '도배지 시공, 장판·마루 설치, 벽지 교체',
              icon: '🏠',
            ),
            RepairField(
              id: 27,
              name: '타일 시공',
              description: '욕실 타일, 주방 타일, 바닥 타일 시공 및 보수',
              icon: '🔲',
            ),
            RepairField(
              id: 28,
              name: '목공 (가구 맞춤 제작·설치)',
              description: '맞춤 가구 제작, 붙박이장, 목재 인테리어',
              icon: '🪑',
            ),
            RepairField(
              id: 29,
              name: '주방·욕실 리모델링',
              description: '주방 리모델링, 욕실 리모델링, 타일 및 설비 교체',
              icon: '🍳',
            ),
            RepairField(
              id: 30,
              name: '방음·단열 시공',
              description: '방음재 설치, 단열재 시공, 소음 차단',
              icon: '🔇',
            ),
          ],
        ),
        RepairSubCategory(
          id: 'exterior_construction',
          name: '외부 시공',
          fields: [
            RepairField(
              id: 31,
              name: '외벽 도장·보수',
              description: '외벽 페인트, 외벽 보수, 균열 수리',
              icon: '🎨',
            ),
            RepairField(
              id: 32,
              name: '옥상·방수 공사',
              description: '옥상 방수, 지하 방수, 누수 방지 공사',
              icon: '🏠',
            ),
            RepairField(
              id: 33,
              name: '창호(문·창문) 교체',
              description: '문 교체, 창문 교체, 방충망 설치',
              icon: '🚪',
            ),
            RepairField(
              id: 34,
              name: '발코니 확장',
              description: '발코니 확장 공사, 샷시 설치',
              icon: '🏠',
            ),
          ],
        ),
        RepairSubCategory(
          id: 'comprehensive_remodeling',
          name: '종합 리모델링',
          fields: [
            RepairField(
              id: 35,
              name: '아파트·주택 올리모델링',
              description: '전체 주거공간 리모델링, 구조 변경',
              icon: '🏠',
            ),
            RepairField(
              id: 36,
              name: '상가·사무실 인테리어',
              description: '상업공간 인테리어, 사무실 인테리어',
              icon: '🏢',
            ),
            RepairField(
              id: 37,
              name: '상업공간 디자인 시공',
              description: '카페, 식당, 매장 인테리어 디자인 및 시공',
              icon: '☕',
            ),
          ],
        ),
      ],
    ),

    // 3. 긴급 출동 서비스
    RepairCategory(
      id: 'emergency_service',
      name: '긴급 출동',
      icon: '🚨',
      subCategories: [
        RepairSubCategory(
          id: 'emergency_repair',
          name: '24시간 긴급 수리',
          fields: [
            RepairField(
              id: 38,
              name: '누수 긴급 출동',
              description: '24시간 누수 긴급 수리, 응급 조치',
              icon: '🚨',
            ),
            RepairField(
              id: 39,
              name: '정전 긴급 출동',
              description: '24시간 정전 복구, 전기 응급 수리',
              icon: '⚡',
            ),
            RepairField(
              id: 40,
              name: '보일러 고장 긴급 출동',
              description: '24시간 보일러 응급 수리, 난방 복구',
              icon: '🔥',
            ),
            RepairField(
              id: 41,
              name: '하수구 역류 긴급 출동',
              description: '하수구 역류 응급 처리, 배수 복구',
              icon: '🚰',
            ),
            RepairField(
              id: 42,
              name: '가스 누출 긴급 출동',
              description: '가스 누출 응급 처리, 안전 조치',
              icon: '⚠️',
            ),
          ],
        ),
        RepairSubCategory(
          id: 'emergency_response',
          name: '응급 조치',
          fields: [
            RepairField(
              id: 43,
              name: '배관 파손 긴급 교체',
              description: '파손된 배관 응급 교체, 임시 수리',
              icon: '🔧',
            ),
            RepairField(
              id: 44,
              name: '화재 후 전기 복구',
              description: '화재 후 전기 시설 복구, 안전 점검',
              icon: '🔥',
            ),
            RepairField(
              id: 45,
              name: '빌딩·매장 긴급 전력 복구',
              description: '상업시설 전력 복구, 응급 전기 수리',
              icon: '🏢',
            ),
          ],
        ),
      ],
    ),

    // 4. 건물·시설 유지보수 (B2B)
    RepairCategory(
      id: 'building_maintenance',
      name: '건물·시설 유지보수',
      icon: '🏢',
      subCategories: [
        RepairSubCategory(
          id: 'building_management',
          name: '건물 관리',
          fields: [
            RepairField(
              id: 46,
              name: '빌딩 설비 점검',
              description: '빌딩 전체 설비 정기 점검, 유지보수',
              icon: '🏢',
            ),
            RepairField(
              id: 47,
              name: '소방시설 점검',
              description: '소방 설비 점검, 안전 시설 관리',
              icon: '🚨',
            ),
            RepairField(
              id: 48,
              name: '정기 안전 점검',
              description: '건물 안전 점검, 시설물 안전 관리',
              icon: '🔍',
            ),
          ],
        ),
        RepairSubCategory(
          id: 'industrial_facilities',
          name: '산업 시설',
          fields: [
            RepairField(
              id: 49,
              name: '스마트팩토리 설비 유지보수',
              description: '스마트팩토리 설비 관리, 자동화 시설 점검',
              icon: '🏭',
            ),
            RepairField(
              id: 50,
              name: '공장 기계·전기 점검',
              description: '공장 생산 설비, 전기 시설 정기 점검',
              icon: '⚙️',
            ),
          ],
        ),
        RepairSubCategory(
          id: 'commercial_facilities',
          name: '상업 시설',
          fields: [
            RepairField(
              id: 51,
              name: '매장·프랜차이즈 정기 유지보수',
              description: '상업시설 정기 점검, 매장 설비 관리',
              icon: '🏪',
            ),
            RepairField(
              id: 52,
              name: '공공기관·지자체 건물 관리',
              description: '공공건물 유지보수, 관공서 시설 관리',
              icon: '🏛️',
            ),
          ],
        ),
        RepairSubCategory(
          id: 'environmental_equipment',
          name: '환경·설비',
          fields: [
            RepairField(
              id: 53,
              name: '냉난방 공조(HVAC)',
              description: 'HVAC 시스템 설치, 점검, 유지보수',
              icon: '🌡️',
            ),
            RepairField(
              id: 54,
              name: '승강기 유지보수',
              description: '엘리베이터, 에스컬레이터 정기 점검 및 수리',
              icon: '🛗',
            ),
            RepairField(
              id: 55,
              name: '에너지 효율 개선 공사',
              description: '건물 에너지 효율 개선, 절약 시설 설치',
              icon: '💡',
            ),
          ],
        ),
      ],
    ),

    // 5. 부가 서비스
    RepairCategory(
      id: 'additional_services',
      name: '부가 서비스',
      icon: '✨',
      subCategories: [
        RepairSubCategory(
          id: 'cleaning_services',
          name: '청소 서비스',
          fields: [
            RepairField(
              id: 56,
              name: '입주 청소',
              description: '새 집 입주 전 청소, 이사 후 청소',
              icon: '🧹',
            ),
            RepairField(
              id: 57,
              name: '리모델링 후 청소',
              description: '공사 후 청소, 건축 폐기물 정리',
              icon: '🏠',
            ),
            RepairField(
              id: 58,
              name: '빌딩 관리 청소',
              description: '상업시설 정기 청소, 사무실 청소',
              icon: '🏢',
            ),
            RepairField(
              id: 59,
              name: '전문 장비 청소',
              description: '에어컨 청소, 배관 청소, 산업용 청소',
              icon: '🔧',
            ),
          ],
        ),
        RepairSubCategory(
          id: 'demolition_waste',
          name: '철거·폐기물',
          fields: [
            RepairField(
              id: 60,
              name: '인테리어 철거',
              description: '기존 인테리어 철거, 구조물 해체',
              icon: '🔨',
            ),
            RepairField(
              id: 61,
              name: '가구·가전 폐기',
              description: '대형 폐기물 처리, 가전제품 폐기',
              icon: '🗑️',
            ),
          ],
        ),
        RepairSubCategory(
          id: 'special_construction',
          name: '특수 시공',
          fields: [
            RepairField(
              id: 62,
              name: '곰팡이 제거',
              description: '곰팡이 제거, 습기 제거, 방균 처리',
              icon: '🦠',
            ),
            RepairField(
              id: 63,
              name: '방충·방역',
              description: '해충 방제, 방역 서비스, 소독',
              icon: '🐛',
            ),
            RepairField(
              id: 64,
              name: '단열필름·차열필름 시공',
              description: '창문 필름 시공, 단열 개선, 차열 처리',
              icon: '🪟',
            ),
          ],
        ),
      ],
    ),
  ];

  /// 모든 수리 분야를 평면 리스트로 반환 (기존 호환성 유지)
  static List<RepairField> get allFields {
    List<RepairField> fields = [];
    for (var category in categories) {
      for (var subCategory in category.subCategories) {
        fields.addAll(subCategory.fields);
      }
    }
    return fields;
  }

  /// ID로 수리 분야 찾기
  static RepairField? findById(int id) {
    try {
      return allFields.firstWhere((field) => field.id == id);
    } catch (e) {
      return null;
    }
  }

  /// 이름으로 수리 분야 찾기
  static RepairField? findByName(String name) {
    try {
      return allFields.firstWhere((field) => field.name == name);
    } catch (e) {
      return null;
    }
  }

  /// 카테고리 ID로 찾기
  static RepairCategory? findCategoryById(String id) {
    try {
      return categories.firstWhere((category) => category.id == id);
    } catch (e) {
      return null;
    }
  }

  /// 중분류 ID로 찾기
  static RepairSubCategory? findSubCategoryById(String id) {
    for (var category in categories) {
      try {
        return category.subCategories.firstWhere(
          (subCategory) => subCategory.id == id,
        );
      } catch (e) {
        continue;
      }
    }
    return null;
  }
}
