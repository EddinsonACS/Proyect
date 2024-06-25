//ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:primerospasosapp/providers/login_form_provider.dart';
import 'package:primerospasosapp/services/services.dart';
import 'package:primerospasosapp/ui/input_decorations_form.dart';
import 'package:provider/provider.dart';

import '../widgets/widgets.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AuthBackgrond(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 300,
            ),
            CardContainer(
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Text('Inicio',
                      style: Theme.of(context).textTheme.headlineMedium),
                  const SizedBox(
                    height: 30,
                  ),
                  ChangeNotifierProvider(
                      create: (_) => LoginFormProvider(),
                      child: const _LoginForm()),
                ],
              ),
            ),
            const SizedBox(height: 50),
            // TextButton(
            //   onPressed: () =>
            //       Navigator.pushReplacementNamed(context, 'register'),
            //   style: ButtonStyle(
            //       shape: WidgetStateProperty.all(const StadiumBorder()),
            //       overlayColor: WidgetStateProperty.all(Colors.blueGrey)),
            //   child: Text('¡Crear una Nueva Cuenta!',
            //       style: TextStyle(
            //         color: Colors.blueGrey.shade700,
            //         fontSize: 16,
            //       )),
            // ),
            TextButton(
              onPressed: () =>
                  Navigator.pushReplacementNamed(context, 'selectUser'),
              style: ButtonStyle(
                  shape: WidgetStateProperty.all(const StadiumBorder()),
                  overlayColor: WidgetStateProperty.all(Colors.blueGrey)),
              child: Text('¿No Eres una Intitución?',
                  style: TextStyle(
                    color: Colors.blueGrey.shade700,
                    fontSize: 16,
                  )),
            ),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    ));
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm();

  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFormProvider>(context);
    return Form(
        key: loginForm.formkey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorationsForm.authInputDecorationForm(
                  hintText: 'email@gmail.com',
                  labelText: 'Correo Electronico',
                  prefixIcon: Icons.alternate_email_rounded),
              onChanged: (value) => loginForm.email = value,
              validator: (value) {
                String pattern =
                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                RegExp regExp = RegExp(pattern);

                return regExp.hasMatch(value ?? '')
                    ? null
                    : 'Ingresa un Correo Valido';
              },
            ),
            const SizedBox(
              height: 30,
            ),
            TextFormField(
              autocorrect: false,
              obscureText: true,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorationsForm.authInputDecorationForm(
                  hintText: '********',
                  labelText: 'Contraseña',
                  prefixIcon: Icons.lock_outline_rounded),
              onChanged: (value) => loginForm.password = value,
              validator: (value) {
                return (value != null && value.length >= 6)
                    ? null
                    : 'Ingresa una Contraseña Valida';
              },
            ),
            const SizedBox(
              height: 30,
            ),
            MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              disabledColor: Colors.grey,
              elevation: 0,
              color: Colors.blueGrey,
              padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
              onPressed: loginForm.isLoading
                  ? null
                  : () async {
                      FocusScope.of(context).unfocus();
                      final authService =
                          Provider.of<AuthService>(context, listen: false);
                      if (!loginForm.isValidForm()) return;
                      loginForm.isLoading = true;
                      final String? errorMessage = await authService.login(
                          loginForm.email, loginForm.password);
                      if (errorMessage == null) {
                        Navigator.pushReplacementNamed(context, 'homeInst');
                      } else {
                        NotificationsService.showSnackbar(
                            'Correo o Contraseña no valida');
                        loginForm.isLoading = false;
                      }
                    },
              child: Text(
                loginForm.isLoading ? 'Cargando' : 'Ingresar',
                style: const TextStyle(color: Colors.white),
              ),
            )
          ],
        ));
  }
}
