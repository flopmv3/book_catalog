part of 'home_bloc.dart';

// Базовый класс событий домашнего экрана.
sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

// Событие: загрузить данные для домашнего экрана.
class HomeLoad extends HomeEvent {
  const HomeLoad({this.completer});

  final Completer<void>? completer;

  @override
  List<Object?> get props => [completer];
}
