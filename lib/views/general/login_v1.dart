import 'package:flutter/material.dart';
import 'package:belajar_flutter/controllers/login_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // 
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  
  // 
  bool _isLoading = false;
  String _selectedLoginTo = 'Internal';
  final bool _show = true;
  bool _remember = false;

  // 
  final LoginController _controller = LoginController();

  // 
  void _onLoginPressed() {
    // 
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
  Widget build(BuildContext context) {
    return Scaffold(
      // 
      appBar: AppBar(
        title: const Text('Login'),
      ),

      // 
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(labelText: "Username"),
                validator: (value) =>
                    value!.isEmpty ? "Username cannot be empty" : null,
              ),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: "Password"),
                validator: (value) =>
                    value!.isEmpty ? "Password cannot be empty" : null,
                obscureText: true,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                initialValue: _selectedLoginTo,
                items: const [
                  DropdownMenuItem(value: 'Internal', child: Text('Internal')),
                  DropdownMenuItem(value: 'External', child: Text('External')),
                ],
                onChanged: (value) =>
                    setState(() => _selectedLoginTo = value!),
                decoration: const InputDecoration(labelText: "Login To"),
              ),
              CheckboxListTile(
                title: const Text("Remember me"),
                value: _remember,
                onChanged: (value) => setState(() => _remember = value!),
              ),
              const SizedBox(height: 20),
              _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                      onPressed: _onLoginPressed,
                      child: const Text("Login"),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}