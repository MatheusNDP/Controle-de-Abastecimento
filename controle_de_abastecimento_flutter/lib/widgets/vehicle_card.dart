import 'package:flutter/material.dart';

class VehicleCard extends StatelessWidget {
  final String name;
  final String model;
  final int year;
  final String plate;
  final VoidCallback onTap;
  final VoidCallback? onDelete; // Parâmetro opcional para exclusão

  const VehicleCard({
    super.key,
    required this.name,
    required this.model,
    required this.year,
    required this.plate,
    required this.onTap,
    this.onDelete, // Certifique-se de registrar o parâmetro aqui
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(name),
        subtitle: Text('$model - $year'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(plate),
            if (onDelete != null) // Botão de excluir só aparece se `onDelete` for fornecido
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: onDelete,
              ),
          ],
        ),
        onTap: onTap,
      ),
    );
  }
}
