class Location {
  final int id;
  final String titleEn;
  final String titleAr;
  final String phone;
  final double lat;
  final double lng;
  final String addressEn;
  final String addressAr;
  final String statusEn;
  final String statusAr;
  final String image;
  final double distance;
  final int status;

  Location( {
    required this.status,
    required this.distance,
    required this.id,
    required this.titleEn,
    required this.titleAr,
    required this.phone,
    required this.lat,
    required this.lng,
    required this.addressEn,
    required this.addressAr,
    required this.statusEn,
    required this.statusAr,
    required this.image,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      status: json['status_no'],
      distance: json['distance'],
      id: json['id'],
      titleEn: json['title']['en'],
      titleAr: json['title']['ar'],
      phone: json['phone'],
      lat: double.parse(json['lat']),
      lng: double.parse(json['long']),
      addressEn: json['address']['en'],
      addressAr: json['address']['ar'],
      statusEn: json['status_en'],
      statusAr: json['status_ar'],
      image: json['image'],
    );
  }
}
