import 'dart:async';
import 'dart:developer';
import 'package:demo_google_ads/common/enum.dart';
import 'package:demo_google_ads/common/util/app_convert.dart';
import 'package:demo_google_ads/domain/model/direction_data.dart';
import 'package:demo_google_ads/domain/model/mission_location.dart';
import 'package:demo_google_ads/persenstation/app_controller/app_controller.dart';
import 'package:demo_google_ads/persenstation/page/flutter_map.dart/views/widget/current_marker.dart';
import 'package:demo_google_ads/persenstation/page/flutter_map.dart/views/widget/mission_marker.dart';
import 'package:demo_google_ads/remote/repositories/direction_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart' as latLng;

class MapViewController extends GetxController with AppController {
  // main
  RoutingProfile routingProfile = RoutingProfile.driving;
  Rx<MapType> mapType = MapType.normal.obs;
  //mapController
  MapController mapController = MapController();
  late Rx<Position?> _currentPosition;
  RxDouble zoomLevel = 14.0.obs;

  // Marker currentMarkers = .obs;
  RxList<Marker> missionMarkers = <Marker>[].obs;
  List<bool> missionMarkerStatus = <bool>[];
  RxInt selectedMarker = (-1).obs;
  //mission
  List<Map<String, double>> coordinates = <Map<String, double>>[];

  //direction
  DirectionRepository directionRepository = DirectionRepository();
  RxList<Polyline> polylines = <Polyline>[].obs;
  RxInt selectedPolyline = 0.obs;
  Direction? direction;

  Position? get currentPosition => _currentPosition.value;

  @override
  void onInit() async {
    super.onInit();
    _currentPosition = Position(
      latitude: 10.762622,
      longitude: 106.660172,
      timestamp: DateTime.now(),
      accuracy: 0,
      altitude: 0,
      heading: 0,
      speed: 0,
      speedAccuracy: 0,
    ).obs;
    mapController = MapController();
    coordinates = dataMissionMarker();
    missionMarkerStatus
        .addAll(List.generate(coordinates.length, (index) => false));
    await getCurrentLocation();
  }

  @override
  void onReady() {
    super.onReady();

    listenCurrentLocation();
    addMissionMarker();
  }

  @override
  void onClose() {
    super.onClose();
    mapController.dispose();
  }

  //Geolocator
  Future<bool> checkLocationPermissions() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return true;
  }

  Future getCurrentLocation() async {
    appLoadingState.value = AppLoadingState.start;
    if (await checkLocationPermissions()) {
      _currentPosition.value = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      log('${_currentPosition.value?.latitude.toString()}, ${_currentPosition.value?.longitude.toString()}');
    }
    appLoadingState.value = AppLoadingState.end;
  }

  Future listenCurrentLocation() async {
    if (await checkLocationPermissions()) {
      const LocationSettings locationSettings = LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 0,
      );

      Geolocator.getPositionStream(locationSettings: locationSettings)
          .listen((Position? position) {
        _currentPosition.value = position;

        log('${position?.latitude.toString()}, ${position?.longitude.toString()}');
      });
    }
  }

  Future getDirection() async {
    if (selectedMarker.value == -1) {
      return;
    }
    try {
      direction = await directionRepository.fetchDirectionData(
          '${_currentPosition.value?.longitude ?? 0},${_currentPosition.value?.latitude ?? 0}',
          '${coordinates[selectedMarker.value]['longitude']},${coordinates[selectedMarker.value]['latitude']}',
          routingProfile);
    } catch (e) {
      log(e.toString());
    }
  }

  void onSelectedMarker(int index) async {
    selectedMarker.value = index;
    await getDirection();
    updateMissionMarker(index);
  }

  List<latLng.LatLng> getRoute(List<List<double>> coordinates) {
    List<latLng.LatLng> route = [];
    for (var element in coordinates) {
      route.add(latLng.LatLng(element[1], element[0]));
    }
    return route;
  }

  void addPolyline() {
    polylines.clear();
    selectedPolyline.value = 0;

    for (var i = 0; i < direction!.routes.length; i++) {
      polylines.add(Polyline(
        points: getRoute(direction!.routes[i].geometry.coordinates),
        strokeWidth: 4.0,
        color: selectedPolyline.value == i ? Colors.blue : Colors.grey,
      ));
    }
  }

  // void updatePolyline(int index) {
  //   selectedPolyline.value = index;
  //   for (var i = 0; i < polylines.length; i++) {
  //     polylines[i] = Polyline(
  //       points: getRoute(direction!.routes[i].geometry.coordinates),
  //       strokeWidth: 4.0,
  //       color: selectedPolyline.value == i ? Colors.blue : Colors.grey,
  //     );
  //   }
  // }

  void moveToCurrentLocation() {
    double lat = ((_currentPosition.value?.latitude ?? 0));
    double long = ((_currentPosition.value?.longitude ?? 0));
    zoomLevel = 17.0.obs;
    mapController.move(latLng.LatLng(lat, long), zoomLevel.value);
  }

  Marker markerCurrentLocation() {
    return Marker(
      width: 80.0,
      height: 80.0,
      point: latLng.LatLng(_currentPosition.value?.latitude ?? 0,
          _currentPosition.value?.longitude ?? 0),
      builder: (ctx) => const CurrentMarker(),
    );
  }

  Marker configMarker(
    int index,
    Map<String, double> point,
    double distance,
  ) {
    return Marker(
      width: 80.0,
      height: 80.0,
      point: latLng.LatLng(point['latitude'] ?? 102, point['longitude'] ?? 26),
      builder: (ctx) => MissionMarker(
        distance: AppConVert.convertMtoKm(distance),
        isShow: missionMarkerStatus[index],
        onTap: () {
          updateMissionMarker(index);
        },
      ),
    );
  }

  void addMissionMarker() {
    log('addMissionMarker');
    missionMarkers.clear();
    for (int i = 0; i < coordinates.length; i++) {
      missionMarkers.add(
        configMarker(i, coordinates[i], 0),
      );
    }
  }

  void updateMissionMarker(int index) async {
    missionMarkerStatus[index] = !missionMarkerStatus[index];
    selectedMarker.value = index;
    await getDirection();
    for (int i = 0; i < missionMarkerStatus.length; i++) {
      if (i != index) {
        missionMarkerStatus[i] = false;
      }
    }
    polylines.clear();
    missionMarkers[index] = configMarker(
        index, coordinates[index], direction?.routes.first.distance ?? 0);
  }

  void changeRoutingProfile(RoutingProfile option) {
    routingProfile = option;
    polylines.clear();
    getDirection();
  }

  void changeMapType(MapType value) {
    mapType.value = value;
  }
}
