import 'dart:convert';
import 'dart:developer';

import 'package:demo_google_ads/common/constaint.dart';
import 'package:demo_google_ads/common/enum.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = Constaints.baseUrl;

  Future<Map<String, dynamic>> fetchDirectionData(
      String startPoint, String endPoint, RoutingProfile profile) async {
    final url =
        '$baseUrl/${profile.name}/$startPoint%3B$endPoint?alternatives=false&continue_straight=true&geometries=geojson&language=en&overview=simplified&steps=true&access_token=${Constaints.publicToken}';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final jsonData = response.body;
      final result = json.decode(jsonData);
      final directionData =
          Map<String, dynamic>.from(result as Map<String, dynamic>);
      return directionData;
    } else {
      throw Exception('Failed to fetch direction data');
    }
  }
}
