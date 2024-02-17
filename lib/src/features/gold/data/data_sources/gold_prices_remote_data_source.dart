import '/src/core/constants/end_points.dart';
import '/src/core/network/web_service.dart';

abstract class GoldPricesRemoteDataSource {
  Future<Map<String, dynamic>> getGoldPricesRawData();
}

class GoldPricesRemoteDataSourceImpl implements GoldPricesRemoteDataSource {
  GoldPricesRemoteDataSourceImpl({required this.webService});

  final WebService webService;

  @override
  Future<Map<String, dynamic>> getGoldPricesRawData() async {
    return await webService.getRequest(path: kXAUTOEGPPriceEndpoint);
  }
}
