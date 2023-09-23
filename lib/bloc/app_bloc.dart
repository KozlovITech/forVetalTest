import 'dart:math';
import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'app_event.dart';
part 'app_state.dart';

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
  static const int maxPressCount = 10;
  Timer? _timer;

  static ValueNotifier<int> timerValue = ValueNotifier<int>(0);

  void stopTimer() {
    if (_pressCount >= maxPressCount) {
      _timer?.cancel();
      timerValue.value = 0;
    }
  }

  static void startTimer() {
    _pressCount = 0;
    _tapCount = 0;
    Timer.periodic(Duration(seconds: 1), (timer) {
      timerValue.value += 1;
      if (_tapCount >= maxPressCount) {
        timer.cancel();
      }
    });
  }

  AppBloc()
      : super(AppState(
    backgroundColor: Colors.white,
    textColor: Colors.black,
    list: [],
    element: '',
    newLeft: 0,
    newTop: 0,

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

      emit(AppState(
        backgroundColor: state.backgroundColor,
        textColor: state.textColor,
        list: _list,
        element: _element,
        newLeft: _newLeft,
        newTop: _newTop,

      ));
    });

  }
}