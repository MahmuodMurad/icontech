part of 'map_cubit.dart';

@immutable
abstract class MapState {}

class MapInitial extends MapState {}

class MapLoaded extends MapState {
  final List<Location> locations;
  MapLoaded({required this.locations});
}

class MapError extends MapState {
  final String message;
  MapError({required this.message});
}
