import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'main_screen_event.dart';
part 'main_screen_state.dart';

class MainScreenBloc extends Bloc<MainScreenEvent, MainScreenState> {
  MainScreenBloc() : super(MainScreenState(
    backgroundColor: Colors.white,
  )) {

    on<ChangeBackgroundColorEvent>((event, emit) {
      final backColor = Color(Random().nextInt(0xFFFFFFFF)).withOpacity(1.0);
      emit(MainScreenState(
        backgroundColor: backColor,
      ));
    });


  }
}
