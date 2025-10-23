import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:belajar_flutter/controllers/comboard_controller.dart';
import 'package:belajar_flutter/views/general/login_v2.dart';
import 'package:belajar_flutter/Component/card.dart';

class ComboardStudentScreen extends StatelessWidget {
  const ComboardStudentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ComboardController()..loadAllComboard(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Comboard"),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                );

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Anda telah logout"),
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
              return const Center(child: Text("Tidak ada data"));
            }

            return ListView.builder(
              itemCount: controller.comboardData.length,
              itemBuilder: (context, index) {
                final item = controller.comboardData[index];
                return ComboardCard(
                  item: item,
                  loginto: "Student",
                );
              },
            );
          },
        ),
      ),
    );
  }
}
