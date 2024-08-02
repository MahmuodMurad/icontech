
import 'package:get_it/get_it.dart';

import '../../features/login/data/repositories/login_repo_impl.dart';
import '../api/api_service.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerSingleton<ApiService>(ApiService());
  getIt.registerSingleton<LoginRepoImpl>(LoginRepoImpl(
    getIt.get<ApiService>(),
  ));
  // getIt.registerSingleton<HomeRepoImpl>(HomeRepoImpl(
  //   getIt.get<ApiService>(),
  // ));
  // getIt.registerSingleton<SearchRepoImpl>(SearchRepoImpl(
  //   getIt.get<ApiService>(),
  // ));

}