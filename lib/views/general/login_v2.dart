import 'package:flutter/material.dart';
import 'package:belajar_flutter/controllers/login_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLoading = false;
  bool _remember = false;
  bool _obscurePassword = true;
  final bool _show = true;
  String _selectedLoginTo = 'Internal';

  // Controller
  final LoginController _controller = LoginController();

  // Handle Login
  void _onLoginPressed() {
    if (_formKey.currentState!.validate()) {
      _controller.handleLogin(
        context: context,
        username: _usernameController.text,
        password: _passwordController.text,
        loginTo: _selectedLoginTo,
        show: _show,
        remember: _remember,
        onStart: () => setState(() => _isLoading = true),
        onFinish: () => setState(() => _isLoading = false),
      );
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(30.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Title
                const Text(
                  'Welcome',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    fontSize: 26,
                    color: Color(0xFF1C1C1C),
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Sign In to continue',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.normal,
                    fontSize: 18,
                    color: Color(0xFF1C1C1C),
                  ),
                ),

                const SizedBox(height: 26),

                // Username
                TextFormField(
                  controller: _usernameController,
                  decoration: const InputDecoration(
                    labelText: 'Username',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                      value!.isEmpty ? "Username cannot be empty" : null,
                ),
                const SizedBox(height: 16),

                // Password
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                  ),
                  validator: (value) =>
                      value!.isEmpty ? "Password cannot be empty" : null,
                  obscureText: _obscurePassword,
                ),

                const SizedBox(height: 16),

                // Dropdown LoginTo
                DropdownButtonFormField<String>(
                  initialValue: _selectedLoginTo.isEmpty ? null : _selectedLoginTo,
                  items: const [
                    DropdownMenuItem(
                      value: null,
                      enabled: false,
                      child: Text(
                        'Select',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    DropdownMenuItem(value: 'Parent', child: Text('Parent')),
                    DropdownMenuItem(value: 'Student', child: Text('Student')),
                    DropdownMenuItem(value: 'Internal', child: Text('Internal')),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      setState(() => _selectedLoginTo = value);
                    }
                  },
                  decoration: const InputDecoration(
                    labelText: "Login To",
                    border: OutlineInputBorder(),
                  ),
                ),


                // Remember Me
                CheckboxListTile(
                  title: const Text("Remember me"),
                  value: _remember,
                  onChanged: (value) => setState(() => _remember = value ?? false),
                ),

                const SizedBox(height: 26),

                // Login Button
                SizedBox(
                  width: double.infinity,
                  height: 49,
                  child: _isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : ElevatedButton(
                          onPressed: _onLoginPressed,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF3B62FF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            'Login',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
