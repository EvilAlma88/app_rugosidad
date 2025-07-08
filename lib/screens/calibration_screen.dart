import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'dart:async';

class CalibrationScreen extends StatefulWidget {
  const CalibrationScreen({super.key});

  @override
  CalibrationScreenState createState() => CalibrationScreenState();
}

class CalibrationScreenState extends State<CalibrationScreen> {
  bool _isCalibrating = false;
  bool _isCalibrated = false;
  bool _errorDetected = false;
  String _errorMessage = '';
  StreamSubscription<AccelerometerEvent>? _accelerometerSub;
  final List<double> _zValues = [];

  void _startCalibration() {
    setState(() {
      _isCalibrating = true;
      _isCalibrated = false;
      _errorDetected = false;
      _errorMessage = '';
      _zValues.clear();
    });

    int errorSamples = 0;

    _accelerometerSub = accelerometerEventStream().listen((event) {
      double z = event.z;
      if (z.isNaN || z.abs() > 1000) {
        errorSamples++;
        if (errorSamples > 5) {
          _handleError("No se detecta el sensor correctamente o está arrojando valores anómalos.");
        }
        return;
      }

      _zValues.add(z);

      if (_zValues.length > 40) {
        _zValues.removeAt(0);

        double avg = _zValues.reduce((a, b) => a + b) / _zValues.length;
        bool isStable = _zValues.every((v) => (v - avg).abs() < 0.05);

        if (isStable) {
          _accelerometerSub?.cancel();
          setState(() {
            _isCalibrated = true;
            _isCalibrating = false;
          });

          debugPrint("✅ Calibrado. Valor promedio Z: $avg");
        }
      }
    }, onError: (_) {
      _handleError("Error accediendo al sensor. Asegúrate de que tu dispositivo tiene acelerómetro.");
    });
  }

  void _handleError(String message) {
    _accelerometerSub?.cancel();
    setState(() {
      _isCalibrating = false;
      _errorDetected = true;
      _errorMessage = message;
    });
  }

  @override
  void dispose() {
    _accelerometerSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calibración"),
        actions: [
          IconButton(
            icon: const Icon(Icons.cancel),
            onPressed: () => Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false),
          ),
        ],
      ),
      body: Center(
        child: _errorDetected
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.cancel_outlined, color: Colors.red, size: 80),
                  const SizedBox(height: 16),
                  Text(_errorMessage, textAlign: TextAlign.center),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: _startCalibration,
                    icon: const Icon(Icons.replay),
                    label: const Text("Reintentar"),
                  ),
                  const SizedBox(height: 12),
                  TextButton(
                    onPressed: () => Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false),
                    child: const Text("Volver a inicio"),
                  ),
                ],
              )
            : _isCalibrated
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.check_circle_outline, color: Colors.green, size: 80),
                      const SizedBox(height: 16),
                      const Text("Calibración completada correctamente"),
                      const SizedBox(height: 24),
                      ElevatedButton.icon(
                        onPressed: () => Navigator.pushNamed(context, '/speed'),
                        icon: const Icon(Icons.speed),
                        label: const Text("Verificar velocidad"),
                      ),
                    ],
                  )
                : _isCalibrating
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          CircularProgressIndicator(),
                          SizedBox(height: 16),
                          Text("Calibrando..."),
                        ],
                      )
                    : ElevatedButton.icon(
                        onPressed: _startCalibration,
                        icon: const Icon(Icons.play_arrow),
                        label: const Text("Iniciar Calibración"),
                      ),
      ),
    );
  }
}
