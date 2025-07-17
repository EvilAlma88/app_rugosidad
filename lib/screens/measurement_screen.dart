import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'dart:async';
import 'dart:math';
import '../models/medicion_temp.dart';

class MeasurementScreen extends StatefulWidget {
  const MeasurementScreen({super.key});

  @override
  State<MeasurementScreen> createState() => _MeasurementScreenState();
}

class _MeasurementScreenState extends State<MeasurementScreen> {
  late StreamSubscription _subscription;
  List<double> vibraciones = [];
  double rugosidadActual = 0.0;
  bool estaMidiendo = true;

  @override
  void initState() {
    super.initState();

    _subscription = accelerometerEvents.listen((event) {
      // Aceleración total - gravedad (~9.8 m/s²)
      final vibracion = sqrt(event.x * event.x + event.y * event.y + event.z * event.z) - 9.8;
      final valorAbsoluto = vibracion.abs();

      setState(() {
        rugosidadActual = valorAbsoluto;
        vibraciones.add(valorAbsoluto);
      });
    });
  }

  void finalizarMedicion() {
    _subscription.cancel();

    // Guardamos valores en MedicionTemp
    MedicionTemp.vibraciones = vibraciones;
    MedicionTemp.rugosidadPromedio =
        vibraciones.isNotEmpty ? vibraciones.reduce((a, b) => a + b) / vibraciones.length : 0;

    Navigator.pushNamed(context, '/summary');
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('📡 Midiendo Rugosidad')),
body: Center(
  child: Padding(
    padding: const EdgeInsets.all(24),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.vibration, size: 80, color: Colors.deepPurple),
        const SizedBox(height: 20),
        const Text(
          'Rugosidad actual:',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Text(
          '${rugosidadActual.toStringAsFixed(3)} m/s²',
          style: const TextStyle(fontSize: 32, color: Colors.deepPurple),
        ),
        const SizedBox(height: 40),
        ElevatedButton.icon(
          onPressed: finalizarMedicion,
          icon: const Icon(Icons.check),
          label: const Text('Finalizar Medición'),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 24),
          ),
        ),
      ],
    ),
  ),
),
    );
  }
}