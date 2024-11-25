class Vehicle {
  final String id;
  final String name;
  final String model;
  final int year;
  final String plate;
  final double? previousMileage; // Quilometragem anterior
  final double? currentMileage; // Quilometragem atual
  final double? liters; // Litros abastecidos

  Vehicle({
    required this.id,
    required this.name,
    required this.model,
    required this.year,
    required this.plate,
    this.previousMileage,
    this.currentMileage,
    this.liters,
  });

  // Converte o objeto para um mapa para salvar no Firestore
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'model': model,
      'year': year,
      'plate': plate,
      'previousMileage': previousMileage,
      'currentMileage': currentMileage,
      'liters': liters,
    };
  }

  // Cria um objeto Vehicle a partir de um mapa
  factory Vehicle.fromMap(Map<String, dynamic> map) {
    return Vehicle(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      model: map['model'] ?? '',
      year: map['year'] ?? 0,
      plate: map['plate'] ?? '',
      previousMileage: map['previousMileage'] != null
          ? map['previousMileage'].toDouble()
          : null,
      currentMileage: map['currentMileage'] != null
          ? map['currentMileage'].toDouble()
          : null,
      liters: map['liters'] != null ? map['liters'].toDouble() : null,
    );
  }

  // Método copyWith para criar uma nova instância com alterações
  Vehicle copyWith({
    String? id,
    String? name,
    String? model,
    int? year,
    String? plate,
    double? previousMileage,
    double? currentMileage,
    double? liters,
  }) {
    return Vehicle(
      id: id ?? this.id,
      name: name ?? this.name,
      model: model ?? this.model,
      year: year ?? this.year,
      plate: plate ?? this.plate,
      previousMileage: previousMileage ?? this.previousMileage,
      currentMileage: currentMileage ?? this.currentMileage,
      liters: liters ?? this.liters,
    );
  }
}
