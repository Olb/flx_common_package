library flx_common_package;

/// Position given in latitude and longitude
///
/// `latitude` double latitude
/// `longitude` double longitude
class Position {
  double latitude;
  double longitude;

  /// `latitude` and `longitude` as double
  Position(this.latitude, this.longitude);

  Position.fromJson(Map<dynamic, dynamic> json)
      : latitude = json['latitude'],
        longitude = json['longitude'];

  Map<String, double> toJson() =>
      {'latitude': latitude, 'longitude': longitude};


  Position.fromMap(Map<dynamic, dynamic> j) {
    latitude = j['latitude'];
    longitude = j['longitude'];
  }
}


