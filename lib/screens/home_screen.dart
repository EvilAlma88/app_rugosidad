import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inicio - Rugosidad Vial'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton.icon(
              icon: const Icon(Icons.add),
              label: const Text('Crear nuevo proyecto'),
              onPressed: () => Navigator.pushNamed(context, '/create'),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              icon: const Icon(Icons.tune),
              label: const Text('Calibrar sensor'),
              onPressed: () => Navigator.pushNamed(context, '/calibrate'),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              icon: const Icon(Icons.speed),
              label: const Text('Verificar velocidad'),
              onPressed: () => Navigator.pushNamed(context, '/speed'),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              icon: const Icon(Icons.stacked_line_chart),
              label: const Text('Iniciar medición'),
              onPressed: () => Navigator.pushNamed(context, '/measure'),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              icon: const Icon(Icons.map),
              label: const Text('Ver resumen'),
              onPressed: () => Navigator.pushNamed(context, '/summary'),
            ),
          ],
        ),
      ),
    );
  }
}
