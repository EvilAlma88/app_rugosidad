import 'package:flutter/material.dart';
import 'screens/calibration_screen.dart'; 
import 'screens/home_screen.dart';
import 'screens/create_project_screen.dart';
import 'screens/speed_check_screen.dart';
import 'screens/measurement_screen.dart';
import 'screens/summary_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rugosidad Vial',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      // 👇 Aquí defines la pantalla que se abrirá al iniciar la app
      initialRoute: '/', 

      // 👇 Aquí defines todas las rutas de tu app
      routes: {
        '/': (context) => const HomeScreen(),
        '/create': (context) => const CreateProjectScreen(),
        '/calibrate': (context) => const CalibrationScreen(),
        '/speed': (context) => const SpeedCheckScreen(),
        '/measure': (context) => const MeasurementScreen(),
        '/summary': (context) => const SummaryScreen(),
      },
    );
  }
}
