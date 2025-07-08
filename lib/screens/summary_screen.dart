import 'package:flutter/material.dart';

class SummaryScreen extends StatelessWidget {
  const SummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('📍 Resumen de Medición'),
        actions: [
          IconButton(
            icon: const Icon(Icons.cancel),
            onPressed: () => Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false),
          )
        ],
      ),
      body: const Center(
        child: Text('Aquí se mostrará el mapa y resumen'),
      ),
    );
  }
}
