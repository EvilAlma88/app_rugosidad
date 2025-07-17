import '../models/medicion.dart';

class MedicionStorage {
  static final List<Medicion> _mediciones = [];

  static void agregar(Medicion medicion) {
    _mediciones.add(medicion);
  }

  static List<Medicion> obtenerTodas() {
    return List.from(_mediciones.reversed);
  }

  static Medicion obtenerPorIndice(int index) {
    return _mediciones.reversed.toList()[index];
  }

  static int total() {
    return _mediciones.length;
  }
}
