import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../models/location_model.dart';

abstract class HomeRepo {
  Future<Either<Failure, List<Location>>> fetchLocations(double lat, double lng, int companyId);
}
