import 'package:dio/dio.dart';
import '../../home/home_models.dart';

class IotService {
  final Dio _dio = Dio();
  static const String _baseUrl = 'http://localhost:3000/api';

  Future<HomeItem> fetchHierarchy() async {
    const url = '$_baseUrl/hierarchy';
    try {
      final response = await _dio.get(url);
      return HomeItem.fromJson(response.data);
    } on DioError catch (e) {
      print('Error: $e');
      rethrow;
    }
  }
}
