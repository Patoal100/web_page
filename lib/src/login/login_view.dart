import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'login_provider.dart';

class LoginView extends ConsumerWidget {
  const LoginView({Key? key}) : super(key: key);

  static const routeName = '/login';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController usernameController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
        appBar: AppBar(
          title: const Text('Inicio de Sessión'),
        ),
        body: LayoutBuilder(builder: (context, constraints) {
          final width = constraints.maxWidth * 0.4;
          return Center(
            child: Container(
              width: width,
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: usernameController,
                    decoration: const InputDecoration(labelText: 'Usuario'),
                  ),
                  TextField(
                    controller: passwordController,
                    decoration: const InputDecoration(labelText: 'Contraseña'),
                    obscureText: true,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () async {
                      await ref
                          .read(loginProvider.notifier)
                          .login(
                              usernameController.text, passwordController.text)
                          .then((value) => {
                                Navigator.of(context).pushNamed('/home'),
                              })
                          // ignore: body_might_complete_normally_catch_error
                          .catchError((error, stackTrace) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content:
                                Text('Error: Usuario o contraseña incorrecto'),
                          ),
                        );
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      textStyle: const TextStyle(fontSize: 16),
                    ),
                    child: const Text('Iniciar Sessión'),
                  ),
                ],
              ),
            ),
          );
        }));
  }
}
