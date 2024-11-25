import 'package:controle_de_abastecimento_flutter/widgets/home_button.dart';
import 'package:flutter/material.dart';

class AddVehicleScreen extends StatelessWidget {
  const AddVehicleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController modelController = TextEditingController();
    final TextEditingController yearController = TextEditingController();
    final TextEditingController plateController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('Adicionar Veículo'),
       actions: const [HomeButton()]
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
              onPressed: () {
                // Aqui você implementará a lógica para salvar no Firebase Firestore
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Veículo adicionado com sucesso!')),
                );
                Navigator.pop(context); // Volta para a tela anterior
              },
              child: const Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }
}
