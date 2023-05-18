import 'dart:developer';

import 'package:demo_google_ads/common/constaint.dart';
import 'package:demo_google_ads/common/enum.dart';
import 'package:demo_google_ads/persenstation/page/flutter_map.dart/controllers/map_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as latLng;

class MapView extends GetView<MapViewController> {
  const MapView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Map'),
        actions: <Widget>[
          PopupMenuButton<RoutingProfile>(
            onSelected: (RoutingProfile option) {
              controller.changeRoutingProfile(option);
            },
            itemBuilder: (BuildContext context) =>
                <PopupMenuEntry<RoutingProfile>>[
              const PopupMenuItem<RoutingProfile>(
                value: RoutingProfile.traffic,
                child: Text('Traffic'),
              ),
              const PopupMenuItem<RoutingProfile>(
                value: RoutingProfile.driving,
                child: Text('Driving'),
              ),
              const PopupMenuItem<RoutingProfile>(
                value: RoutingProfile.walking,
                child: Text('Walking'),
              ),
              const PopupMenuItem<RoutingProfile>(
                value: RoutingProfile.cycling,
                child: Text('Cycling'),
              ),
            ],
          ),
        ],
      ),
      body: Obx(
        () => controller.appLoadingState.value == AppLoadingState.start
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Stack(
                children: [
                  _buildMapView(context),
                  _routingMap(context),
                  _mapControls(context),
                ],
              ),
      ),
    );
  }

  Widget _routingMap(BuildContext context) {
    return Positioned(
      bottom: 40,
      right: 30,
      child: Column(
        children: [
          InkWell(
            onTap: () {
              controller.addPolyline();
            },
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 0.5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: const Icon(
                Icons.fmd_good_outlined,
                color: Colors.blue,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              controller.moveToCurrentLocation();
            },
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 0.5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: const Icon(
                Icons.my_location,
                color: Colors.blue,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _mapControls(BuildContext context) {
    return Positioned(
      top: 30,
      right: 30,
      child: InkWell(
        onTap: () {
          showMapType(context);
        },
        child: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 0.5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: const Icon(
            Icons.map_outlined,
            color: Colors.blue,
          ),
        ),
      ),
    );
  }

  Widget _buildMapView(BuildContext context) {
    return Positioned(
      child: FlutterMap(
        options: MapOptions(
          center: latLng.LatLng(controller.currentPosition?.latitude ?? 26,
              controller.currentPosition?.longitude ?? 106),
          zoom: controller.zoomLevel.value,
          maxZoom: 18,
          minZoom: 0,
        ),
        nonRotatedChildren: [
          AttributionWidget.defaultWidget(
            source: 'Mapbox',
            onSourceTapped: () async {},
          ),
        ],
        mapController: controller.mapController,
        children: [
          Obx(
            () => TileLayer(
              urlTemplate: controller.mapType.value == MapType.normal
                  ? Constaints.normalMapType
                  : Constaints.satelliteMapType,
              additionalOptions: const {
                'token': Constaints.publicToken,
                'id': 'mapbox.mapbox-streets-v8',
              },
              userAgentPackageName: 'com.example.app',
            ),
          ),
          Obx(
            () => PolylineLayer(
              polylines: controller.polylines.toList(),
            ),
          ),
          Obx(
            () => MarkerLayer(
              rotateOrigin: const Offset(-0.5, -0.5),
              markers: controller.missionMarkers.toList(),
            ),
          ),
          Obx(
            () => MarkerLayer(
              rotateOrigin: const Offset(-0.5, -0.5),
              markers: [controller.markerCurrentLocation()],
            ),
          ),
        ],
      ),
    );
  }

  void showMapType(context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: 100,
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    controller.changeMapType(MapType.normal);
                    Get.back();
                  },
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 0.5,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.map_outlined,
                      color: Colors.blue,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    controller.changeMapType(MapType.satellite);
                    Get.back();
                  },
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 0.5,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.satellite_outlined,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
