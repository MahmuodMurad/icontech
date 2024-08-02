import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/utils/app_ruters.dart';
import '../../data/repositories/login_repo.dart';
part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.loginRepo) : super(LoginInitialState());
  final LoginRepo loginRepo;
  bool obscurePassword = true;

  void changePasswordVisibility() {
    obscurePassword = !obscurePassword;
    emit(LoginInitialState());
  }

  Future<void> login({
    required String phone,
    required String password,
  }) async {
    emit(LoginInitialState());
    try {
      debugPrint('Login attempt: phone=$phone, password=$password');
      emit(LoginLoadingState());
      final result = await loginRepo.login(
        phone: phone,
        password: password,
        companyId: 3,
      );
      result.fold(
            (failure) {
          debugPrint('Login failed: $failure');
          emit(LoginErrorState(
            errorMessage: failure is ServerFailure ? failure.errMessage : null,
            validationErrors: failure is ServerFailure && failure.validationErrors != null
                ? failure.validationErrors
                : null,
          ));
        },
            (message) {
          debugPrint('Login successful: $message');
          AppRouters.router.pushReplacement(AppRouters.kHomeView);
          emit(LoginSuccessState());
        },
      );
    } catch (e) {
      debugPrint('Login error: $e');
      emit(LoginErrorState(errorMessage: e.toString()));
    }
  }
}



