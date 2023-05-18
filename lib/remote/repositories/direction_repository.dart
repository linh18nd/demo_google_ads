import 'package:demo_google_ads/common/enum.dart';
import 'package:demo_google_ads/domain/model/direction_data.dart';
import 'package:demo_google_ads/domain/repositories/direction_repository_interface.dart';
import 'package:demo_google_ads/remote/providers/api_service.dart';

class DirectionRepository implements DirectionRepositoryInterface {
  final ApiService _apiService = ApiService();

  DirectionRepository();

  @override
  Future<Direction?> fetchDirectionData(
      String startPoint, String endPoint, RoutingProfile routingProfile) async {
    try {
      final directionResponse = await _apiService.fetchDirectionData(
          startPoint, endPoint, routingProfile);
      final directionData = Direction.fromJson(directionResponse);
      return directionData;
    } catch (e) {
      throw Exception('Failed to fetch direction data: $e');
    }
  }
}
