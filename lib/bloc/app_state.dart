part of 'app_bloc.dart';

class AppState extends Equatable {
  final Color backgroundColor;
  final Color textColor;
  final List<String> list;
  final String element;
  final double newTop;
  final double newLeft;


  AppState({
    required this.backgroundColor,
    required this.textColor,
    required this.list,
    required this.element,
    required this.newTop,
    required this.newLeft,

  });

  @override
  List<Object?> get props => [
    backgroundColor,
    textColor,
    list,
    element,
    newTop,
    newLeft,

  ];
}