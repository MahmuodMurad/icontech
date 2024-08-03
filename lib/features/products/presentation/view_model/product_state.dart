part of 'product_cubit.dart';

@immutable
sealed class ProductState {}

final class ProductInitial extends ProductState {}

final class ProductLoading extends ProductState {
  final List<Category> categories;

  ProductLoading({required this.categories});
}
final class CategoryLoading extends ProductState {}

final class ProductCategoriesLoaded extends ProductState {
  final List<Category> categories;

  ProductCategoriesLoaded(this.categories);
}

final class ProductProductsLoaded extends ProductState {
  final List<Product> products;
  final List<Category> categories;

  ProductProductsLoaded(this.products, this.categories);
}

final class ProductError extends ProductState {
  final String message;

  ProductError(this.message);
}

 final class ProductQuantityChanged extends ProductState {}