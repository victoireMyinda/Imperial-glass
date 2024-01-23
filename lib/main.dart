import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:icecream_service/business_logic/cubit/abonnement/cubit/abonnement_cubit.dart';
import 'package:icecream_service/business_logic/cubit/signup/cubit/signup_cubit.dart';
import 'package:icecream_service/config/router.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'dart:io';
// import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SignupCubit>(
          create: (BuildContext context) => SignupCubit(),
        ),
        BlocProvider<AbonnementCubit>(
          create: (BuildContext context) => AbonnementCubit(),
        ),
      ],
      child: AdaptiveTheme(
        light: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.blue,
          accentColor: Colors.white,
          backgroundColor: Colors.black54,
          bottomAppBarColor: Color(0xFFF5F5F5),
        ),
        dark: ThemeData(
            brightness: Brightness.dark,
            primarySwatch: Colors.blue,
            accentColor: Colors.black54,
            backgroundColor: Colors.white,
            bottomAppBarColor: Colors.black26),
        initial: AdaptiveThemeMode.light ,
        builder: (theme, darkTheme) => GetMaterialApp(
          localizationsDelegates: const [GlobalMaterialLocalizations.delegate],
          supportedLocales: const [Locale('en'), Locale('fr')],
          title: 'Icescream-Service',
          debugShowCheckedModeBanner: false,
          theme: theme,
          darkTheme: darkTheme,
          getPages: getPages(),
          initialRoute: '/',
        ),
      ),
    );
  }
}
