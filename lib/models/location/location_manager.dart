import 'dart:async';

import 'package:geocoding/geocoding.dart' as geoCoding;
import 'package:geolocator/geolocator.dart';
import 'package:insta_clone/data_models/location.dart';

class LocationManager {
  Future<Location> getCurrentLocation() async {
    final isLocationServiceEnable = await Geolocator.isLocationServiceEnabled();
    if (!isLocationServiceEnable) {
      return Future.error("オフになってます");
    }

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error("拒否されたぁ");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error("リクエストできないっぴ");
    }

    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    final placeMarks = await geoCoding.placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );
    final placeMark = placeMarks.first;

    return Future.value(convert(
      placeMark,
      position.latitude,
      position.longitude,
    ));
  }
  Future<Location> updateLocation(double latitude, double longitude) async {
    final placeMarks = await geoCoding.placemarkFromCoordinates(
      latitude,
      longitude,
    );
    final placeMark = placeMarks.first;

    return Future.value(convert(
      placeMark,
      latitude,
      longitude,
    ));
  }

  Location convert(
      geoCoding.Placemark placeMark, double latitude, double longitude) {
    return Location(
      latitude: latitude,
      longitude: longitude,
      coutry: placeMark.country ?? "",
      state: placeMark.administrativeArea ?? "",
      city: placeMark.locality ?? "",
    );
  }

}
