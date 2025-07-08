import 'package:flutter/material.dart';

class MeasurementScreen extends StatelessWidget {
  const MeasurementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('📊 Medición'),
        actions: [
          IconButton(
            icon: const Icon(Icons.cancel),
            onPressed: () => Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false),
          )
        ],
      ),
      body: const Center(
        child: Text('Aquí se medirán las vibraciones'),
      ),
    );
  }
}
