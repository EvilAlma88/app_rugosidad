class Medicion {
  final String nombreProyecto;
  final String descripcion; // <- Necesario
  final DateTime fecha;
  final double rugosidadPromedio;
  final List<double> vibraciones; // <- Necesario

  Medicion({
    required this.nombreProyecto,
    required this.descripcion,
    required this.fecha,
    required this.rugosidadPromedio,
    required this.vibraciones,
  });
}

// Almacenamiento temporal en memoria
class MedicionStorage {
  static final List<Medicion> _mediciones = [];

  static void agregar(Medicion medicion) {
    _mediciones.add(medicion);
  }

  static List<Medicion> obtenerTodas() => _mediciones;
}
