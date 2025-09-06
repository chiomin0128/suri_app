import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_text_styles.dart';

class AIRequestScreen extends StatefulWidget {
  const AIRequestScreen({super.key});

  @override
  State<AIRequestScreen> createState() => _AIRequestScreenState();
}

class _AIRequestScreenState extends State<AIRequestScreen> {
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _urgencyController = TextEditingController();

  List<String> _selectedImages = [];
  String _selectedCategory = '';
  String _selectedCity = '';
  String _selectedDistrict = '';
  final TextEditingController _detailAddressController =
      TextEditingController();
  List<String> _selectedTechnicianConditions = [];
  String _selectedUrgency = 'normal';

  // 수리기사 조건 세부 설정
  double _minRating = 4.0;
  int _minReviews = 50;
  int _minExperience = 3;

  @override
  void dispose() {
    _descriptionController.dispose();
    _locationController.dispose();
    _urgencyController.dispose();
    _detailAddressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // AI 가이드라인
            _buildAIGuidelines(),

            const SizedBox(height: 24),

            // 사진 추가 섹션
            _buildImageUploadSection(),

            const SizedBox(height: 24),

            // 내용 입력 섹션
            _buildContentInputSection(),

            const SizedBox(height: 24),

            // 수리기사 조건 섹션
            _buildTechnicianConditionsSection(),

            const SizedBox(height: 24),

            // 요청하기 버튼
            _buildSubmitButton(),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  /// 앱바 위젯
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      leading: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(12),
        ),
        child: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 18,
            color: AppColors.textPrimary,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      title: Text(
        'AI 스마트 견적',
        style: AppTextStyles.cardTitle.copyWith(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimary,
        ),
      ),
      centerTitle: true,
    );
  }

  /// 사진 추가 섹션
  Widget _buildImageUploadSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            offset: const Offset(0, 2),
            blurRadius: 8,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.camera_alt, size: 20, color: AppColors.primary),
              const SizedBox(width: 8),
              Text(
                '사진 추가',
                style: AppTextStyles.cardTitle.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            '수리할 부분을 명확하게 촬영해주세요 (최대 5장)',
            style: AppTextStyles.cardDescription.copyWith(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 16),
          _buildImageGrid(),
        ],
      ),
    );
  }

  /// 이미지 그리드
  Widget _buildImageGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 1,
      ),
      itemCount: _selectedImages.length + 1,
      itemBuilder: (context, index) {
        if (index == _selectedImages.length) {
          return _buildAddImageButton();
        }
        return _buildImageItem(index);
      },
    );
  }

  /// 이미지 추가 버튼
  Widget _buildAddImageButton() {
    return GestureDetector(
      onTap: _addImage,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Colors.grey[300]!,
            style: BorderStyle.solid,
            width: 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add, size: 24, color: Colors.grey[600]),
            const SizedBox(height: 4),
            Text(
              '사진 추가',
              style: AppTextStyles.cardDescription.copyWith(
                fontSize: 10,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 이미지 아이템
  Widget _buildImageItem(int index) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(8),
            image: DecorationImage(
              image: NetworkImage(_selectedImages[index]),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          top: 4,
          right: 4,
          child: GestureDetector(
            onTap: () => _removeImage(index),
            child: Container(
              width: 20,
              height: 20,
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.close, size: 14, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  /// 이미지 추가 함수
  void _addImage() {
    // TODO: 이미지 선택 로직 구현
    setState(() {
      _selectedImages.add('https://via.placeholder.com/150');
    });
  }

  /// 이미지 제거 함수
  void _removeImage(int index) {
    setState(() {
      _selectedImages.removeAt(index);
    });
  }

  /// 위치 선택기 위젯
  Widget _buildLocationSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '수리 위치',
          style: AppTextStyles.cardDescription.copyWith(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 8),

        // 시/도 선택
        _buildDropdown(
          value: _selectedCity,
          hint: '시/도 선택',
          items: const [
            '서울특별시',
            '부산광역시',
            '대구광역시',
            '인천광역시',
            '광주광역시',
            '대전광역시',
            '울산광역시',
            '세종특별자치시',
            '경기도',
            '강원도',
            '충청북도',
            '충청남도',
            '전라북도',
            '전라남도',
            '경상북도',
            '경상남도',
            '제주특별자치도',
          ],
          onChanged: (value) {
            setState(() {
              _selectedCity = value ?? '';
              _selectedDistrict = '';
            });
          },
        ),

        const SizedBox(height: 12),

        // 시/군/구 선택
        _buildDropdown(
          value: _selectedDistrict,
          hint: '시/군/구 선택',
          items: _getDistricts(_selectedCity),
          onChanged: (value) {
            setState(() {
              _selectedDistrict = value ?? '';
            });
          },
        ),

        const SizedBox(height: 12),

        // 상세주소 입력
        _buildInputField(
          controller: _detailAddressController,
          label: '상세주소',
          hint: '예: 아파트명, 동호수, 건물명 등',
          isRequired: false,
        ),
      ],
    );
  }

  /// 드롭다운 위젯
  Widget _buildDropdown({
    required String value,
    required String hint,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: value.isEmpty
              ? Colors.grey[300]!
              : AppColors.primary.withValues(alpha: 0.3),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.08),
            offset: const Offset(0, 2),
            blurRadius: 8,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => _showLocationBottomSheet(hint, items, onChanged),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Row(
              children: [
                Icon(
                  Icons.location_on_outlined,
                  size: 20,
                  color: value.isEmpty ? Colors.grey[500] : AppColors.primary,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    value.isEmpty ? hint : value,
                    style: AppTextStyles.cardDescription.copyWith(
                      fontSize: 15,
                      color: value.isEmpty
                          ? Colors.grey[500]
                          : AppColors.textPrimary,
                      fontWeight: value.isEmpty
                          ? FontWeight.w400
                          : FontWeight.w500,
                    ),
                  ),
                ),
                Icon(
                  Icons.keyboard_arrow_down_rounded,
                  size: 24,
                  color: value.isEmpty ? Colors.grey[500] : AppColors.primary,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// 위치 선택 바텀시트
  void _showLocationBottomSheet(
    String title,
    List<String> items,
    Function(String?) onChanged,
  ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: Column(
          children: [
            // 핸들바
            Container(
              margin: const EdgeInsets.only(top: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            // 헤더
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    size: 24,
                    color: AppColors.primary,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    title,
                    style: AppTextStyles.cardTitle.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.close,
                        size: 20,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // 구분선
            Container(height: 1, color: Colors.grey[200]),

            // 리스트
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 8),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  return Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () {
                          onChanged(item);
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 16,
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: AppColors.primary.withValues(
                                    alpha: 0.3,
                                  ),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Text(
                                  item,
                                  style: AppTextStyles.cardDescription.copyWith(
                                    fontSize: 15,
                                    color: AppColors.textPrimary,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 16,
                                color: Colors.grey[400],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 시/군/구 리스트 반환
  List<String> _getDistricts(String city) {
    switch (city) {
      case '서울특별시':
        return [
          '강남구',
          '강동구',
          '강북구',
          '강서구',
          '관악구',
          '광진구',
          '구로구',
          '금천구',
          '노원구',
          '도봉구',
          '동대문구',
          '동작구',
          '마포구',
          '서대문구',
          '서초구',
          '성동구',
          '성북구',
          '송파구',
          '양천구',
          '영등포구',
          '용산구',
          '은평구',
          '종로구',
          '중구',
          '중랑구',
        ];
      case '부산광역시':
        return [
          '강서구',
          '금정구',
          '남구',
          '동구',
          '동래구',
          '부산진구',
          '북구',
          '사상구',
          '사하구',
          '서구',
          '수영구',
          '연제구',
          '영도구',
          '중구',
          '해운대구',
          '기장군',
        ];
      case '경기도':
        return [
          '수원시',
          '성남시',
          '의정부시',
          '안양시',
          '부천시',
          '광명시',
          '평택시',
          '과천시',
          '오산시',
          '시흥시',
          '군포시',
          '의왕시',
          '하남시',
          '용인시',
          '파주시',
          '이천시',
          '안성시',
          '김포시',
          '화성시',
          '광주시',
          '여주시',
          '양평군',
          '고양시',
          '동두천시',
          '가평군',
          '연천군',
        ];
      case '전라남도':
        return [
          '목포시',
          '여수시',
          '순천시',
          '나주시',
          '광양시',
          '담양군',
          '곡성군',
          '구례군',
          '고흥군',
          '보성군',
          '화순군',
          '장흥군',
          '강진군',
          '해남군',
          '영암군',
          '무안군',
          '함평군',
          '영광군',
          '장성군',
          '완도군',
          '진도군',
          '신안군',
        ];
      case '전라북도':
        return [
          '전주시',
          '군산시',
          '익산시',
          '정읍시',
          '남원시',
          '김제시',
          '완주군',
          '진안군',
          '무주군',
          '장수군',
          '임실군',
          '순창군',
          '고창군',
          '부안군',
        ];
      case '경상남도':
        return [
          '창원시',
          '진주시',
          '통영시',
          '사천시',
          '김해시',
          '밀양시',
          '거제시',
          '양산시',
          '의령군',
          '함안군',
          '창녕군',
          '고성군',
          '남해군',
          '하동군',
          '산청군',
          '함양군',
          '거창군',
          '합천군',
        ];
      case '경상북도':
        return [
          '포항시',
          '경주시',
          '김천시',
          '안동시',
          '구미시',
          '영주시',
          '영천시',
          '상주시',
          '문경시',
          '경산시',
          '군위군',
          '의성군',
          '청송군',
          '영양군',
          '영덕군',
          '청도군',
          '고령군',
          '성주군',
          '칠곡군',
          '예천군',
          '봉화군',
          '울진군',
          '울릉군',
        ];
      case '충청남도':
        return [
          '천안시',
          '공주시',
          '보령시',
          '아산시',
          '서산시',
          '논산시',
          '계룡시',
          '당진시',
          '금산군',
          '부여군',
          '서천군',
          '청양군',
          '홍성군',
          '예산군',
          '태안군',
        ];
      case '충청북도':
        return [
          '청주시',
          '충주시',
          '제천시',
          '보은군',
          '옥천군',
          '영동군',
          '증평군',
          '진천군',
          '괴산군',
          '음성군',
          '단양군',
        ];
      case '강원도':
        return [
          '춘천시',
          '원주시',
          '강릉시',
          '동해시',
          '태백시',
          '속초시',
          '삼척시',
          '홍천군',
          '횡성군',
          '영월군',
          '평창군',
          '정선군',
          '철원군',
          '화천군',
          '양구군',
          '인제군',
          '고성군',
          '양양군',
        ];
      case '대구광역시':
        return ['중구', '동구', '서구', '남구', '북구', '수성구', '달서구', '달성군'];
      case '인천광역시':
        return [
          '중구',
          '동구',
          '미추홀구',
          '연수구',
          '남동구',
          '부평구',
          '계양구',
          '서구',
          '강화군',
          '옹진군',
        ];
      case '광주광역시':
        return ['동구', '서구', '남구', '북구', '광산구'];
      case '대전광역시':
        return ['동구', '중구', '서구', '유성구', '대덕구'];
      case '울산광역시':
        return ['중구', '남구', '동구', '북구', '울주군'];
      case '세종특별자치시':
        return ['세종시'];
      case '제주특별자치도':
        return ['제주시', '서귀포시'];
      default:
        return ['선택하세요'];
    }
  }

  /// 내용 입력 섹션
  Widget _buildContentInputSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            offset: const Offset(0, 2),
            blurRadius: 8,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.edit, size: 20, color: AppColors.primary),
              const SizedBox(width: 8),
              Text(
                '수리 내용',
                style: AppTextStyles.cardTitle.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // 수리 내용 입력
          _buildInputField(
            controller: _descriptionController,
            label: '수리 내용을 자세히 설명해주세요',
            hint:
                '예: 화장실 배수구가 막혀서 물이 잘 안 빠져요. 어제부터 계속 그런 상태입니다. 원하는 수리기사분도 구체적으로 적어주세요.',
            maxLines: 4,
            isRequired: true,
          ),

          const SizedBox(height: 16),

          // 위치 선택
          _buildLocationSelector(),

          const SizedBox(height: 16),

          // 긴급도 선택
          _buildUrgencySelector(),
        ],
      ),
    );
  }

  /// 입력 필드 위젯
  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required String hint,
    int maxLines = 1,
    bool isRequired = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: AppTextStyles.cardDescription.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary,
              ),
            ),
            if (isRequired) ...[
              const SizedBox(width: 4),
              Text(
                '*',
                style: AppTextStyles.cardDescription.copyWith(
                  fontSize: 14,
                  color: Colors.red,
                ),
              ),
            ],
          ],
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: AppTextStyles.cardDescription.copyWith(
              fontSize: 14,
              color: Colors.grey[500],
              height: 1.4,
            ),
            filled: true,
            fillColor: Colors.grey[50],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColors.primary),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
          ),
        ),
      ],
    );
  }

  /// 수리기사 조건 섹션
  Widget _buildTechnicianConditionsSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            offset: const Offset(0, 2),
            blurRadius: 8,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.star, size: 20, color: AppColors.primary),
              const SizedBox(width: 8),
              Text(
                '수리기사 조건',
                style: AppTextStyles.cardTitle.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            '원하는 수리기사 조건을 설정해주세요',
            style: AppTextStyles.cardDescription.copyWith(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 20),

          // 별점 조건
          _buildRatingCondition(),
          const SizedBox(height: 20),

          // 리뷰 수 조건
          _buildReviewCondition(),
          const SizedBox(height: 20),

          // 경험 조건
          _buildExperienceCondition(),
          const SizedBox(height: 20),

          // 기타 조건
          _buildOtherConditions(),
        ],
      ),
    );
  }

  /// 별점 조건 위젯
  Widget _buildRatingCondition() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.star, size: 18, color: Colors.amber[600]),
            const SizedBox(width: 8),
            Text(
              '최소 별점',
              style: AppTextStyles.cardDescription.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: Slider(
                value: _minRating,
                min: 1.0,
                max: 5.0,
                divisions: 8,
                activeColor: AppColors.primary,
                inactiveColor: Colors.grey[300],
                onChanged: (value) {
                  setState(() {
                    _minRating = value;
                  });
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.star, size: 16, color: AppColors.primary),
                  const SizedBox(width: 4),
                  Text(
                    '${_minRating.toStringAsFixed(1)}점 이상',
                    style: AppTextStyles.cardDescription.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// 리뷰 수 조건 위젯
  Widget _buildReviewCondition() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.rate_review, size: 18, color: Colors.blue[600]),
            const SizedBox(width: 8),
            Text(
              '최소 리뷰 수',
              style: AppTextStyles.cardDescription.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: Slider(
                value: _minReviews.toDouble(),
                min: 0,
                max: 500,
                divisions: 10,
                activeColor: AppColors.primary,
                inactiveColor: Colors.grey[300],
                onChanged: (value) {
                  setState(() {
                    _minReviews = value.round();
                  });
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.rate_review, size: 16, color: AppColors.primary),
                  const SizedBox(width: 4),
                  Text(
                    '${_minReviews}개 이상',
                    style: AppTextStyles.cardDescription.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// 경험 조건 위젯
  Widget _buildExperienceCondition() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.work, size: 18, color: Colors.green[600]),
            const SizedBox(width: 8),
            Text(
              '최소 경험',
              style: AppTextStyles.cardDescription.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: Slider(
                value: _minExperience.toDouble(),
                min: 0,
                max: 10,
                divisions: 10,
                activeColor: AppColors.primary,
                inactiveColor: Colors.grey[300],
                onChanged: (value) {
                  setState(() {
                    _minExperience = value.round();
                  });
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.work, size: 16, color: AppColors.primary),
                  const SizedBox(width: 4),
                  Text(
                    '${_minExperience}년 이상',
                    style: AppTextStyles.cardDescription.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// 기타 조건 위젯
  Widget _buildOtherConditions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.checklist, size: 18, color: Colors.purple[600]),
            const SizedBox(width: 8),
            Text(
              '기타 조건',
              style: AppTextStyles.cardDescription.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _buildConditionChip('최저가 수리기사', 'lowest_price'),
            _buildConditionChip('인증된 수리기사', 'certified'),
            _buildConditionChip('24시간 대응', 'available_24h'),
            _buildConditionChip('당일 수리 가능', 'same_day'),
            _buildConditionChip('보험 적용', 'insurance'),
          ],
        ),
      ],
    );
  }

  /// 조건 칩 위젯
  Widget _buildConditionChip(String label, String value) {
    final isSelected = _selectedTechnicianConditions.contains(value);

    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected) {
            _selectedTechnicianConditions.remove(value);
          } else {
            _selectedTechnicianConditions.add(value);
          }
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.grey[100],
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? AppColors.primary : Colors.grey[300]!,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isSelected) ...[
              const Icon(Icons.check, size: 14, color: Colors.white),
              const SizedBox(width: 4),
            ],
            Text(
              label,
              style: AppTextStyles.cardDescription.copyWith(
                fontSize: 12,
                color: isSelected ? Colors.white : AppColors.textPrimary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 긴급도 선택기
  Widget _buildUrgencySelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '긴급도',
          style: AppTextStyles.cardDescription.copyWith(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            _buildUrgencyChip('보통', 'normal', ''),
            const SizedBox(width: 8),
            _buildUrgencyChip('긴급', 'urgent', '+20% 수수료'),
            const SizedBox(width: 8),
            _buildUrgencyChip('매우 긴급', 'very_urgent', '+50% 수수료'),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.orange[50],
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.orange[200]!),
          ),
          child: Row(
            children: [
              Icon(Icons.warning, size: 16, color: Colors.orange[600]),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  '긴급 또는 매우 긴급 선택 시 추가 수수료가 발생합니다',
                  style: AppTextStyles.cardDescription.copyWith(
                    fontSize: 11,
                    color: Colors.orange[700],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// 긴급도 칩 위젯
  Widget _buildUrgencyChip(String label, String value, String feeInfo) {
    final isSelected = _selectedUrgency == value;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedUrgency = value;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : Colors.grey[100],
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isSelected ? AppColors.primary : Colors.grey[300]!,
              width: 1,
            ),
          ),
          child: Column(
            children: [
              Text(
                label,
                style: AppTextStyles.cardDescription.copyWith(
                  fontSize: 12,
                  color: isSelected ? Colors.white : AppColors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (feeInfo.isNotEmpty) ...[
                const SizedBox(height: 2),
                Text(
                  feeInfo,
                  style: AppTextStyles.cardDescription.copyWith(
                    fontSize: 10,
                    color: isSelected ? Colors.white : Colors.grey[600],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  /// AI 가이드라인 위젯
  Widget _buildAIGuidelines() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue[200]!),
      ),
      child: Row(
        children: [
          Icon(Icons.lightbulb_outline, size: 20, color: Colors.blue[600]),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'AI 분석 가이드라인: 사진은 명확하게, 수리 부위는 가까이서, 문제 상황을 구체적으로 설명해주세요',
              style: AppTextStyles.cardDescription.copyWith(
                fontSize: 12,
                color: Colors.blue[700],
                height: 1.3,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 요청하기 버튼
  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _submitRequest,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          'AI 매칭 요청하기',
          style: AppTextStyles.cardTitle.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  /// 요청 제출 함수
  void _submitRequest() {
    if (_descriptionController.text.isEmpty ||
        _selectedCity.isEmpty ||
        _selectedDistrict.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('필수 항목을 모두 입력해주세요'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // TODO: AI 매칭 요청 로직 구현
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('AI 매칭 요청이 완료되었습니다!'),
        backgroundColor: Colors.green,
      ),
    );
  }
}
