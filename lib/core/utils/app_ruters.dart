import 'package:go_router/go_router.dart';
import 'package:icontech/features/login/presentation/screens/login_screen.dart';
import 'package:icontech/features/products/presentation/view/product_detail_screen.dart';

import '../../features/home/presentathion/views/map_screen.dart';
import '../../features/splash/presentation/views/splash_view.dart';

abstract class AppRouters {
  static const kLoginView = '/loginView';
  static const kHomeView = '/homeView';
  static const kProductDetailView = '/productDetailView';
  static final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashView(),
      ),
      GoRoute(
        path: kLoginView,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: kHomeView,
        builder: (context, state) => const MapScreen(),
      ),
      // GoRoute(path: kProductDetailView,
      //     builder: (context, state) => const ProductDetailScreen(),
      //     )
    ],
  );
}
