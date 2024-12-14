class Coche {
  final String id;
  final String modelo;
  final int anio;
  final double precio;
  final bool disponible;

  Coche({
    required this.id,
    required this.modelo,
    required this.anio,
    required this.precio,
    required this.disponible,
  });

  factory Coche.fromMap(Map<String, dynamic> map, String id) {
    return Coche(
      id: id,
      modelo: map['modelo'] ?? '',
      anio: map['anio'] ?? 0,
      precio: (map['precio'] ?? 0.0).toDouble(),
      disponible: map['disponible'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'modelo': modelo,
      'anio': anio,
      'precio': precio,
      'disponible': disponible,
    };
  }
}

