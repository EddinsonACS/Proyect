import 'package:flutter/material.dart';
import 'package:primerospasosapp/widgets/widgets.dart';

class SelectUserScreen extends StatelessWidget {
  const SelectUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        const AuthBackgroundSelect(
          child: Text(''),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 400.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Text(
                  'Seleccione una Opción:',
                  style: TextStyle(
                      fontSize: 24,
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.none),
                ),
                const SizedBox(
                  height: 30,
                ),
                const SizedBox(
                    height: 40.0), // Espacio entre el texto y los botones
                MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  elevation: 10,
                  color: Colors.grey.shade400,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 100, vertical: 18),
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, 'login');
                  },
                  child: const Text(
                    'Institucion',
                    style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0), fontSize: 20),
                  ),
                ),
                const SizedBox(height: 20.0),
                MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  elevation: 10,
                  color: Colors.grey.shade400,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 85, vertical: 20),
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, 'homeRepr');
                  },
                  child: const Text(
                    'Representante',
                    style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0), fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
