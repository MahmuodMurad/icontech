import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icontech/core/utils/app_colors.dart';
import 'package:icontech/core/utils/styles.dart';
import 'package:icontech/features/products/presentation/view_model/product_cubit.dart';

import '../../../../../generated/l10n.dart';
import '../../../data/models/product_model.dart';
import '../product_detail_screen.dart';

class ProductListView extends StatelessWidget {
  final List<Product> products;

  const ProductListView({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    var deviceWidth = MediaQuery.of(context).size.width;
    var deviceHeight = MediaQuery.of(context).size.height;
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsetsDirectional.only(top: 10.0),
          child: GridView.builder(
            padding: const EdgeInsets.all(8),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 15,
              mainAxisSpacing: 30,
              childAspectRatio: 0.7,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductDetailScreen(product: product),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 60.0),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        width: deviceWidth * 0.48,
                        height: deviceHeight * 0.30,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: deviceHeight * 0.09),
                                  Text(
                                    product.titleAr!,
                                    style: Styles.textStyle18.copyWith(
                                      color: AppColors.kPrimaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    product.descriptionAr!,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: Styles.textStyle16.copyWith(
                                      color: AppColors.kGreyShade,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Text(
                                        product.price == 0 ? S.of(context).price_you_choose : '${product.price} ${S.of(context).rs}',
                                        style: Styles.textStyle16.copyWith(
                                          color: product.price == 0 ? AppColors.kRedColor : AppColors.kGreyShade,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const Spacer(),
                                      IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.favorite_border,
                                          color: AppColors.kBlackColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                          top: -deviceHeight * 0.06,
                          right: deviceWidth * 0.07,
                          child: Container(
                            decoration: const BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  spreadRadius: 0.5,
                                  blurRadius: 50,
                                  offset: Offset(5, 30),
                                ),
                              ],
                            ),
                            child: Hero(
                              tag: product.id,
                              child: Image.network(
                                product.imageUrl!,
                                fit: BoxFit.cover,
                                width: deviceWidth * 0.3,
                                height: deviceHeight * 0.11,
                              ),
                            ),
                          )),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
