class EndPoints {
  static const String baseUrl = 'https://nottr.app/api/';
  //endpoints
  static const String login = '${baseUrl}auth/login';
  static const String refreshForToken = '${baseUrl}accounts/sessions/current';
  static const String branches = '${baseUrl}branches';
  static String branchCategories(int branchId) => '${baseUrl}branch/$branchId/categories';
  static String categoryProducts(int branchId, int categoryId) => '${baseUrl}branch/$branchId/category/$categoryId/products';
}
