#!/usr/bin/env python3
"""
SURI API 서버에 전문분야 데이터를 추가하는 스크립트
"""

import requests
import json

# API 기본 URL
BASE_URL = "http://localhost:8000"

# 전문분야 데이터 (API 가이드의 ID 매핑에 따라)
specialties = [
    # 1. 설비·수리 분야 - 수도·배관
    {"name": "누수 탐지 및 수리", "description": "누수 탐지, 파이프 누수, 벽체 누수, 방수 작업", "category": "수도·배관", "is_active": True},
    {"name": "배관 교체/설치", "description": "상하수도 배관, 급수관, 배수관 교체 및 신규 설치", "category": "수도·배관", "is_active": True},
    {"name": "하수구 막힘·배수 문제", "description": "하수구 막힘, 배관 청소, 역류 방지, 배수 시설 수리", "category": "수도·배관", "is_active": True},
    {"name": "변기 수리", "description": "변기 막힘, 물탱크 수리, 교체 작업", "category": "수도·배관", "is_active": True},
    {"name": "싱크대 수리", "description": "싱크대 배수구 막힘, 수도꼭지 교체, 배수관 수리", "category": "수도·배관", "is_active": True},
    {"name": "샤워기·욕실 수리", "description": "샤워기 수압 조절, 헤드 교체, 욕조 배수 문제, 실리콘 보수", "category": "수도·배관", "is_active": True},
    
    # 1. 설비·수리 분야 - 보일러·난방
    {"name": "가정용 보일러 설치·수리", "description": "가정용 보일러 설치, 수리, 온도 조절, 가스 점검", "category": "보일러·난방", "is_active": True},
    {"name": "산업용 보일러 설치·수리", "description": "산업용 대형 보일러 설치, 점검, 유지보수", "category": "보일러·난방", "is_active": True},
    {"name": "온수기 교체·수리", "description": "온수기 수리, 교체, 온도 조절, 안전장치 점검", "category": "보일러·난방", "is_active": True},
    {"name": "난방 배관·라디에이터 수리", "description": "바닥난방 수리, 라디에이터 점검, 온도 조절, 난방 배관 수리", "category": "보일러·난방", "is_active": True},
    
    # 1. 설비·수리 분야 - 가스 설비
    {"name": "가스 배관 점검·수리", "description": "가스 배관 설치, 점검, 수리, 안전 검사", "category": "가스 설비", "is_active": True},
    {"name": "가스 누출 탐지", "description": "가스 누출 검사, 탐지, 긴급 조치", "category": "가스 설비", "is_active": True},
    {"name": "가스 기기 설치", "description": "가스레인지, 가스보일러, 가스온수기 설치 및 연결", "category": "가스 설비", "is_active": True},
    
    # 1. 설비·수리 분야 - 전기 설비
    {"name": "배선 교체/추가", "description": "전기 배선 설치, 교체, 추가 배선 작업", "category": "전기 설비", "is_active": True},
    {"name": "콘센트·스위치·차단기 수리", "description": "콘센트 교체, 스위치 수리, 차단기 점검 및 교체", "category": "전기 설비", "is_active": True},
    {"name": "조명 설치 및 전기 인테리어", "description": "조명 설치, LED 교체, 전기 인테리어 시공", "category": "전기 설비", "is_active": True},
    {"name": "누전·정전 긴급 복구", "description": "누전 점검, 정전 복구, 전기 안전 점검", "category": "전기 설비", "is_active": True},
    {"name": "분전반 점검", "description": "분전반 점검, 안전 점검, 전기 용량 확인", "category": "전기 설비", "is_active": True},
    
    # 1. 설비·수리 분야 - 기계·가전
    {"name": "냉장고 수리", "description": "냉장고 수리, 압축기 교체, 냉매 충전, 온도 조절", "category": "기계·가전", "is_active": True},
    {"name": "세탁기 수리", "description": "세탁기 수리, 부품 교체, 배수 문제 해결", "category": "기계·가전", "is_active": True},
    {"name": "에어컨 수리", "description": "에어컨 설치, 수리, 청소, 가스 충전, 필터 교체", "category": "기계·가전", "is_active": True},
    {"name": "청소기 수리", "description": "청소기 수리, 부품 교체, 성능 개선", "category": "기계·가전", "is_active": True},
    {"name": "기타 가전 수리", "description": "TV, 전자레인지, 오븐, 식기세척기 등 가전제품 수리", "category": "기계·가전", "is_active": True},
    {"name": "산업용 기계 점검 및 수리", "description": "공장 기계, 생산 설비, 산업용 장비 점검 및 수리", "category": "기계·가전", "is_active": True},
    {"name": "엘리베이터·에스컬레이터 점검", "description": "승강기 유지보수, 안전 점검, 부품 교체", "category": "기계·가전", "is_active": True},
]

def add_specialties():
    """전문분야 데이터를 서버에 추가"""
    print(f"전문분야 {len(specialties)}개를 서버에 추가합니다...")
    
    success_count = 0
    error_count = 0
    
    for i, specialty in enumerate(specialties, 1):
        try:
            response = requests.post(
                f"{BASE_URL}/api/v1/specialties/",
                json=specialty,
                headers={"Content-Type": "application/json"}
            )
            
            if response.status_code == 201:
                result = response.json()
                print(f"✅ {i:2d}. {specialty['name']} (ID: {result.get('id', 'N/A')})")
                success_count += 1
            else:
                print(f"❌ {i:2d}. {specialty['name']} - 오류: {response.status_code} - {response.text}")
                error_count += 1
                
        except Exception as e:
            print(f"❌ {i:2d}. {specialty['name']} - 예외: {e}")
            error_count += 1
    
    print(f"\n완료: 성공 {success_count}개, 실패 {error_count}개")

def verify_specialties():
    """추가된 전문분야 확인"""
    try:
        response = requests.get(f"{BASE_URL}/api/v1/specialties/")
        if response.status_code == 200:
            specialties = response.json()
            print(f"\n서버에 등록된 전문분야: {len(specialties)}개")
            for specialty in specialties:
                print(f"  ID: {specialty['id']}, 이름: {specialty['name']}, 카테고리: {specialty['category']}")
        else:
            print(f"전문분야 조회 실패: {response.status_code}")
    except Exception as e:
        print(f"전문분야 조회 중 오류: {e}")

if __name__ == "__main__":
    print("SURI API 전문분야 데이터 추가 스크립트")
    print("=" * 50)
    
    # 전문분야 추가
    add_specialties()
    
    # 결과 확인
    verify_specialties()

