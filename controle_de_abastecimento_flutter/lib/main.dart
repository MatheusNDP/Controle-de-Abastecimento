import 'package:controle_de_abastecimento_flutter/screens/add_reful_sreen.dart';
import 'package:controle_de_abastecimento_flutter/screens/vehicle_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart'; // Tela de cadastro
import 'screens/password_reset_request_screen.dart'; // Tela de recuperação de senha
import 'screens/home_screen.dart';
import 'screens/vehicle_screen.dart';
import 'screens/add_vehicle_screen.dart';
import 'screens/refuel_history_screen.dart';
import 'screens/profile_screen.dart';
import 'firebase_options.dart';
import 'models/vehicle_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/login':
            return MaterialPageRoute(builder: (_) => const LoginScreen());
          case '/register':
            return MaterialPageRoute(builder: (_) => const RegisterScreen());
          case '/password_reset_request':
            return MaterialPageRoute(
                builder: (_) => const PasswordResetRequestScreen());
          case '/home':
            return MaterialPageRoute(builder: (_) => const HomeScreen());
          case '/vehicles':
            return MaterialPageRoute(builder: (_) => const VehicleScreen());
          case '/add_vehicle':
            return MaterialPageRoute(builder: (_) => const AddVehicleScreen());
          case '/history':
            final args = settings.arguments as String?;
            if (args != null) {
              return MaterialPageRoute(
                  builder: (_) => RefuelHistoryScreen(vehicleId: args));
            }
            return _errorRoute();
          case '/profile':
            return MaterialPageRoute(builder: (_) => const ProfileScreen());
          case '/add_refuel':
            final args = settings.arguments as String?;
            if (args != null) {
              return MaterialPageRoute(
                  builder: (_) => AddRefuelScreen(vehicleId: args));
            }
            return _errorRoute();
          case '/vehicle_details':
            final args = settings.arguments as Vehicle?;
            if (args != null) {
              return MaterialPageRoute(
                  builder: (_) => VehicleDetailsScreen(vehicle: args));
            }
            return _errorRoute();
          default:
            return _errorRoute();
        }
      },
    );
  }

  Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text('Erro')),
        body: const Center(
          child: Text('Rota não encontrada ou argumentos ausentes!'),
        ),
      ),
    );
  }
}
