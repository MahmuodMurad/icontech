import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icontech/core/utils/styles.dart';
import 'package:icontech/features/products/presentation/view_model/product_cubit.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../generated/l10n.dart';
import '../../data/models/product_model.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    var deviceWidth = MediaQuery.of(context).size.width;
    var deviceHeight = MediaQuery.of(context).size.height;
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        var cubit = BlocProvider.of<ProductCubit>(context);
        return Scaffold(
          backgroundColor: AppColors.kPrimaryColor,
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 40),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white38,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white38,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.favorite_border,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: deviceHeight * 0.08),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: AppColors.kWhiteColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: deviceHeight * 0.25),
                              Text(
                                product.titleAr!,
                                style: Styles.textStyle30.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.kPrimaryColor,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                "🔥 ${product.calories!}${S.of(context).calories}/${S.of(context).pieces}",
                                style: Styles.textStyle18.copyWith(
                                  color: AppColors.kBlackColor,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                "${product.price!}${S.of(context).rs}",
                                style: Styles.textStyle20.copyWith(
                                  color: AppColors.kGreyShade,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 20),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: AppColors.kPrimaryColor,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Center(
                                        child: IconButton(
                                          onPressed: () {
                                            cubit.incrementQuantity();
                                          },
                                          icon: const Icon(
                                            Icons.add,
                                            color: Colors.white,
                                            size: 30,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                                      child: Container(
                                        width: deviceWidth*0.12,
                                        height: deviceWidth*0.12,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(color: AppColors.kPrimaryColor),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: Center(
                                          child: Text(
                                            cubit.quantity.toString(),
                                            style: Styles.textStyle16.copyWith(
                                              color: AppColors.kBlackColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: AppColors.kPrimaryColor,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Center(
                                        child: IconButton(
                                          onPressed: () {
                                            cubit.decrementQuantity();
                                          },
                                          icon: const Icon(
                                            Icons.remove,
                                            color: Colors.white,
                                            size: 30,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.messenger_outline_outlined,
                                      color: AppColors.kBlackColor,
                                      size: 30,
                                    ),
                                    Text(
                                      S.of(context).add_notes,
                                      style: Styles.textStyle18,
                                    ),
                                    const Spacer(),
                                    Text(
                                      S.of(context).add_notes,
                                      style: Styles.textStyle18.copyWith(
                                        color: AppColors.kPrimaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 20),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: deviceWidth * 0.7,
                                      height: deviceHeight*0.07,
                                      decoration: BoxDecoration(
                                        color: AppColors.kPrimaryColor,
                                        borderRadius: BorderRadius.circular(10),),

                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            Text(
                                              S.of(context).add_to_cart,
                                              style: Styles.textStyle18.copyWith(
                                                color: Colors.white,
                                              ),
                                            ),
                                           const Spacer(),

                                            Text(
                                              "${cubit.quantity * product.price!}${S.of(context).rs}",
                                              style: Styles.textStyle18.copyWith(
                                                color: AppColors.kWhiteColor,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),

                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  const Spacer(),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: AppColors.kPrimaryColor,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                      child: IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.shopping_cart,
                                          color: Colors.white,
                                          size: 30,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: -deviceHeight * 0.14,
                          right: deviceWidth * 0.05,
                          child: Hero(
                            tag: product.id,
                            child: Image.network(
                              product.imageUrl!,
                              height: deviceHeight * 0.3,
                              width: deviceWidth * 0.9,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
