import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../../core/utils/service_locator.dart';
import '../../data/repos/home_repo_impl.dart';
import '../view_model/map_cubit.dart';
import 'widgets/map_widget.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  Future<Position?> _getCurrentLocation() async {
    try {
      final status = await Permission.locationWhenInUse.request();
      if (status == PermissionStatus.granted) {
        return await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );
      } else {
        print('Location permission denied');
        return null;
      }
    } catch (e) {
      print('Error in _getCurrentLocation: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Position?>(
      future: _getCurrentLocation(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError || !snapshot.hasData) {
          String errorMessage = snapshot.hasError ? 'Error: ${snapshot.error}' : 'No location data';
          print(errorMessage);
          return Scaffold(
            body: Center(child: Text(errorMessage)),
          );
        } else {
          final position = snapshot.data!;
          print('Position obtained: ${position.latitude}, ${position.longitude}');
          return BlocProvider(
            create: (context) => MapCubit(
              getIt.get<HomeRepoImpl>(),
            )..fetchLocations(position.latitude, position.longitude, 3),
            child: Scaffold(
              body: BlocBuilder<MapCubit, MapState>(
                builder: (context, state) {
                  if (state is MapInitial) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is MapLoaded) {
                    return MapWidget(locations: state.locations);
                  } else if (state is MapError) {
                    return Center(child: Text(state.message));
                  } else {
                    return Container();
                  }
                },
              ),
            ),
          );
        }
      },
    );
  }
}
