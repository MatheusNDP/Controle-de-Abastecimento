import 'package:flutter/material.dart';
import '../widgets/vehicle_card.dart';

class VehicleScreen extends StatelessWidget {
  const VehicleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Lista de veículos mockada (pode ser substituída pelos dados do Firebase Firestore)
    final List<Map<String, dynamic>> vehicles = [
      {"name": "Carro A", "model": "SUV", "year": 2020, "plate": "ABC-1234"},
      {"name": "Carro B", "model": "Sedan", "year": 2018, "plate": "DEF-5678"},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Meus Veículos')),
      body: ListView.builder(
        itemCount: vehicles.length,
        itemBuilder: (context, index) {
          final vehicle = vehicles[index];
          return VehicleCard(
            name: vehicle["name"],
            model: vehicle["model"],
            year: vehicle["year"],
            plate: vehicle["plate"],
            onTap: () {
              // Lógica para abrir os detalhes do veículo
              Navigator.pushNamed(context, '/vehicle_details',
                  arguments: vehicle);
            },
          );
        },
      ),
    );
  }
}
