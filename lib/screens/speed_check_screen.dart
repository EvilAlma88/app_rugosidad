import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'dart:math';
import 'dart:async';

class SpeedCheckScreen extends StatefulWidget {
  const SpeedCheckScreen({super.key});

  @override
  State<SpeedCheckScreen> createState() => _SpeedCheckScreenState();
}

class _SpeedCheckScreenState extends State<SpeedCheckScreen> {
  double velocidad = 0.0;
  final double umbralVelocidad = 4.0 / 3.6; // 4 km/h → m/s
  int? ultimoTimestamp;
  bool yaEntrando = false;
  late final StreamSubscription _sub;

  @override
  void initState() {
    super.initState();

    _sub = accelerometerEvents.listen((event) {
      final aceleracion = sqrt(event.x * event.x + event.y * event.y + event.z * event.z) - 9.8;
      final timestamp = DateTime.now().millisecondsSinceEpoch;

      if (ultimoTimestamp != null) {
        final deltaTime = (timestamp - ultimoTimestamp!) / 1000;
        velocidad += aceleracion * deltaTime;
        velocidad = max(0, velocidad * 0.98); // desaceleración artificial
      }

      ultimoTimestamp = timestamp;

      if (velocidad >= umbralVelocidad && !yaEntrando) {
        yaEntrando = true;
        _sub.cancel(); // detener escucha antes de navegar
        Navigator.pushReplacementNamed(context, '/measure');
      }

      setState(() {});
    });
  }

  @override
  void dispose() {
    _sub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double kmh = velocidad * 3.6;

    return WillPopScope(
      onWillPop: () async => false, // bloquear botón atrás
      child: Scaffold(
        appBar: AppBar(
          title: const Text('🚗 Verificar Velocidad'),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              icon: const Icon(Icons.cancel),
              onPressed: () {
                _sub.cancel();
                Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
              },
            )
          ],
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Necesitamos una velocidad mínima para iniciar la medición.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 30),
                Text(
                  "${kmh.toStringAsFixed(2)} km/h",
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: kmh >= 4 ? Colors.green : Colors.orange,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  kmh >= 4
                      ? "✅ Velocidad suficiente, iniciando..."
                      : "⏳ Esperando al menos 4 km/h...",
                  style: TextStyle(
                    fontSize: 18,
                    color: kmh >= 4 ? Colors.green : Colors.black87,
                  ),
                ),
                const SizedBox(height: 40),
                const Icon(Icons.directions_car, size: 80, color: Colors.blueAccent),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
