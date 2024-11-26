import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/refuel_model.dart';
import '../widgets/refuel_card.dart';

class RefuelHistoryScreen extends StatelessWidget {
  final String vehicleId; // Recebe o ID do veículo

  const RefuelHistoryScreen({super.key, required this.vehicleId}); // Construtor atualizado

  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Histórico de Abastecimentos'),
       
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: firestore
            .collection('refuels')
            .where('vehicleId', isEqualTo: vehicleId) // Filtra pelo ID do veículo
            .orderBy('date', descending: true) // Ordena por data
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('Nenhum abastecimento registrado.'));
          }

          // Converte os dados do Firestore para objetos Refuel
          final refuels = snapshot.data!.docs
              .map((doc) => Refuel.fromMap(doc.data() as Map<String, dynamic>))
              .toList();

          return ListView.builder(
            itemCount: refuels.length,
            itemBuilder: (context, index) {
              final refuel = refuels[index];
              return RefuelCard(
                date: refuel.date.toIso8601String().split('T')[0], // Formata a data
                liters: refuel.liters,
                mileage: refuel.mileage.toInt(),
              );
            },
          );
        },
      ),
    );
  }
}
