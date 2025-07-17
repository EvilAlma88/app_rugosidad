import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'dart:async';
import '../models/medicion_temp.dart';

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

    _accelerometerSub = accelerometerEvents.listen((event) {
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
    return WillPopScope(
      onWillPop: () async => false, // bloquear botón atrás
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Calibración del Sensor"),
          automaticallyImplyLeading: false,
          actions: [
          IconButton(
          icon: const Icon(Icons.cancel),
          tooltip: 'Cancelar',
          onPressed: () {
          _accelerometerSub?.cancel();
          MedicionTemp.nombreProyecto = '';
          MedicionTemp.descripcion = '';
           MedicionTemp.rugosidadPromedio = 0;
      Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
    },
  ),
],

        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
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
                    ],
                  )
                : _isCalibrated
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.check_circle_outline, color: Colors.green, size: 80),
                          const SizedBox(height: 16),
                          const Text(
                            "Calibración completada",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            "El sensor está estable y listo para usar.",
                            textAlign: TextAlign.center,
                          ),
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
                              SizedBox(height: 20),
                              Text(
                                "Calibrando... No muevas el dispositivo.",
                                textAlign: TextAlign.center,
                              ),
                            ],
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.tune, size: 70),
                              const SizedBox(height: 16),
                              const Text(
                                "Presiona para iniciar la calibración.",
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 24),
                              ElevatedButton.icon(
                                onPressed: _startCalibration,
                                icon: const Icon(Icons.play_arrow),
                                label: const Text("Iniciar Calibración"),
                              ),
                            ],
                          ),
          ),
        ),
      ),
    );
  }
}
