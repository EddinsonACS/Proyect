import 'package:flutter/material.dart';
import 'package:primerospasosapp/screens/screen.dart';
import 'package:primerospasosapp/services/auth_service.dart';
import 'package:primerospasosapp/services/services.dart';
import 'package:provider/provider.dart';

import 'inst/screen_inst.dart';

class CheckAuthScreen extends StatelessWidget {
  const CheckAuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);

    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: authService.readToken(),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (!snapshot.hasData) return const Text('');

            if (snapshot.data == '') {
              Future.microtask(() {
                Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                        pageBuilder: (_, __, ___) => const SelectUserScreen(),
                        //  pageBuilder: (_, __, ___) => const SelectUserScreen(),
                        transitionDuration: const Duration(seconds: 0)));
              });
            } else {
              Future.microtask(() {
                Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                        pageBuilder: (_, __, ___) => const HomeScreenInst(),
                        // pageBuilder: (_, __, ___) => const SelectUserScreen(),
                        transitionDuration: const Duration(seconds: 0)));
              });
            }

            return Container();
          },
        ),
      ),
    );
  }
}
