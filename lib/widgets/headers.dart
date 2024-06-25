import 'package:flutter/material.dart';

class IconHeader extends StatelessWidget {
  final IconData icon;
  final String titulo;
  final String subtitulo;
  final Color color1;
  final Color color2;

  const IconHeader({
    super.key,
    required this.icon,
    required this.titulo,
    required this.subtitulo,
    this.color1 = const Color.fromRGBO(6, 96, 110, 1),
    this.color2 = const Color.fromRGBO(3, 117, 132, 0.663),
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        _IconHeaderBackground(color1, color2, icon),
        Positioned(
            top: -10,
            left: -80,
            child: Icon(icon, size: 250, color: Colors.white.withOpacity(0.2))),
        Column(
          children: <Widget>[
            const SizedBox(
              height: 80,
              width: double.infinity,
            ),
            Text(
              subtitulo,
              style:
                  TextStyle(fontSize: 20, color: Colors.white.withOpacity(0.7)),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              titulo,
              style: const TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            Icon(icon, size: 120, color: Colors.white),
          ],
        )
      ],
    );
  }
}

class _IconHeaderBackground extends StatelessWidget {
  final Color color1;
  final Color color2;
  final IconData icon;

  const _IconHeaderBackground(this.color1, this.color2, this.icon);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 300,
      decoration: BoxDecoration(
          borderRadius:
              const BorderRadius.only(bottomLeft: Radius.circular(80)),
          gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: <Color>[color1, color2])),
    );
  }
}
