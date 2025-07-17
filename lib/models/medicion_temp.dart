import 'medicion.dart';

class MedicionTemp {
  static String nombreProyecto = '';
  static String descripcion = '';
  static List<double> vibraciones = [];
  static double rugosidadPromedio = 0;

  static Medicion buildFinal() {
    return Medicion(
      nombreProyecto: nombreProyecto,
      descripcion: descripcion,
      fecha: DateTime.now(),
      rugosidadPromedio: rugosidadPromedio,
      vibraciones: vibraciones,
    );
  }
}

