import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:belajar_flutter/services/login_service.dart';

import 'package:belajar_flutter/views/general/login_v1.dart';
// import halaman sesuai role
import 'package:belajar_flutter/views/admin/comboard/index.dart';
import 'package:belajar_flutter/views/student/comboard/index.dart';
// import 'package:belajar_flutter/views/parent/home.dart';

class LoginController {
  final LoginService _loginService = LoginService();

  Future<void> handleLogin({
    required BuildContext context,
    required String username,
    required String password,
    required String loginTo,
    required bool show,
    required bool remember,
    required VoidCallback onStart,
    required VoidCallback onFinish,
  }) async {
    onStart();

    try {
      // ✅ Validasi manual sebelum call API
      if (loginTo == "Internal" && !username.toLowerCase().contains("admin")) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Username or password not valid."),
            backgroundColor: Colors.red,
          ),
        );
        onFinish();
        return;
      }

      if (loginTo == "Student" && !username.contains("@")) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Username or password not valid."),
            backgroundColor: Colors.red,
          ),
        );
        onFinish();
        return;
      }

      final response = await _loginService.login(
        username: username.trim(),
        password: password.trim(),
        loginTo: loginTo,
        show: show,
        remember: remember ? ['remember'] : [],
      );

      if (response.data['status'] == true) {
        final token = response.data['access_token'];
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('access_token', token);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Login berhasil!"),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ),
        );

        // redirect sesuai role
        Widget page;
        if (loginTo == "Internal") {
          page = const ComboardAdminScreen(); // admin
        } else if (loginTo == "Student") {
          page = const ComboardStudentScreen();
        } else {
          page = const LoginScreen(); // fallback
        }

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(response.data['message'] ?? "Login gagal."),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 2),
          ),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error: $error"),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 2),
        ),
      );
    } finally {
      onFinish();
    }
  }

}
