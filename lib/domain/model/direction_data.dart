class Direction {
  final List<Route> routes;
  final String code;
  final String uuid;

  Direction({
    required this.routes,
    required this.code,
    required this.uuid,
  });

  factory Direction.fromJson(Map<String, dynamic> json) {
    return Direction(
      routes: List<Route>.from(json['routes'].map((x) => Route.fromJson(x))),
      code: json['code'],
      uuid: json['uuid'],
    );
  }
}

class Route {
  final String weightName;
  final double weight;
  final double duration;
  final double distance;
  final Geometry geometry;

  Route({
    required this.weightName,
    required this.weight,
    required this.duration,
    required this.distance,
    required this.geometry,
  });

  factory Route.fromJson(Map<String, dynamic> json) {
    return Route(
      weightName: json['weight_name'],
      weight: json['weight'],
      duration: json['duration'],
      distance: json['distance'],
      geometry: Geometry.fromJson(json['geometry']),
    );
  }
}

class Geometry {
  final List<List<double>> coordinates;

  Geometry({required this.coordinates});

  factory Geometry.fromJson(Map<String, dynamic> json) {
    return Geometry(
      coordinates: List<List<double>>.from(json['coordinates']
          .map((x) => List<double>.from(x.map((x) => x.toDouble())))),
    );
  }
}
