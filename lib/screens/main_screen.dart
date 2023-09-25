import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solid_software_test_app/bloc/app_bloc.dart';

///MainScreen
class MainScreen extends StatelessWidget {
  ///Constructor
  MainScreen({super.key});

  /// variable
  late AppState state;

  /// Color check
  bool isShadeOfWhite(Color color) {
    final brightness = ThemeData.estimateBrightnessForColor(color);
    return brightness == Brightness.light;
  }

  @override
  Widget build(BuildContext context) {
    state = context.watch<AppBloc>().state;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: state.backgroundColor,
        leading: Builder(
          builder: (BuildContext context) {
            final isArrowBlack = isShadeOfWhite(state.backgroundColor);
            final iconColor = isArrowBlack ? Colors.black : Colors.white;
            return IconButton(
              icon: Icon(Icons.arrow_back, color: iconColor),
              onPressed: () {
                Navigator.of(context).pop();
              },
            );
          },
        ),
      ),
      body: Center(
        child: GestureDetector(
          onTap: () {
            context.read<AppBloc>().add(const ChangeBackgroundColorEvent());
          },
          child: BlocBuilder<AppBloc, AppState>(
              builder: (context, state) => ColoredBox(
                    color: state.backgroundColor,
                    child: Center(
                      child: Text(
                        "Hello there",
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.w600,
                          color: state.textColor,
                        ),
                      ),
                    ),
                  )),
        ),
      ),
    );
  }
}
