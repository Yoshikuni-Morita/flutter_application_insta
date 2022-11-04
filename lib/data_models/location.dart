class Location {
  final double latitude;
  final double longitude;
  final String coutry;
  final String state;
  final String city;

//<editor-fold desc="Data Methods">

  const Location({
    required this.latitude,
    required this.longitude,
    required this.coutry,
    required this.state,
    required this.city,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Location &&
          runtimeType == other.runtimeType &&
          latitude == other.latitude &&
          longitude == other.longitude &&
          coutry == other.coutry &&
          state == other.state &&
          city == other.city);

  @override
  int get hashCode =>
      latitude.hashCode ^
      longitude.hashCode ^
      coutry.hashCode ^
      state.hashCode ^
      city.hashCode;

  @override
  String toString() {
    return 'Location{' +
        ' latitude: $latitude,' +
        ' longitude: $longitude,' +
        ' coutry: $coutry,' +
        ' state: $state,' +
        ' city: $city,' +
        '}';
  }

  Location copyWith({
    double? latitude,
    double? longitude,
    String? coutry,
    String? state,
    String? city,
  }) {
    return Location(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      coutry: coutry ?? this.coutry,
      state: state ?? this.state,
      city: city ?? this.city,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'latitude': this.latitude,
      'longitude': this.longitude,
      'coutry': this.coutry,
      'state': this.state,
      'city': this.city,
    };
  }

  factory Location.fromMap(Map<String, dynamic> map) {
    return Location(
      latitude: map['latitude'] as double,
      longitude: map['longitude'] as double,
      coutry: map['coutry'] as String,
      state: map['state'] as String,
      city: map['city'] as String,
    );
  }

//</editor-fold>
}
