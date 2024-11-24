class Refuel {
  final String id;
  final String vehicleId;
  final double liters;
  final double mileage;
  final DateTime date;

  Refuel({
    required this.id,
    required this.vehicleId,
    required this.liters,
    required this.mileage,
    required this.date,
  });

  // Converte o objeto para um mapa para salvar no Firestore
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'vehicleId': vehicleId,
      'liters': liters,
      'mileage': mileage,
      'date': date.toIso8601String(),
    };
  }

  // Cria um objeto Refuel a partir de um mapa
  factory Refuel.fromMap(Map<String, dynamic> map) {
    return Refuel(
      id: map['id'],
      vehicleId: map['vehicleId'],
      liters: map['liters'],
      mileage: map['mileage'],
      date: DateTime.parse(map['date']),
    );
  }
}
