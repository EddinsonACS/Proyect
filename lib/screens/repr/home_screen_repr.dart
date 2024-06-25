import 'package:flutter/material.dart';
import 'package:primerospasosapp/screens/repr/screen_repr.dart';
import 'package:primerospasosapp/widgets/botones.dart';
import 'package:primerospasosapp/widgets/headers.dart';
import 'package:primerospasosapp/widgets/widgets.dart';
import 'package:provider/provider.dart';

import '../../services/services.dart';

class ItemBoton {
  final IconData icon;
  final String texto;
  final Color color1;
  final Color color2;
  final void Function() onPressed;

  ItemBoton(this.icon, this.texto, this.color1, this.color2, this.onPressed);
}

class HomeScreenRepr extends StatelessWidget {
  const HomeScreenRepr({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    final items = <ItemBoton>[
      ItemBoton(
          Icons.add_a_photo_rounded,
          'Galeria',
          const Color.fromRGBO(49, 113, 131, 1),
          const Color.fromARGB(255, 45, 138, 104), () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const GaleriaScreenRepr()));
      }),
      ItemBoton(
          Icons.note_add_rounded,
          'Actividades',
          const Color.fromRGBO(49, 113, 131, 1),
          const Color.fromARGB(255, 45, 138, 104), () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const ActividadesScreenRepr()));
      }),
      ItemBoton(
          Icons.info_rounded,
          'Información',
          const Color.fromRGBO(49, 113, 131, 1),
          const Color.fromARGB(255, 45, 138, 104), () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const InfoScreenRepr()));
      }),
      ItemBoton(
          Icons.exit_to_app_rounded,
          'Salir',
          const Color.fromRGBO(49, 113, 131, 1),
          const Color.fromARGB(255, 45, 138, 104), () {
        authService.logout();
        Navigator.pushReplacementNamed(context, 'selectUser');
      }),
    ];

    List<Widget> itemMap = items
        .map((item) => Botones(
            icon: item.icon,
            texto: item.texto,
            color1: item.color1,
            color2: item.color2,
            onPressed: item.onPressed))
        .toList();

    return Scaffold(
        body: Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 270),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: <Widget>[
              const SizedBox(
                height: 10,
              ),
              ...itemMap
            ],
          ),
        ),
        const _Encabezado()
      ],
    ));
  }
}

class _Encabezado extends StatelessWidget {
  const _Encabezado();

  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: <Widget>[
        IconHeader(
            icon: Icons.person_pin,
            titulo: '¡Se Parte del Proceso!',
            subtitulo: 'Representante'),
      ],
    );
  }
}

class BotonesTemp extends StatelessWidget {
  const BotonesTemp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Botones(
      icon: Icons.add_a_photo_rounded,
      icon2: Icons.chevron_right_rounded,
      texto: 'Galeria',
      color1: const Color.fromARGB(255, 62, 89, 212),
      color2: const Color.fromARGB(255, 135, 78, 188),
      onPressed: () {},
    );
  }
}

class PageHeader extends StatelessWidget {
  const PageHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const IconHeader(
      icon: Icons.school_rounded,
      titulo: 'Eddinson Castillo',
      subtitulo: 'Representante',
    );
  }
}
