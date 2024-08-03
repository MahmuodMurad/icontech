class Product {
  final int id;
  final String? titleEn;
  final String? titleAr;
  final String? descriptionEn;
  final String? descriptionAr;
  final String? imageUrl;
  final double? price;
  final double? newPrice;
  final int categoryId;
  final String? calories;

  Product( {
    required this.calories,
    required this.id,
    required this.titleEn,
    required this.titleAr,
    required this.descriptionEn,
    required this.descriptionAr,
    required this.imageUrl,
    required this.price,
    required this.newPrice,
    required this.categoryId,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    try {
      return Product(
        calories: json['calories']??"",
        id: json['id'] as int,
        titleEn: json['title']['en']??"",
        titleAr: json['title']['ar']??"",
        descriptionEn: json['description']['en']??"",
        descriptionAr: json['description']['ar'] ?? "",
        imageUrl: json['last_image']['image'] ?? "https://img.freepik.com/free-photo/side-view-shawarma-with-fried-potatoes-board-cookware_176474-3215.jpg?ga=GA1.1.1077507535.1671579631&semt=sph",
        price: (json['price']??0 as num).toDouble(),
        newPrice: (json['new_price'] ??0 as num).toDouble(),
        categoryId: json['category_id'] as int,
      );
    } catch (e) {
      print('Product JSON parse error: $e');
      print('Product JSON data: $json');
      rethrow;
    }
  }
}
