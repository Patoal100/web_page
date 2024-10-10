import 'package:dio/dio.dart';
import '../../home/home_models.dart';

class IotService {
  final Dio _dio = Dio();
  static const String _baseUrl = 'http://localhost:3000/api';

  Future<HomeItem> fetchHierarchy() async {
    const url = '$_baseUrl/hierarchy';
    try {
      final response = await _dio.get(url);
      return HomeItem.fromJson(response.data as Map<String, dynamic>);
    } on DioError catch (e) {
      throw Exception('Failed to load hierarchy: ${e.message}');
    }
  }
}
