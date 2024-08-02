import 'package:flutter/material.dart';
import 'package:icontech/core/utils/app_colors.dart';
import 'package:icontech/features/splash/presentation/views/widgets/splash_view_body.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.kPrimaryColor,
      body: SplashViewBody(),
    );
  }
}
