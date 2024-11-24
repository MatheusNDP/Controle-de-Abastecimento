import 'package:flutter/material.dart';

class VehicleCard extends StatelessWidget {
  final String name;
  final String model;
  final int year;
  final String plate;
  final VoidCallback onTap;

  const VehicleCard({
    super.key,
    required this.name,
    required this.model,
    required this.year,
    required this.plate,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(name),
        subtitle: Text('$model - $year'),
        trailing: Text(plate),
        onTap: onTap,
      ),
    );
  }
}
