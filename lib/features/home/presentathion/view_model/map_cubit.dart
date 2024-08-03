import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../../data/models/location_model.dart';
import '../../data/repos/home_repo.dart';

part 'map_state.dart';

class MapCubit extends Cubit<MapState> {
  final HomeRepo homeRepo;

  MapCubit(this.homeRepo) : super(MapInitial());

  void fetchLocations(double lat, double lng, int companyId) async {
    emit(MapInitial());
    final Either<Failure, List<Location>> result = await homeRepo.fetchLocations(lat, lng, companyId);
    result.fold(
          (failure) => emit(MapError(message: failure.errMessage)),
          (locations) => emit(MapLoaded(locations: locations)),
    );
  }
}
