import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:icontech/core/utils/app_colors.dart';
import 'package:icontech/features/login/presentation/cubit/login_cubit.dart';
import 'package:icontech/generated/l10n.dart';

import 'bloc_observer.dart';
import 'core/api/interceptor.dart';
import 'core/utils/app_ruters.dart';
import 'core/utils/service_locator.dart';
import 'features/login/data/repositories/login_repo_impl.dart';
late Dio dio;
const storage = FlutterSecureStorage();
void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = AppBlocObserver();
  setupServiceLocator();
  String? accessToken = await storage.read(key: 'accessToken');
  dio = Dio();
  dio.interceptors.add(AuthenticatorInterceptor(accessToken??''));
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context)=>LoginCubit(
            getIt.get<LoginRepoImpl>(),
          ),
        ),
      ],
      child:MaterialApp.router(
        locale: const Locale('ar'),
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        routerConfig: AppRouters.router,
        debugShowCheckedModeBanner: false,

        theme: ThemeData(
          primaryColor: AppColors.kPrimaryColor,
          fontFamily: "Roboto"
        ),

      ),

    );
  }
}
