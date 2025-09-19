import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_sizes.dart';
import '../../constants/app_text_styles.dart';
import '../../constants/repair_fields.dart';

/// 수리 분야 선택 위젯 (계층 구조)
class RepairFieldsSelector extends StatefulWidget {
  const RepairFieldsSelector({
    super.key,
    required this.selectedSpecialtyIds,
    required this.onSpecialtyIdsChanged,
  });

  final List<int> selectedSpecialtyIds;
  final Function(List<int>) onSpecialtyIdsChanged;

  @override
  State<RepairFieldsSelector> createState() => _RepairFieldsSelectorState();
}

class _RepairFieldsSelectorState extends State<RepairFieldsSelector> {
  late List<int> _selectedSpecialtyIds;
  String? _selectedCategoryId;
  String? _selectedSubCategoryId;
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _selectedSpecialtyIds = List.from(widget.selectedSpecialtyIds);
  }

  @override
  void didUpdateWidget(RepairFieldsSelector oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedSpecialtyIds != oldWidget.selectedSpecialtyIds) {
      _selectedSpecialtyIds = List.from(widget.selectedSpecialtyIds);
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  /// 분야 선택/해제
  void _toggleField(int fieldId) {
    setState(() {
      if (_selectedSpecialtyIds.contains(fieldId)) {
        _selectedSpecialtyIds.remove(fieldId);
      } else {
        _selectedSpecialtyIds.add(fieldId);
      }
    });
    widget.onSpecialtyIdsChanged(_selectedSpecialtyIds);
  }

  /// 검색 결과 필터링
  List<RepairField> _getFilteredFields() {
    if (_searchQuery.isEmpty) {
      if (_selectedCategoryId == null) return [];

      final category = RepairFields.findCategoryById(_selectedCategoryId!);
      if (category == null) return [];

      if (_selectedSubCategoryId == null) {
        // 대분류만 선택된 경우, 모든 중분류의 필드들을 반환
        List<RepairField> allFields = [];
        for (var subCategory in category.subCategories) {
          allFields.addAll(subCategory.fields);
        }
        return allFields;
      } else {
        // 중분류가 선택된 경우, 해당 중분류의 필드들만 반환
        final subCategory = RepairFields.findSubCategoryById(
          _selectedSubCategoryId!,
        );
        return subCategory?.fields ?? [];
      }
    } else {
      // 검색어가 있는 경우, 모든 필드에서 검색
      return RepairFields.allFields
          .where(
            (field) =>
                field.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
                field.description.toLowerCase().contains(
                  _searchQuery.toLowerCase(),
                ),
          )
          .toList();
    }
  }

  /// 검색어 변경
  void _onSearchChanged(String query) {
    setState(() {
      _searchQuery = query;
      if (query.isNotEmpty) {
        _selectedCategoryId = null;
        _selectedSubCategoryId = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 제목
        Text(
          '수리 가능한 분야',
          style: AppTextStyles.cardTitle.copyWith(
            fontSize: 14,
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: AppSizes.sm),

        // 안내 메시지
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: AppColors.primary.withValues(alpha: 0.1),
              width: 1,
            ),
          ),
          child: Row(
            children: [
              Icon(Icons.info_outline, size: 16, color: AppColors.primary),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  '수리 가능한 분야를 선택해주세요 (최소 1개 이상)',
                  style: AppTextStyles.cardDescription.copyWith(
                    fontSize: 13,
                    color: AppColors.primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSizes.md),

        // 검색창
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSizes.cardBorderRadius),
            border: Border.all(
              color: AppColors.textSecondary.withValues(alpha: 0.3),
            ),
          ),
          child: TextField(
            controller: _searchController,
            onChanged: _onSearchChanged,
            decoration: InputDecoration(
              hintText: '수리 분야 검색...',
              hintStyle: AppTextStyles.cardDescription.copyWith(
                fontSize: 16,
                color: AppColors.textSecondary,
              ),
              prefixIcon: Icon(
                Icons.search,
                color: AppColors.textSecondary,
                size: 20,
              ),
              suffixIcon: _searchQuery.isNotEmpty
                  ? IconButton(
                      icon: Icon(
                        Icons.clear,
                        color: AppColors.textSecondary,
                        size: 20,
                      ),
                      onPressed: () {
                        _searchController.clear();
                        _onSearchChanged('');
                      },
                    )
                  : null,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: AppSizes.md,
                vertical: AppSizes.md,
              ),
            ),
          ),
        ),
        const SizedBox(height: AppSizes.md),

        // 선택 영역
        Container(
          height: 400,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSizes.cardBorderRadius),
            border: Border.all(
              color: AppColors.textSecondary.withValues(alpha: 0.3),
            ),
          ),
          child: Row(
            children: [
              // 왼쪽: 대분류 목록
              Container(
                width: 120,
                decoration: BoxDecoration(
                  border: Border(
                    right: BorderSide(
                      color: AppColors.textSecondary.withValues(alpha: 0.3),
                    ),
                  ),
                ),
                child: ListView.builder(
                  itemCount: RepairFields.categories.length,
                  itemBuilder: (context, index) {
                    final category = RepairFields.categories[index];
                    final isSelected = _selectedCategoryId == category.id;

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedCategoryId = category.id;
                          _selectedSubCategoryId = null;
                          _searchQuery = '';
                          _searchController.clear();
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 16,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.primary.withValues(alpha: 0.1)
                              : Colors.transparent,
                          border: Border(
                            bottom: BorderSide(
                              color: AppColors.textSecondary.withValues(
                                alpha: 0.2,
                              ),
                            ),
                          ),
                        ),
                        child: Row(
                          children: [
                            Text(
                              category.icon,
                              style: const TextStyle(fontSize: 16),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                category.name,
                                style: AppTextStyles.cardDescription.copyWith(
                                  fontSize: 14,
                                  color: isSelected
                                      ? AppColors.primary
                                      : AppColors.textPrimary,
                                  fontWeight: isSelected
                                      ? FontWeight.w600
                                      : FontWeight.normal,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            if (isSelected)
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 12,
                                color: AppColors.primary,
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              // 오른쪽: 중분류 및 소분류 목록
              Expanded(child: _buildRightPanel()),
            ],
          ),
        ),

        // 선택된 분야 수 표시
        if (_selectedSpecialtyIds.isNotEmpty) ...[
          const SizedBox(height: AppSizes.md),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.green.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Colors.green.withValues(alpha: 0.3),
                width: 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.check_circle, size: 16, color: Colors.green[700]),
                const SizedBox(width: 8),
                Text(
                  '${_selectedSpecialtyIds.length}개 분야 선택됨',
                  style: AppTextStyles.cardDescription.copyWith(
                    fontSize: 13,
                    color: Colors.green[700],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  /// 오른쪽 패널 (중분류 및 소분류)
  Widget _buildRightPanel() {
    if (_searchQuery.isNotEmpty) {
      // 검색 모드
      final filteredFields = _getFilteredFields();
      return ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: filteredFields.length,
        itemBuilder: (context, index) {
          final field = filteredFields[index];
          final isSelected = _selectedSpecialtyIds.contains(field.id);

          return _buildFieldItem(field, isSelected);
        },
      );
    }

    if (_selectedCategoryId == null) {
      // 아무것도 선택되지 않은 상태
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.category_outlined,
              size: 48,
              color: AppColors.textSecondary.withValues(alpha: 0.5),
            ),
            const SizedBox(height: 16),
            Text(
              '수리 분야를 선택해주세요',
              style: AppTextStyles.cardDescription.copyWith(
                fontSize: 16,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      );
    }

    final category = RepairFields.findCategoryById(_selectedCategoryId!);
    if (category == null) return const SizedBox();

    if (_selectedSubCategoryId == null) {
      // 중분류 목록 표시
      return ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: category.subCategories.length,
        itemBuilder: (context, index) {
          final subCategory = category.subCategories[index];
          final isSelected = _selectedSubCategoryId == subCategory.id;

          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedSubCategoryId = subCategory.id;
              });
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 4),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.primary.withValues(alpha: 0.1)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: isSelected
                      ? AppColors.primary
                      : AppColors.textSecondary.withValues(alpha: 0.2),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      subCategory.name,
                      style: AppTextStyles.cardDescription.copyWith(
                        fontSize: 14,
                        color: isSelected
                            ? AppColors.primary
                            : AppColors.textPrimary,
                        fontWeight: isSelected
                            ? FontWeight.w600
                            : FontWeight.normal,
                      ),
                    ),
                  ),
                  Text(
                    '${subCategory.fields.length}개',
                    style: AppTextStyles.cardDescription.copyWith(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 12,
                    color: AppColors.textSecondary,
                  ),
                ],
              ),
            ),
          );
        },
      );
    } else {
      // 소분류 목록 표시
      final subCategory = RepairFields.findSubCategoryById(
        _selectedSubCategoryId!,
      );
      if (subCategory == null) return const SizedBox();

      return Column(
        children: [
          // 중분류 헤더
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.05),
              border: Border(
                bottom: BorderSide(
                  color: AppColors.textSecondary.withValues(alpha: 0.2),
                ),
              ),
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedSubCategoryId = null;
                    });
                  },
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: 16,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    subCategory.name,
                    style: AppTextStyles.cardDescription.copyWith(
                      fontSize: 16,
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // 소분류 목록
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: subCategory.fields.length,
              itemBuilder: (context, index) {
                final field = subCategory.fields[index];
                final isSelected = _selectedSpecialtyIds.contains(field.id);

                return _buildFieldItem(field, isSelected);
              },
            ),
          ),
        ],
      );
    }
  }

  /// 분야 아이템 위젯
  Widget _buildFieldItem(RepairField field, bool isSelected) {
    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      child: GestureDetector(
        onTap: () => _toggleField(field.id),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isSelected
                ? AppColors.primary.withValues(alpha: 0.1)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isSelected
                  ? AppColors.primary
                  : AppColors.textSecondary.withValues(alpha: 0.2),
            ),
          ),
          child: Row(
            children: [
              // 아이콘
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.primary.withValues(alpha: 0.1)
                      : AppColors.textSecondary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Center(
                  child: Text(field.icon, style: const TextStyle(fontSize: 16)),
                ),
              ),
              const SizedBox(width: 12),

              // 분야 정보
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      field.name,
                      style: AppTextStyles.cardDescription.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: isSelected
                            ? AppColors.primary
                            : AppColors.textPrimary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      field.description,
                      style: AppTextStyles.cardDescription.copyWith(
                        fontSize: 12,
                        color: isSelected
                            ? AppColors.primary.withValues(alpha: 0.8)
                            : AppColors.textSecondary,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),

              // 선택 표시
              if (isSelected)
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.check, size: 12, color: Colors.white),
                )
              else
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: AppColors.textSecondary.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
