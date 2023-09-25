part of 'main_screen_bloc.dart';


@immutable
abstract class MainScreenEvent {
  const MainScreenEvent();
}
class ChangeBackgroundColorEvent extends MainScreenEvent {
const ChangeBackgroundColorEvent();
}

