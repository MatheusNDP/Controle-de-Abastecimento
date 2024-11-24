import 'package:flutter/material.dart';

class RefuelCard extends StatelessWidget {
  final String date;
  final double liters;
  final int mileage;

  const RefuelCard({
    super.key,
    required this.date,
    required this.liters,
    required this.mileage,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: const Icon(Icons.local_gas_station),
        title: Text('Data: $date'),
        subtitle: Text('Litros: $liters - Quilometragem: $mileage km'),
      ),
    );
  }
}
