import 'dart:async';
import 'dart:math';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'app_event.dart';
part 'app_state.dart';

///Bloc
///
class AppBloc extends Bloc<AppEvent, AppState> {
  final List<String> _list = [
    'assets/img/cat_1.svg',
    'assets/img/cat_2.svg',
    'assets/img/cat_3.svg',
    'assets/img/cat_4.svg',
    'assets/img/cat_5.svg',
  ];

  static int _pressCount = 0;
  static int _tapCount = 0;

  ///Max Press to image
  static const int maxPressCount = 10;
  Timer? _timer;

  ///Variable for timer
  static int timerValueInSeconds = 0;

  ///Variable for timer
  static int timerValueInMilliseconds = 0;

  ///Variable for timer
  static ValueNotifier<int> timerValue = ValueNotifier<int>(0);

  ///Function Stop Timer
  void stopTimer() {
    if (_pressCount >= maxPressCount) {
      _timer?.cancel();
      timerValue.value = 0;
    }
  }

  ///Function Start Timer
  void startTimer() {
    _pressCount = 0;
    _tapCount = 0;
    _timer?.cancel();

    _timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
      timerValueInMilliseconds += 100; // Update timer by 100 milliseconds
      if (timerValueInMilliseconds >= 1000) {
        timerValueInMilliseconds = 0;
        timerValueInSeconds++;
      }
      if (_tapCount >= maxPressCount) {
        timer.cancel();
      }
    });
  }
///Construcor
  AppBloc()
      : super(AppState(
          backgroundColor: Colors.white,
          textColor: Colors.black,
          list: [],
          element: '',
          newLeft: 0,
          newTop: 0,
          pressCount: 0,
          isTimerStarted: false,
        )) {
    on<ChangeBackgroundColorEvent>((event, emit) {
      final backColor = Color(Random().nextInt(0xFFFFFFFF)).withOpacity(1.0);
      emit(AppState(
        backgroundColor: backColor,
        textColor: state.textColor,
        list: [],
        element: '',
        newLeft: 0,
        newTop: 0,
        pressCount: 0,
      ));
    });

    on<ChangeTextColorEvent>((event, emit) {
      final textColor = Color(Random().nextInt(0xFFFFFFFF)).withOpacity(1.0);
      emit(AppState(
        backgroundColor: state.backgroundColor,
        textColor: textColor,
        list: [],
        element: '',
        newLeft: 0,
        newTop: 0,
        pressCount: 0,
      ));
    });

    on<ChangeCat>((event, emit) async {
      final String _element = _list[Random().nextInt(_list.length)];

      final screenWidth = MediaQuery.of(event.context).size.width;
      final screenHeight = MediaQuery.of(event.context).size.height;
      final imageWidth = 100.0;
      final imageHeight = 100.0;

      final maxLeft = screenWidth - imageWidth;
      final maxTop = screenHeight - imageHeight;

      final _newLeft = Random().nextDouble() * maxLeft;
      final _newTop = Random().nextDouble() * maxTop;
      _tapCount++;
      bool _isTimerStarted = true;
      bool _isShowingTimer = false;
      if (_tapCount == 10) {
        _isShowingTimer = true;
      } else {
        _isShowingTimer = false;
      }
      emit(AppState(
        backgroundColor: state.backgroundColor,
        textColor: state.textColor,
        list: _list,
        element: _element,
        newLeft: _newLeft,
        newTop: _newTop,
        pressCount: _pressCount,
        isTimerStarted: _isTimerStarted,
        isShowingTime: _isShowingTimer,
        tapCount: _tapCount,
      ));
    });

    on<StopTimerEvent>((event, emit) {
      stopTimer();
    });

    on<StartTimerAndShowImages>((event, emit) {
      bool _isTimerStarted = true;
      bool _isShowingTime = false;
      int _timervalue = AppBloc.timerValue.value = 0;
      final BuildContext context = event.context;
      // Create an instance of AppBloc
      final appBloc = context.read<AppBloc>();

      // Call startTimer on the instance
      appBloc.startTimer();
      emit(AppState(
        backgroundColor: state.backgroundColor,
        textColor: state.textColor,
        list: [],
        element: '',
        newLeft: 0,
        newTop: 0,
        pressCount: 0,
        isTimerStarted: _isTimerStarted,
        isShowingTime: _isShowingTime,
        timerValueAfter10Taps: _timervalue,
      ));
    });

    on<ResetProcess>((event, emit) {
      bool _isTimerStarted = false;
      bool _isShowingTime = false;
      int _tapcounts = 0;

      // Обнулення значень таймера
      timerValueInSeconds = 0;
      timerValueInMilliseconds = 0;

      final BuildContext context = event.context;
      emit(AppState(
        backgroundColor: state.backgroundColor,
        textColor: state.textColor,
        list: [],
        element: '',
        newLeft: 0,
        newTop: 0,
        pressCount: 0,
        isTimerStarted: _isTimerStarted,
        isShowingTime: _isShowingTime,
        tapCount: _tapcounts,
      ));
      context.read<AppBloc>().add(StartTimerAndShowImages(context: context));
      context.read<AppBloc>().stopTimer();
    });

    /// Base of all things.
    on<ShowTimeAndReset>((event, emit) {
      /// Initialize the base.
      bool _isShowingTime = true;
      int _timerValueAfter10Taps = AppBloc.timerValue.value;
      final BuildContext context = event.context;
      context.read<AppBloc>().stopTimer();
      emit(AppState(
        backgroundColor: state.backgroundColor,
        textColor: state.textColor,
        list: [],
        element: '',
        newLeft: 0,
        newTop: 0,
        pressCount: 0,
        isShowingTime: _isShowingTime,
        timerValueAfter10Taps: _timerValueAfter10Taps,
      ));
    });

    on<UpdateTapCount>((event, emit) {
      stopTimer();
      emit(AppState(
          backgroundColor: state.backgroundColor,
          textColor: state.textColor,
          list: [],
          element: '',
          newLeft: 0,
          newTop: 0,
          pressCount: 0,
          tapCount: event.tapCount));
    });
  }
}
