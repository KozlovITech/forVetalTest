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
  int tapCount = 0;
  int timerValueAfter10Taps = 0;
  bool isTimerStarted = false;
  bool isShowingTime = false;

  @override
  void initState() {
    super.initState();
  }

  void startTimerAndShowImages() {
    setState(() {
      isTimerStarted = true;
      isShowingTime = false; // Скинути прапорець, щоб приховати відображення часу
    });

    // Додайте скидання значення таймера до 0
    AppBloc.timerValue.value = 0;

    AppBloc.startTimer();
  }

  void resetProcess() {
    setState(() {
      isTimerStarted = false;
      tapCount = 0;
      isShowingTime = false;
    });
    startTimerAndShowImages();
    // Create an instance of AppBloc and call the stopTimer method
    context.read<AppBloc>().stopTimer();
  }

  void showTimeAndReset() {
    setState(() {
      isShowingTime = true; // Show the time display
      timerValueAfter10Taps = AppBloc.timerValue.value;
    });
    context.read<AppBloc>().stopTimer();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(20, 24, 35, 1),
      appBar: AppBar(
        // title: Text('Bonus Screen'),
        backgroundColor: const Color.fromRGBO(20, 24, 35, 1),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
        child: Stack(
          children: [
            if (!isTimerStarted && !isShowingTime)
              Center(
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Text("Try to catch the cat. The image of the cat will appear randomly, then you need to catch it 10 times.",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                    ),

                    ElevatedButton(
                      onPressed: startTimerAndShowImages,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(240, 83, 21, 1),
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
            if (isTimerStarted && !isShowingTime)
              GestureDetector(
                onTap: () {
                  tapCount++;
                  context.read<AppBloc>().add(ChangeCat(context: context));
                  context.read<AppBloc>().stopTimer();

                  if (tapCount == 10) {
                    showTimeAndReset();
                  }
                },
                child: BlocBuilder<AppBloc, AppState>(
                  builder: (context, state) {
                    print(state.element);
                    return Stack(
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
                    );
                  },
                ),
              ),
            if (isShowingTime)
              Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Your result: $timerValueAfter10Taps sec',
                      style: const TextStyle(fontSize: 24,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 15,),
                    ElevatedButton(
                      onPressed: resetProcess,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(240, 83, 21, 1),
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
      ),
    );
  }
}
