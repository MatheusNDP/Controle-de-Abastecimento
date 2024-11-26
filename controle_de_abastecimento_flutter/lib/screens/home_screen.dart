import 'package:flutter/material.dart';
import '../widgets/drawer_menu.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GasTracker'), // Atualizado o título
      ),
      drawer: const DrawerMenu(),
      body: Center(
        child: Text(
          'Bem-vindo ao GasTracker!',
          style: Theme.of(context).textTheme.headlineSmall,
          textAlign: TextAlign.center,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add_vehicle'); // Navega para a tela de adicionar veículo
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
