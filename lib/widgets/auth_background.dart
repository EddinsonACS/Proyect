import 'package:flutter/material.dart';

class AuthBackgrond extends StatelessWidget {
  final Widget child;

  const AuthBackgrond({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          const _CabeceraVerde(),
          const _LogoCabecera(),
          child,
        ],
      ),
    );
  }
}

class _LogoCabecera extends StatelessWidget {
  const _LogoCabecera();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 60),
        child: Image.asset(
          'assets/logo.png',
          width: 150,
          height: 150,
        ),
      ),
    );
  }
}

class _CabeceraVerde extends StatelessWidget {
  const _CabeceraVerde();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      //color: Colors.tealAccent[700],
      width: double.infinity,
      height: size.height * 0.6,
      decoration: _decoracionCabecera(),
      child: const Stack(children: [
        Positioned(
          top: 230,
          left: 30,
          child: _BolasCabecera(),
        ),
        Positioned(
          top: -20,
          left: -30,
          child: _BolasCabecera(),
        ),
        Positioned(
          top: -50,
          right: -20,
          child: _BolasCabecera(),
        ),
        Positioned(
          bottom: -20,
          left: 10,
          child: _BolasCabecera(),
        ),
        Positioned(
          bottom: 300,
          right: 20,
          child: _BolasCabecera(),
        ),
        Positioned(
          bottom: 60,
          right: -10,
          child: _BolasCabecera(),
        ),
      ]),
    );
  }

  BoxDecoration _decoracionCabecera() => const BoxDecoration(
      gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [Color(0xFF06606E), Color(0xA9037584)]));
}

class _BolasCabecera extends StatelessWidget {
  const _BolasCabecera();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: const Color.fromARGB(105, 4, 172, 161)),
    );
  }
}
