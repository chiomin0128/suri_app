import 'package:flutter/material.dart';

/// 사용자 타입을 정의하는 열거형
enum UserType {
  customer('고객으로 시작', '원하는 수리 서비스를 쉽고 빠르게 받을 수 있어요'),
  technician('수리기사로 시작', '고객을 만나고 수익을 창출할 수 있어요');

  const UserType(this.title, this.description);

  final String title;
  final String description;

  /// 사용자 타입에 따른 아이콘을 반환
  IconData get icon {
    switch (this) {
      case UserType.customer:
        return Icons.person;
      case UserType.technician:
        return Icons.build;
    }
  }
}
