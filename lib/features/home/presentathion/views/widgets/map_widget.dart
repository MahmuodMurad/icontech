import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:icontech/core/utils/app_colors.dart';
import 'package:icontech/core/utils/styles.dart';

import '../../../../../core/utils/assets/asset_images.dart';
import '../../../../../generated/l10n.dart';
import '../../../data/models/location_model.dart';
import '../../../../products/presentation/view/branch_detail_screen.dart';

class MapWidget extends StatefulWidget {
  final List<Location> locations;

  MapWidget({required this.locations});

  @override
  _MapWidgetState createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  late GoogleMapController _controller;
  Location? _selectedLocation;
  Set<Marker> markers = {};

  @override
  void initState() {
    super.initState();
    _loadMarkers();
  }

  Future<void> _loadMarkers() async {
    for (var location in widget.locations) {
      final BitmapDescriptor markerIcon = await _createMarkerImageFromAsset(AssetsImg.markerImage);
      markers.add(
        Marker(
          markerId: MarkerId(location.id.toString()),
          position: LatLng(location.lat, location.lng),
          icon: markerIcon,
          onTap: () {
            setState(() {
              _selectedLocation = location;
            });
          },
        ),
      );
    }

    setState(() {});
  }

  Future<BitmapDescriptor> _createMarkerImageFromAsset(String assetPath) async {
    final ByteData byteData = await rootBundle.load(assetPath);
    final Uint8List imageBytes = byteData.buffer.asUint8List();

    final Completer<ui.Image> completer = Completer();
    ui.decodeImageFromList(imageBytes, (ui.Image image) {
      completer.complete(image);
    });
    final ui.Image image = await completer.future;

    final ui.Image resizedImage = await _resizeImage(image, width: 100);

    final ByteData? resizedByteData = await resizedImage.toByteData(format: ui.ImageByteFormat.png);
    final Uint8List resizedImageBytes = resizedByteData!.buffer.asUint8List();

    return BitmapDescriptor.fromBytes(resizedImageBytes);
  }

  Future<ui.Image> _resizeImage(ui.Image image, {required int width}) async {
    final double scale = width / image.width;
    final height = (image.height * scale).toInt();

    final ui.PictureRecorder recorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(recorder, Rect.fromLTWH(0, 0, width.toDouble(), height.toDouble()));

    final Paint paint = Paint();
    canvas.drawImageRect(
      image,
      Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble()),
      Rect.fromLTWH(0, 0, width.toDouble(), height.toDouble()),
      paint,
    );

    final ui.Image resizedImage = await recorder.endRecording().toImage(width, height);
    return resizedImage;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          initialCameraPosition: CameraPosition(
            target: LatLng(widget.locations.first.lat, widget.locations.first.lng),
            zoom: 14,
          ),
          markers: markers,
          onMapCreated: (controller) {
            _controller = controller;
          },
          onTap: (_) {
            setState(() {
              _selectedLocation = null;
            });
          },
        ),
        if (_selectedLocation != null) _buildLocationDetails(_selectedLocation!),
      ],
    );
  }

  Widget _buildLocationDetails(Location location) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.kWhiteColor,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          padding: const EdgeInsets.all(16),
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: NetworkImage(location.image),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        location.titleAr,
                        style: Styles.textStyle16.copyWith(fontWeight: FontWeight.bold, color: AppColors.kBlackColor),
                      ),
                      Text(
                        "${S.of(context).phone}: ${location.phone}",
                        style: Styles.textStyle16.copyWith(fontWeight: FontWeight.bold, color: AppColors.kGreyShade),
                      ),
                    ],
                  ),
                ],
              ),
              const Divider(thickness: 1, color: AppColors.kGreyShade),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.my_location,
                    size: 30,
                    color: AppColors.kBlackColor,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        S.of(context).branch_address,
                        style: Styles.textStyle14.copyWith(fontWeight: FontWeight.bold, color: AppColors.kGreyShade),
                      ),
                      SizedBox(
                        width: 250,
                        child: Text(
                          location.addressAr,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Styles.textStyle16.copyWith(fontWeight: FontWeight.bold, color: AppColors.kBlackColor),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.location_on,
                    size: 30,
                    color: AppColors.kBlackColor,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        S.of(context).time_to_arrive,
                        style: Styles.textStyle14.copyWith(fontWeight: FontWeight.bold, color: AppColors.kGreyShade),
                      ),
                      Text(
                        location.distance.toStringAsFixed(1),
                        style: Styles.textStyle16.copyWith(fontWeight: FontWeight.bold, color: AppColors.kBlackColor),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),
              location.status == 1
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BranchDetailScreen(locationId: location.id),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.kWhiteColor,
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(color: AppColors.kPrimaryColor, width: 1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: Text(
                            S.of(context).open,
                            style: Styles.textStyle14.copyWith(
                              color: AppColors.kBlackColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.kRedColor,
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(color: AppColors.kPrimaryColor, width: 1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: Text(
                            S.of(context).close,
                            style: Styles.textStyle14.copyWith(
                              color: AppColors.kBlackColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
