

import '../models/category_model.dart';
import '../models/product_model.dart';

abstract class ProductRepo {
  Future<List<Category>> getBranchCategories(int branchId) ;
  Future<List<Product>> getCategoryProducts(int branchId, int categoryId)  ;
}
