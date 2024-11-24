import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/vehicle_screen.dart';
import 'screens/add_vehicle_screen.dart';
import 'screens/refuel_history_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/vehicle_details_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Controle de Abastecimento',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),
        '/vehicles': (context) => const VehicleScreen(),
        '/add_vehicle': (context) => const AddVehicleScreen(),
        '/history': (context) => const RefuelHistoryScreen(),
        '/profile': (context) => const ProfileScreen(),
      },
    );
  }
}
