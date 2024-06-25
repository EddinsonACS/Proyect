import 'package:flutter/material.dart';

class Botones extends StatelessWidget {
  final IconData icon;
  final IconData icon2;
  final String texto;
  final Color color1;
  final Color color2;
  final void Function() onPressed;

  const Botones(
      {super.key,
      this.icon = Icons.chevron_right_rounded,
      this.icon2 = Icons.chevron_right_rounded,
      required this.texto,
      this.color1 = const Color.fromARGB(255, 6, 63, 110),
      this.color2 = const Color.fromARGB(255, 52, 102, 141),
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Stack(
        children: <Widget>[
          _BotonesBackground(icon, color1, color2),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(
                height: 140,
                width: 50,
              ),
              Icon(
                icon,
                color: Colors.white,
                size: 40,
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Text(
                  texto,
                  style: const TextStyle(color: Colors.white, fontSize: 22),
                ),
              ),
              Icon(
                icon2,
                color: Colors.white,
                size: 60,
              ),
              const SizedBox(
                width: 40,
              )
            ],
          )
        ],
      ),
    );
  }
}

class _BotonesBackground extends StatelessWidget {
  final IconData icon;
  final Color color1;
  final Color color2;

  const _BotonesBackground(this.icon, this.color1, this.color2);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100,
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black.withOpacity(0.9),
                offset: const Offset(4, 6),
                blurRadius: 10)
          ],
          borderRadius: BorderRadius.circular(18),
          gradient: LinearGradient(colors: <Color>[color1, color2])),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Stack(
          children: <Widget>[
            Positioned(
                right: -5,
                top: -13,
                child:
                    Icon(icon, size: 150, color: Colors.white.withOpacity(0.2)))
          ],
        ),
      ),
    );
  }
}
