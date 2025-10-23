import 'package:dio/dio.dart';

class LoginService {
  final Dio _dio = Dio();

  // 
  Future<Response> login({
    required String username,
    required String password,
    required String loginTo,
    required bool show,
    required List<String> remember,
  }) async {
    try {
      Response response = await _dio.post(
        'https://edu-demo.amatraedu.com:8081/api/v1/auth/login/',
        data: {
          "username": username,
          "password": password,
          "loginto": loginTo,
          "show": show,
          "remember": remember,
        },
      );
      return response;
    } catch (error) {
      throw Exception("Login gagal: $error");
    }
  }
}