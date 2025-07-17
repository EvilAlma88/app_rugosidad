import 'package:flutter/material.dart';
import '../services/storage_service.dart';
import 'summary_screen.dart';

class PreviousMeasurementsScreen extends StatelessWidget {
  const PreviousMeasurementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mediciones = MedicionStorage.obtenerTodas();

    return Scaffold(
      appBar: AppBar(title: const Text('📂 Mediciones Anteriores')),
      body: mediciones.isEmpty
          ? const Center(child: Text('No hay mediciones registradas'))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: mediciones.length,
              itemBuilder: (context, index) {
                final medicion = mediciones[index];

                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    title: Text(medicion.nombreProyecto,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(
                      "Promedio: ${medicion.rugosidadPromedio.toStringAsFixed(2)} m/s²",
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => SummaryScreen(
                            medicion: medicion,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
