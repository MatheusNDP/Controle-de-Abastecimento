import 'package:controle_de_abastecimento_flutter/widgets/home_button.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/vehicle_model.dart';

class VehicleDetailsScreen extends StatelessWidget {
  final Vehicle vehicle;

  const VehicleDetailsScreen({super.key, required this.vehicle});

  // Função para calcular a média de consumo
  double calculateAverage({
    required double previousMileage,
    required double currentMileage,
    required double liters,
  }) {
    if (liters <= 0 || currentMileage <= previousMileage) {
      return 0.0; // Evita divisões por zero ou valores inválidos
    }
    return (currentMileage - previousMileage) / liters;
  }

  Future<void> _deleteVehicle(BuildContext context) async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmação'),
        content: const Text('Tem certeza de que deseja excluir este veículo?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Excluir'),
          ),
        ],
      ),
    );

    if (shouldDelete == true) {
      try {
        await FirebaseFirestore.instance.collection('vehicles').doc(vehicle.id).delete();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Veículo excluído com sucesso!')),
        );
        Navigator.pop(context); // Retorna para a listagem
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao excluir veículo: $e')),
        );
      }
    }
  }

  Future<void> _editVehicle(BuildContext context) async {
    // Navegar para uma tela de edição (não implementada aqui, mas pode ser criada)
    Navigator.pushNamed(context, '/edit_vehicle', arguments: vehicle).then((_) {
      // Recarrega os detalhes do veículo ao retornar
      Navigator.pop(context); // Sai da tela atual para evitar inconsistências
    });
  }

  @override
  Widget build(BuildContext context) {
    final double averageConsumption = calculateAverage(
      previousMileage: vehicle.previousMileage ?? 0.0,
      currentMileage: vehicle.currentMileage ?? 0.0,
      liters: vehicle.liters ?? 0.0,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(vehicle.name),
        actions: const [HomeButton()],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Modelo: ${vehicle.model}', style: const TextStyle(fontSize: 18)),
            Text('Ano: ${vehicle.year}', style: const TextStyle(fontSize: 18)),
            Text('Placa: ${vehicle.plate}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            Text(
              'Média de Consumo: ${averageConsumption.toStringAsFixed(2)} km/l',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                  onPressed: () => _editVehicle(context),
                  icon: const Icon(Icons.edit),
                  label: const Text('Editar'),
                ),
                ElevatedButton.icon(
                  onPressed: () => _deleteVehicle(context),
                  icon: const Icon(Icons.delete, color: Colors.white),
                  label: const Text('Excluir'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
