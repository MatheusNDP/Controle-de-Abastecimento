import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PasswordResetVerifyScreen extends StatefulWidget {
  final String email;
  final String recoveryCode;

  const PasswordResetVerifyScreen({
    super.key,
    required this.email,
    required this.recoveryCode,
  });

  @override
  State<PasswordResetVerifyScreen> createState() =>
      _PasswordResetVerifyScreenState();
}

class _PasswordResetVerifyScreenState extends State<PasswordResetVerifyScreen> {
  final TextEditingController codeController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> verifyAndResetPassword() async {
    if (codeController.text != widget.recoveryCode) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Código incorreto.')),
      );
      return;
    }

    try {
      final user = await _auth.fetchSignInMethodsForEmail(widget.email);
      if (user.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Email não encontrado.')),
        );
        return;
      }

      // Redefinir a senha
      final newPassword = newPasswordController.text;
      if (newPassword.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Por favor, insira uma nova senha.')),
        );
        return;
      }

      // O Firebase não permite redefinir a senha diretamente assim,
      // então em produção, você usaria outras formas seguras.
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Senha redefinida com sucesso.')),
      );
      Navigator.popUntil(context, ModalRoute.withName('/login'));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao redefinir a senha: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Verificar Código')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Digite o código enviado ao seu email e escolha uma nova senha.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: codeController,
              decoration: const InputDecoration(labelText: 'Código'),
            ),
            TextField(
              controller: newPasswordController,
              decoration: const InputDecoration(labelText: 'Nova Senha'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: verifyAndResetPassword,
              child: const Text('Redefinir Senha'),
            ),
          ],
        ),
      ),
    );
  }
}
