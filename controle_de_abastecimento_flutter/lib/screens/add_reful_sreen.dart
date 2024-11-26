import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class AddRefuelScreen extends StatefulWidget {
  final String vehicleId; // Recebe o ID do veículo

  const AddRefuelScreen({super.key, required this.vehicleId});

  @override
  State<AddRefuelScreen> createState() => _AddRefuelScreenState();
}

class _AddRefuelScreenState extends State<AddRefuelScreen> {
  final TextEditingController litersController = TextEditingController();
  final TextEditingController mileageController = TextEditingController();
  DateTime? selectedDate;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> saveRefuel() async {
    if (litersController.text.isEmpty ||
        mileageController.text.isEmpty ||
        selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, preencha todos os campos.')),
      );
      return;
    }

    try {
      final refuel = {
        'id': const Uuid().v4(), // ID único para o abastecimento
        'vehicleId': widget.vehicleId, // ID do veículo associado
        'liters': double.parse(litersController.text), // Quantidade de litros
        'mileage': double.parse(mileageController.text), // Quilometragem
        'date': selectedDate!.toIso8601String(), // Data do abastecimento
      };

      await firestore
          .collection('refuels')
          .doc(refuel['id'] as String) // Converte explicitamente para String
          .set(refuel);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Abastecimento registrado com sucesso!')),
      );
      Navigator.pop(context); // Volta para a tela anterior
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao salvar abastecimento: $e')),
      );
    }
  }

  Future<void> selectDate(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registrar Abastecimento')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: litersController,
              decoration: const InputDecoration(labelText: 'Litros Abastecidos'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: mileageController,
              decoration: const InputDecoration(labelText: 'Quilometragem Atual'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  selectedDate == null
                      ? 'Selecione uma data'
                      : 'Data: ${selectedDate!.toLocal().toIso8601String().split('T')[0]}',
                ),
                ElevatedButton(
                  onPressed: () => selectDate(context),
                  child: const Text('Selecionar Data'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: saveRefuel,
              child: const Text('Salvar Abastecimento'),
            ),
          ],
        ),
      ),
    );
  }
}
