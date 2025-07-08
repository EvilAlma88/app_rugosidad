class MedicionEvento {
  final String tipo; // "bache", "curva"
  final Duration tiempo;

  MedicionEvento({required this.tipo, required this.tiempo});
}

class Proyecto {
  String nombre;
  DateTime fecha;
  String estado; // "completo" o "incompleto"
  List<MedicionEvento> eventos;
  List<double> datosVibracion;
  double velocidadPromedio;

  Proyecto({
    required this.nombre,
    required this.fecha,
    required this.estado,
    required this.eventos,
    required this.datosVibracion,
    required this.velocidadPromedio,
  });
}
