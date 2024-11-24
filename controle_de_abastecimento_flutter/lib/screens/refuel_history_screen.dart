import 'package:flutter/material.dart';
import '../widgets/refuel_card.dart';

class RefuelHistoryScreen extends StatelessWidget {
  const RefuelHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Dados mockados para o histórico de abastecimentos (podem ser substituídos por dados do Firebase Firestore)
    final List<Map<String, dynamic>> refuels = [
      {
        "date": "20/11/2024",
        "liters": 40.0,
        "mileage": 30000,
      },
      {
        "date": "15/11/2024",
        "liters": 35.0,
        "mileage": 29700,
      },
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Histórico de Abastecimentos')),
      body: ListView.builder(
        itemCount: refuels.length,
        itemBuilder: (context, index) {
          final refuel = refuels[index];
          return RefuelCard(
            date: refuel["date"],
            liters: refuel["liters"],
            mileage: refuel["mileage"],
          );
        },
      ),
    );
  }
}
