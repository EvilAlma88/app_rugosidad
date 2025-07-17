import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/medicion.dart' hide MedicionStorage;
import '../models/medicion_temp.dart';
import '../services/storage_service.dart';

class SummaryScreen extends StatelessWidget {
  final Medicion? medicion;

  const SummaryScreen({super.key, this.medicion});

  @override
  Widget build(BuildContext context) {
    final Medicion medicionFinal = medicion ?? MedicionTemp.buildFinal();

    // Si la medición viene de MedicionTemp, se guarda en el almacenamiento
    if (medicion == null) {
      MedicionStorage.agregar(medicionFinal);
    }

    final formatter = DateFormat('dd/MM/yyyy - HH:mm');
    final fechaTexto = formatter.format(medicionFinal.fecha);
    final rugosidad = medicionFinal.rugosidadPromedio;

    String interpretacion;
    Color color;

    if (rugosidad < 2) {
      interpretacion = "🟢 Suelo suave";
      color = Colors.green;
    } else if (rugosidad < 5) {
      interpretacion = "🟡 Suelo moderado";
      color = Colors.orange;
    } else {
      interpretacion = "🔴 Suelo rugoso";
      color = Colors.red;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("📋 Resumen de Medición"),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("✅ Proyecto completado", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),
            _infoRow("📝 Nombre:", medicionFinal.nombreProyecto),
            _infoRow("📄 Descripción:", medicionFinal.descripcion),
            _infoRow("📅 Fecha:", fechaTexto),
            const SizedBox(height: 24),
            Center(
              child: Column(
                children: [
                  const Text("Rugosidad Promedio", style: TextStyle(fontSize: 20)),
                  Text(
                    "${rugosidad.toStringAsFixed(2)} m/s²",
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: color),
                  ),
                  Text(interpretacion, style: TextStyle(fontSize: 18, color: color)),
                ],
              ),
            ),
            const Spacer(),
            Center(
              child: ElevatedButton.icon(
                onPressed: () => Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false),
                icon: const Icon(Icons.home),
                label: const Text("Volver al inicio"),
                style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24)),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(width: 8),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}

