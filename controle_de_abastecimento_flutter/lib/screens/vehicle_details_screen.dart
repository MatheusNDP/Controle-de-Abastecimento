import 'package:controle_de_abastecimento_flutter/widgets/home_button.dart';
import 'package:flutter/material.dart';

class VehicleDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> vehicleData;

  const VehicleDetailsScreen({super.key, required this.vehicleData});

  @override
  Widget build(BuildContext context) {
    // Função para calcular a média de consumo
    double calculateAverage(double previousMileage, double currentMileage, double liters) {
      return (currentMileage - previousMileage) / liters;
    }

    final double averageConsumption = calculateAverage(
      vehicleData['previousMileage'] as double,
      vehicleData['currentMileage'] as double,
      vehicleData['liters'] as double,
    );

    return Scaffold(
      appBar: AppBar(title: Text(vehicleData['name'] ?? 'Detalhes do Veículo'),
      actions: const [HomeButton()]
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Modelo: ${vehicleData["model"]}', style: const TextStyle(fontSize: 18)),
            Text('Ano: ${vehicleData["year"]}', style: const TextStyle(fontSize: 18)),
            Text('Placa: ${vehicleData["plate"]}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            Text(
              'Média de Consumo: ${averageConsumption.toStringAsFixed(2)} km/l',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
