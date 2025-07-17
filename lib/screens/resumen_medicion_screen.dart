import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/medicion.dart';

class SummaryScreen extends StatelessWidget {
  final Medicion medicion;

  const SummaryScreen({super.key, required this.medicion});

  @override
  Widget build(BuildContext context) {
    final fecha = DateFormat('dd/MM/yyyy – HH:mm').format(medicion.fecha);

    return Scaffold(
      appBar: AppBar(title: const Text('📈 Resumen de Medición')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('✅ Proyecto: ${medicion.nombreProyecto}',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Text('🕓 Fecha: $fecha', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 12),
            Text('📊 Rugosidad Promedio: ${medicion.rugosidadPromedio.toStringAsFixed(5)} m/s²',
                style: const TextStyle(fontSize: 16)),
            const Spacer(),
            ElevatedButton.icon(
              onPressed: () => Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false),
              icon: const Icon(Icons.check),
              label: const Text('Volver al inicio'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
