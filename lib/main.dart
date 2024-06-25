import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:primerospasosapp/firebase_options.dart';
import 'package:primerospasosapp/screens/repr/screen_repr.dart';
import 'package:primerospasosapp/services/services.dart';
import 'package:provider/provider.dart';

import 'screens/inst/screen_inst.dart';
import 'screens/screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => AuthService())],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Primeros Pasos',
      initialRoute: 'splash',
      routes: {
        'splash': (_) => const SplashScreen(),
        'checkauth': (_) => const CheckAuthScreen(),
        'login': (_) => const LoginScreen(),
        'register': (_) => const RegisterScreen(),
        'homeInst': (_) => const HomeScreenInst(),
        'homeRepr': (_) => const HomeScreenRepr(),
        'selectUser': (_) => const SelectUserScreen(),
      },
      scaffoldMessengerKey: NotificationsService.messengerKey,
      theme: ThemeData.light().copyWith(
          scaffoldBackgroundColor: const Color.fromRGBO(189, 189, 189, 1)),
    );
  }
}
