
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../widgets/vehicle_card.dart';
import '../models/vehicle_model.dart';
import 'add_reful_sreen.dart';

class VehicleScreen extends StatefulWidget {
  const VehicleScreen({super.key});

  @override
  State<VehicleScreen> createState() => _VehicleScreenState();
}

class _VehicleScreenState extends State<VehicleScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Vehicle> vehicles = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadVehicles();
  }

  Future<void> _loadVehicles() async {
    setState(() {
      isLoading = true;
    });

    try {
      final snapshot = await _firestore.collection('vehicles').get();
      final loadedVehicles = snapshot.docs
          .map((doc) => Vehicle.fromMap(doc.data()).copyWith(id: doc.id))
          .toList();

      setState(() {
        vehicles = loadedVehicles;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao carregar veículos: $e')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _deleteVehicle(String id) async {
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
        await _firestore.collection('vehicles').doc(id).delete();
        _loadVehicles();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Veículo excluído com sucesso!')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao excluir veículo: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus Veículos'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : vehicles.isEmpty
              ? const Center(child: Text('Nenhum veículo encontrado.'))
              : ListView.builder(
                  itemCount: vehicles.length,
                  itemBuilder: (context, index) {
                    final vehicle = vehicles[index];
                    return VehicleCard(
                      name: vehicle.name,
                      model: vehicle.model,
                      year: vehicle.year,
                      plate: vehicle.plate,
                      onTap: () {
                        // Exibe um menu de ações para o veículo selecionado
                        _showVehicleActions(context, vehicle);
                      },
                      onDelete: () => _deleteVehicle(vehicle.id),
                    );
                  },
                ),
    );
  }

  void _showVehicleActions(BuildContext context, Vehicle vehicle) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('Detalhes do Veículo'),
              onTap: () {
                Navigator.pop(context); // Fecha o menu
                Navigator.pushNamed(
                  context,
                  '/vehicle_details',
                  arguments: vehicle,
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.add),
              title: const Text('Novo Abastecimento'),
              onTap: () {
                Navigator.pop(context); // Fecha o menu
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddRefuelScreen(vehicleId: vehicle.id),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
