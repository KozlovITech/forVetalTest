import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:solid_software_test_app/bloc/app_bloc.dart';

class BonusScreen extends StatefulWidget {
  const BonusScreen({Key? key}) : super(key: key);

  @override
  State<BonusScreen> createState() => _BonusScreenState();
}

class _BonusScreenState extends State<BonusScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(20, 24, 35, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(20, 24, 35, 1),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: BlocBuilder<AppBloc, AppState>(
        builder: (context, state) {
          bool isTimerStarted = state.isTimerStarted;
          bool isShowingTime = state.isShowingTime;
          int tapCount = state.tapCount;
          int timerValueAfter10Taps = state.timerValueAfter10Taps;
          return Container(
            child: Stack(
              children: [
                if (!isTimerStarted && !isShowingTime)
                  Center(
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Text(
                            "Try to catch the cat. The image of the cat will appear randomly, then you need to catch it 10 times.",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            print("Is timeSterted before startTimerAndShowImages $isTimerStarted");
                            print("Is TapCount before startTimerAndShowImages $tapCount");
                            print("Is time Sterted before startTimerAndShowImages $isShowingTime");

                            context
                                .read<AppBloc>()
                                .add(StartTimerAndShowImages(context: context));


                            print("Is timeSterted after startTimerAndShowImages $isTimerStarted");
                            print("Is TapCount after startTimerAndShowImages $tapCount");
                            print("Is time Sterted after startTimerAndShowImages $isShowingTime");

                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromRGBO(240, 83, 21, 1),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                              "Start",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
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
                      print("Is timeSterted before GestureDetector $isTimerStarted");
                      print("Is TapCount before GestureDetector $tapCount");
                      print("Is isShowingTime before GestureDetector $isShowingTime");

                      tapCount++;
                      context.read<AppBloc>().add(ChangeCat(context: context));



                      if (state.tapCount == 10) {
                        isShowingTime = true;
                        context.read<AppBloc>().add(
                            ShowTimeAndReset(context: context)
                        );
                      }

                      print("Is timeSterted after GestureDetector $isTimerStarted");
                      print("Is TapCount after GestureDetector $tapCount");
                      print("Is isShowingTime after GestureDetector $isShowingTime");
                      print(AppBloc.timerValue.value);
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
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ),
                if (isShowingTime)
                  Align(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Your result: ${AppBloc.timerValue.value} sec',
                          style: const TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            print("Is timeSterted before ResetProcess $isTimerStarted");
                            print("Is TapCount before ResetProcess $tapCount");
                            print("Is time Sterted before ResetProcess $isShowingTime");

                            context
                                .read<AppBloc>()
                                .add(ResetProcess(context: context));

                            print("Is timeSterted after ResetProcess $isTimerStarted");
                            print("Is TapCount after ResetProcess $tapCount");
                            print("Is time Sterted after ResetProcess $isShowingTime");

                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromRGBO(240, 83, 21, 1),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                              "Restart",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
