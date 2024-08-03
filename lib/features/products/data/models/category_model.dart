class Category {
  final int id;
  final String titleEn;
  final String titleAr;
  final bool isActive;
  final String imageUrl;

  Category({
    required this.id,
    required this.titleEn,
    required this.titleAr,
    required this.isActive,
    required this.imageUrl,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    try {
      return Category(
        id: json['id'] as int,
        titleEn: json['title']['en'] as String,
        titleAr: json['title']['ar'] as String,
        isActive: json['is_active'] == 1,
        imageUrl: json['image'] as String,
      );
    } catch (e) {
      print('Category JSON parse error: $e');
      rethrow;
    }
  }
}
