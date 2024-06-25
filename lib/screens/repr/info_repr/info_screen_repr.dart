import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:primerospasosapp/screens/repr/home_screen_repr.dart';
import 'package:primerospasosapp/widgets/headers2.dart';

class InfoScreenRepr extends StatelessWidget {
  const InfoScreenRepr({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const _Encabezado2(),
          Container(
            margin: const EdgeInsets.only(top: 220),
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: const [
                ListTile(
                  leading: Icon(Icons.account_balance_rounded,
                      color: Colors.black, size: 25),
                  title: Text(
                    'Institución',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text('J.I José de los Santos Pereira'),
                ),
                ListTile(
                  leading: Icon(Icons.location_on_rounded,
                      color: Colors.black, size: 25),
                  title: Text('Ubicación',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(
                      'Urbanización Romulo Gallegos, Sector 1, Calle 2, Antigua sede INAVI'),
                ),
                ListTile(
                  leading:
                      Icon(Icons.phone_rounded, color: Colors.black, size: 25),
                  title: Text('Teléfono',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text('+58 424 198 6646'),
                ),
                ListTile(
                  leading: Icon(Icons.email_rounded, color: Colors.black),
                  title: Text('Correo Electrónico',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text('jijosedelossantospereira@gmail.com'),
                ),
                ListTile(
                  leading: FaIcon(FontAwesomeIcons.instagram,
                      color: Colors.black, size: 25),
                  title: Text('Instagram',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text('@jijosedelossantospereira20'),
                ),
                ListTile(
                  leading: Icon(Icons.access_time_rounded,
                      color: Colors.black, size: 25),
                  title: Text('Horario de Atención',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text('Lunes a Viernes: 9:00 AM - 5:00 PM'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Encabezado2 extends StatelessWidget {
  const _Encabezado2();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        const IconHeader2(
          icon: Icons.info_rounded,
          titulo: 'Información',
        ),
        Positioned(
          left: 10,
          top: 50,
          child: RawMaterialButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreenRepr()),
              );
            },
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(15.0),
            child: const Icon(
              Icons.chevron_left_rounded,
              color: Colors.white,
              size: 40,
            ),
          ),
        ),
      ],
    );
  }
}
