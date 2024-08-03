import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icontech/core/utils/app_colors.dart';
import 'package:icontech/core/utils/styles.dart';

import '../../../../core/api/api_service.dart';
import '../../../../generated/l10n.dart';
import '../../data/repos/product_repo_impl.dart';
import '../view_model/product_cubit.dart';
import 'branch_detail_view.dart';

class BranchDetailScreen extends StatelessWidget {
  final int locationId;

  const BranchDetailScreen({super.key, required this.locationId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white60,
      appBar: AppBar(
        backgroundColor: Colors.white60,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.kPrimaryColor,
            size: 30,
          ),
        ),
        title: Text(
          S.of(context).new_shormeaah,
          style: Styles.textStyle30.copyWith(
            color: AppColors.kPrimaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: BlocProvider(
        create: (context) => ProductCubit(ProductRepoImpl(ApiService()))..fetchCategories(locationId),
        child: BranchDetailView(
          branchId: locationId,
        ),
      ),
    );
  }
}
