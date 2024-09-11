import 'package:dio/dio.dart';
import 'package:flutter_web/src/data/services/iot_services.dart';
import 'package:flutter_web/src/home/home_models.dart';

class IotRepository {
  final IotService _iotService;
  const IotRepository(this._iotService);

  Future<HomeItem> fetchHierarchy() async {
    try {
      final response = await _iotService.fetchHierarchy();
      return response;
    } on DioError catch (e) {
      print('Error: $e');
      rethrow;
    }
  }
}
