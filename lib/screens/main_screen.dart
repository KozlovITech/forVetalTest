import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:solid_software_test_app/bloc/app_bloc.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}


class _MainScreenState extends State<MainScreen> {
  late AppState state;

  @override
  Widget build(BuildContext context) {
    state = context.watch<AppBloc>().state;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: state.backgroundColor,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: GestureDetector(
          onTap: () {
             context.read<AppBloc>().add(const ChangeBackgroundColorEvent());
          },
          child: BlocBuilder<AppBloc, AppState>(
            builder: (context,state) {
              print(state.element);
              return ColoredBox(
                color: state.backgroundColor,
                child:  Center(
                  child: Text(
                    "Hello there",
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.w600,
                      color: state.textColor,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}