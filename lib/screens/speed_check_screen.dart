import 'package:flutter/material.dart';

class SpeedCheckScreen extends StatelessWidget {
  const SpeedCheckScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🚗 Verificar Velocidad'),
        actions: [
          IconButton(
            icon: const Icon(Icons.cancel),
            onPressed: () => Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false),
          )
        ],
      ),
      body: const Center(
        child: Text('Aquí irá la verificación de velocidad'),
      ),
    );
  }
}