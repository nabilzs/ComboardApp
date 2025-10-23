import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:belajar_flutter/controllers/comboard_controller.dart';
import 'package:belajar_flutter/views/general/login_v2.dart';
import 'package:belajar_flutter/Component/card.dart';

class ComboardAdminScreen extends StatefulWidget {
  const ComboardAdminScreen({super.key});

  @override
  State<ComboardAdminScreen> createState() => _ComboardAdminScreenState();
}

class _ComboardAdminScreenState extends State<ComboardAdminScreen> {
  int _visibleCount = 5;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ComboardController()..loadAllComboard(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Academic Comboard",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.blue[900],
          actions: [
            IconButton(
              icon: const Icon(Icons.logout, color: Colors.white),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                );

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("You have been logged out"),
                    backgroundColor: Colors.red,
                    duration: Duration(seconds: 2),
                  ),
                );
              },
            ),
          ],
        ),
        body: Consumer<ComboardController>(
          builder: (context, controller, _) {
            if (controller.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (controller.comboardData.isEmpty) {
              return const Center(child: Text("No data found"));
            }

            final totalItems = controller.comboardData.length;
            final data = controller.comboardData.take(_visibleCount).toList();

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      final item = data[index];
                      return ComboardCard(
                        item: item,
                        loginto: "Internal",
                      );
                    },
                  ),
                ),
                if (_visibleCount < totalItems)
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _visibleCount += 5;
                        if (_visibleCount > totalItems) {
                          _visibleCount = totalItems;
                        }
                      });
                    }, style: TextButton.styleFrom(
                      backgroundColor: Colors.blue[900],
                    ),
                    child: const Text(
                      "Show more",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
