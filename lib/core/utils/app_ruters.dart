import 'package:go_router/go_router.dart';
import 'package:icontech/features/login/presentation/screens/login_screen.dart';

import '../../features/home/presentathion/views/home_view.dart';
import '../../features/splash/presentation/views/splash_view.dart';

abstract class AppRouters {
  static const kLoginView = '/loginView';
  static const kHomeView = '/homeView';
  static const kBookDetailsView = '/bookDetailsView';
  static const kSearchView = '/searchView';
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
        builder: (context, state) => const HomeScreen(),
      ),
    ],
  );
}
