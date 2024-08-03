import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icontech/core/utils/app_colors.dart';
import '../../../data/models/category_model.dart';
import '../../view_model/product_cubit.dart';

class CategoryList extends StatelessWidget {
  final List<Category> categories;
  final int branchId;

  const CategoryList({super.key, required this.categories, required this.branchId});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130,
      child: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              return GestureDetector(
                onTap: () {
                  context.read<ProductCubit>().selectedCategory(index);
                  context.read<ProductCubit>().fetchProducts(branchId, category.id);
                },
                child: Container(
                  width: 120,
                  height: 120,
                  padding: const EdgeInsets.all(8),
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    color: context.read<ProductCubit>().selectedCategoryIndex == index? AppColors.kPrimaryColor : AppColors.kWhiteColor,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: Image.network(category.imageUrl, height: 70, width: 70, fit: BoxFit.contain,),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
