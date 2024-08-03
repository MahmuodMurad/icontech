import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icontech/features/products/presentation/view/widgets/category_list.dart';
import 'package:icontech/features/products/presentation/view/widgets/product_list.dart';

import '../view_model/product_cubit.dart';

class BranchDetailView extends StatelessWidget {
  final int branchId;
  const BranchDetailView({super.key, required this.branchId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white60,
      body: Column(
        children: [
          BlocBuilder<ProductCubit, ProductState>(
            builder: (context, state) {
              if (state is CategoryLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is ProductCategoriesLoaded) {
                return CategoryList(branchId: branchId, categories: state.categories);
              } else if (state is ProductError) {
                return Text(state.message);
              } else {
                return Container();
              }
            },
          ),
          Expanded(
            child: BlocBuilder<ProductCubit, ProductState>(
              builder: (context, state) {
                if (state is ProductLoading) {
                  return Column(
                    children: [
                      SizedBox(height: 100, child: CategoryList(branchId: branchId, categories: state.categories)),
                      const SizedBox(height: 20),
                      const Center(child: CircularProgressIndicator()),
                    ],
                  );
                } else if (state is ProductProductsLoaded) {
                  return Column(
                    children: [
                      SizedBox(height: 100, child: CategoryList(branchId: branchId, categories: state.categories)),
                      const SizedBox(height: 20),
                      Expanded(child: ProductListView(products: state.products)),
                    ],
                  );
                } else if (state is ProductError) {
                  return Center(child: Text(state.message));
                } else {
                  return Container();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
