import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../data/models/category_model.dart';
import '../../data/models/product_model.dart';
import '../../data/repos/product_repo.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final ProductRepo productRepo;

  ProductCubit(this.productRepo) : super(ProductInitial());

  List<Category> categories = [];
  int selectedCategoryIndex = 10000000;
  Product? selectedProduct;
  int quantity = 1;
  void incrementQuantity() {
    quantity++;
    emit(ProductQuantityChanged());
  }

  void decrementQuantity() {
    if (quantity > 1) {
      quantity--;
      emit(ProductQuantityChanged());
    }
  }
void selectedCategory(int index) {
  selectedCategoryIndex = index;
  emit(ProductCategoriesLoaded(categories));
}
  Future<void> fetchCategories(int branchId) async {
    if (categories.isEmpty) {
      try {
        emit(CategoryLoading());
        categories = await productRepo.getBranchCategories(branchId);
        emit(ProductCategoriesLoaded(categories));
      } catch (e) {
        print("Error: $e");
        emit(ProductError(e.toString()));
      }
    } else {
      emit(ProductCategoriesLoaded(categories));
    }
  }

  Future<void> fetchProducts(int branchId, int categoryId) async {
    try {
      emit(ProductLoading( categories:  categories));
      final products = await productRepo.getCategoryProducts(branchId, categoryId);
      emit(ProductProductsLoaded(products, categories));
    } catch (e) {
      print("Error product: $e");
      emit(ProductError(e.toString()));
    }
  }
}
