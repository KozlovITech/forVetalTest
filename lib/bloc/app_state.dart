part of 'app_bloc.dart';

///A part of Bloc
class AppState extends Equatable {

  final List<String> list;
  final String element;
  final double newTop;
  final double newLeft;
  final int pressCount;
  final int tapCount;
  final int timerValueAfter10Taps;
  final bool isTimerStarted;
  final bool isShowingTime;

  @override
  List<Object?> get props => [

    list,
    element,
    newTop,
    newLeft,
    pressCount,
    tapCount,
    timerValueAfter10Taps,
    isTimerStarted,
    isShowingTime,
  ];
  ///Constructor
const  AppState({

    required this.list,
    required this.element,
    required this.newTop,
    required this.newLeft,
     this.pressCount = 0,
    this.tapCount = 0,
    this.timerValueAfter10Taps = 0,
    this.isTimerStarted = false,
    this.isShowingTime = false,
  });


}
