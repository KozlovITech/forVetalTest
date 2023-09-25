import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:solid_software_test_app/bloc/app_bloc.dart';
import 'package:solid_software_test_app/themes/color_theme.dart';
import 'package:solid_software_test_app/themes/text_theme.dart';

///BonusScreen
class BonusScreen extends StatelessWidget {
  ///Constructor
  const BonusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorTheme.dark_purple,
      appBar: AppBar(
        backgroundColor: ColorTheme.dark_purple,
        iconTheme: const IconThemeData(
          color: ColorTheme.white,
        ),
      ),
      body: BlocBuilder<AppBloc, AppState>(
        builder: _buildContent,
      ),
    );
  }

  Widget _buildContent(BuildContext context, AppState state) {
    final bool isTimerStarted = state.isTimerStarted;
    bool isShowingTime = state.isShowingTime;
    int tapCount = state.tapCount;

    return Stack(
      children: [
        if (!isTimerStarted && !isShowingTime)
          Center(
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Text(
                    "Try to catch the cat. The image of the cat will appear "
                        "randomly, then you need to catch it 10 times.",
                    style: Fonts.text,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    context
                        .read<AppBloc>()
                        .add(StartTimerAndShowImages(context: context));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorTheme.dark_orange,
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      "Start",
                      style: Fonts.bonus_buttons,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        if (isTimerStarted && !isShowingTime && tapCount < 10)
          GestureDetector(
            onTap: () {
              tapCount++;
              context.read<AppBloc>().add(ChangeCat(context: context));

              if (state.tapCount == 10) {
                isShowingTime = true;
                context.read<AppBloc>().add(ShowTimeAndReset(context: context));
              }
            },
            child: Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(
                    top: state.newTop,
                    left: state.newLeft,
                  ),
                  child: SvgPicture.asset(
                    state.element == ""
                        ? 'assets/img/cat_1.svg'
                        : state.element,
                    semanticsLabel: 'My SVG Image',
                    height: 100,
                    width: 100,
                    color: ColorTheme.white_70,
                  ),
                ),
              ],
            ),
          ),
        if (isShowingTime)
          Align(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Your result: ${AppBloc.timerValueInSeconds}.'
                      '${AppBloc.timerValueInMilliseconds ~/ 100} sec',
                  style: Fonts.text,
                ),
                const SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                  onPressed: () {
                    context.read<AppBloc>().add(ResetProcess(context: context));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorTheme.dark_orange,
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      "Restart",
                      style: Fonts.bonus_buttons,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
