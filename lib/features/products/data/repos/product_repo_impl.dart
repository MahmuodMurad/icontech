import 'package:icontech/features/products/data/repos/product_repo.dart';

import '../../../../core/api/api_service.dart';
import '../../../../core/api/end_points.dart';
import '../models/category_model.dart';
import '../models/product_model.dart';

class ProductRepoImpl implements ProductRepo {
  final ApiService apiService;

  ProductRepoImpl(this.apiService);

  @override
  Future<List<Category>> getBranchCategories(int branchId) async {
    final response = await apiService.get(endPoint: EndPoints.branchCategories(branchId));
    print('Categories Response: $response');
    return (response['data'] as List).map((e) => Category.fromJson(e)).toList();
  }

  @override
  Future<List<Product>> getCategoryProducts(int branchId, int categoryId) async {
    final response = await apiService.get(endPoint: EndPoints.categoryProducts(branchId, categoryId));
    print('Products Response: $response');
    try {
      return (response['data'] as List).map((e) => Product.fromJson(e)).toList();
    } catch (e) {
      print('Error while mapping products: $e');
      print('Raw Products Response: ${response['data']}');
      rethrow;
    }
  }
}


