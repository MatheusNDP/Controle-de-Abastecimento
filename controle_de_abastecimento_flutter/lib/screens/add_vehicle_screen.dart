import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:controle_de_abastecimento_flutter/widgets/home_button.dart';
import 'package:uuid/uuid.dart'; // Para gerar IDs únicos para os veículos

class AddVehicleScreen extends StatelessWidget {
  const AddVehicleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController modelController = TextEditingController();
    final TextEditingController yearController = TextEditingController();
    final TextEditingController plateController = TextEditingController();
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    Future<void> saveVehicle() async {
      // Verificação: Todos os campos devem estar preenchidos
      if (nameController.text.isEmpty ||
          modelController.text.isEmpty ||
          yearController.text.isEmpty ||
          plateController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Por favor, preencha todos os campos.')),
        );
        return;
      }

      try {
        // Criação do veículo como um Map<String, dynamic>
        final Map<String, dynamic> vehicle = {
          'id': const Uuid().v4(), // Gerar um ID único
          'name': nameController.text,
          'model': modelController.text,
          'year': int.parse(yearController.text),
          'plate': plateController.text,
        };

        // Salvando no Firestore
        await firestore.collection('vehicles').doc(vehicle['id']).set(vehicle);

        // Sucesso
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Veículo adicionado com sucesso!')),
        );
        Navigator.pop(context); // Retorna à tela anterior
      } catch (e) {
        // Tratamento de erros
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao salvar veículo: $e')),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar Veículo'),
        actions: const [HomeButton()],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Nome'),
            ),
            TextField(
              controller: modelController,
              decoration: const InputDecoration(labelText: 'Modelo'),
            ),
            TextField(
              controller: yearController,
              decoration: const InputDecoration(labelText: 'Ano'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: plateController,
              decoration: const InputDecoration(labelText: 'Placa'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: saveVehicle, // Chama a função para salvar o veículo
              child: const Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }
}
