import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';

abstract class LoginRepo {
  Future<Either<Failure, String>> login({
    required String phone,
    required String password,
    required int companyId,
  });
}

