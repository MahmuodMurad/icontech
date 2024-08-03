import 'package:flutter/material.dart';
import 'package:icontech/core/utils/app_ruters.dart';
import 'package:icontech/core/utils/assets/asset_images.dart';
import 'package:icontech/features/splash/presentation/views/widgets/sliding_text.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../../../main.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<Offset> slidingAnimation;


  @override
  void initState() {
    super.initState();
    initSlidingAnimation();
    navigateToNextScreen();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(child: Image.asset(AssetsImg.logo)),
        SlidingText(slidingAnimation: slidingAnimation),
      ],
    );
  }

  void initSlidingAnimation() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );

    slidingAnimation =
        Tween<Offset>(begin: const Offset(0, 14), end: Offset.zero)
            .animate(animationController);

    animationController.forward();
  }

  void navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 5));
    String? token = await storage.read(key: 'accessToken');
    print(token);
    if (token != null) {
      AppRouters.router.pushReplacement(AppRouters.kHomeView);
    } else {
      AppRouters.router.pushReplacement(AppRouters.kLoginView);
    }
  }
}
