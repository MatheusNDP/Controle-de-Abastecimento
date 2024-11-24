class Vehicle {
  final String id;
  final String name;
  final String model;
  final int year;
  final String plate;

  Vehicle({
    required this.id,
    required this.name,
    required this.model,
    required this.year,
    required this.plate,
  });

  // Converte o objeto para um mapa para salvar no Firestore
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'model': model,
      'year': year,
      'plate': plate,
    };
  }

  // Cria um objeto Vehicle a partir de um mapa
  factory Vehicle.fromMap(Map<String, dynamic> map) {
    return Vehicle(
      id: map['id'],
      name: map['name'],
      model: map['model'],
      year: map['year'],
      plate: map['plate'],
    );
  }
}
