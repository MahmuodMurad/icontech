import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../core/api/api_service.dart';
import '../../../../core/api/end_points.dart';
import '../../../../core/errors/failure.dart';
import '../models/location_model.dart';
import 'home_repo.dart';

class HomeRepoImpl implements HomeRepo {
  final ApiService apiService;

  HomeRepoImpl(this.apiService);

  @override
  Future<Either<Failure, List<Location>>> fetchLocations(double lat, double lng, int companyId) async {
    try {
      final response = await apiService.get(
        endPoint: EndPoints.branches,
        queryParameters: {'lat': lat, 'long': lng, 'company_id': companyId},
      );
      final List<Location> locations = (response['data'] as List).map((json) => Location.fromJson(json)).toList();
      return Right(locations);
    } catch (error) {
      return Left(ServerFailure(error.toString()));
    }
  }
}
