part of 'app_bloc.dart';


@immutable
abstract class AppEvent {
  const AppEvent();
}


class ChangeCat extends AppEvent {
  final BuildContext context;

  ChangeCat({required this.context});
}

class StopTimerEvent extends AppEvent {}

class StartTimerAndShowImages extends AppEvent {
  final BuildContext context;

  StartTimerAndShowImages({required this.context});
}

class ResetProcess extends AppEvent {
  final BuildContext context;

  ResetProcess({required this.context});
}

class ShowTimeAndReset extends AppEvent {
  final BuildContext context;

  ShowTimeAndReset({required this.context});
}

class UpdateTapCount extends AppEvent {
   int tapCount ;

   UpdateTapCount({required this.tapCount});

  @override
  List<Object> get props => [tapCount];
}

