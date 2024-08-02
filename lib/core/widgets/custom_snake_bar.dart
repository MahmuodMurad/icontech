import 'package:flutter/material.dart';
import 'package:icontech/core/utils/app_colors.dart';

Widget customSnakeBar({required String message, required BuildContext context}) {
  return SnackBar(
    backgroundColor: AppColors.kRedColor,
    content: Text(message),
    duration: const Duration(seconds: 2),
  );
}