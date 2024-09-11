import 'package:dio/dio.dart';

class AuthService {
  final Dio _dio = Dio();
  static const _url = 'http://localhost:3000';
  String? _token;

  Future<Response> login(String body) async {
    try {
      const url = '$_url/login/authenticate';
      final response = await _dio.post(url, data: body);
      _token = response.data['token'];
      return response;
    } on DioError {
      rethrow;
    }
  }

  Future<Response> logout() async {
    try {
      const url = '$_url/login/logout';
      final response = await _dio.get(
        url,
        options: Options(
          headers: {
            'Authorization': _token,
          },
        ),
      );
      // Limpiar el token después del logout
      _token = null;
      return response;
    } on DioError {
      rethrow;
    }
  }

  String? getToken() {
    return _token;
  }
}
