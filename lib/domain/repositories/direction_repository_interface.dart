import 'package:demo_google_ads/common/enum.dart';
import 'package:demo_google_ads/domain/model/direction_data.dart';

abstract class DirectionRepositoryInterface {
  Future<Direction?> fetchDirectionData(
      String startPoint, String endPoint, RoutingProfile routingProfile);
}
