import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solid_software_test_app/bloc/app_bloc.dart';
import 'package:solid_software_test_app/home_page.dart';
import 'package:solid_software_test_app/themes/color_theme.dart';

void main() {
  runApp(
    MultiBlocProvider(
    providers: [
      BlocProvider(create: (context) => AppBloc()),
    ],
    child: const MyApp(),
  ),
  );
}
  ///MyApp
class MyApp extends StatelessWidget {
  ///Constructor
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Solid Software Test App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorTheme.colorScheme,
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
