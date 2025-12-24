part of 'home_bloc.dart';

// Базовый класс состояний домашнего экрана.
sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

// Начальное состояние.
final class HomeInitial extends HomeState {
  const HomeInitial();
}

// Состояние загрузки.
final class HomeLoadInProgress extends HomeState {
  const HomeLoadInProgress();
}

// Состояние успешной загрузки.
final class HomeLoadSuccess extends HomeState {
  const HomeLoadSuccess({required this.content});

  final List<Content> content;

  @override
  List<Object?> get props => [content];
}

// Состояние ошибки.
final class HomeLoadFailure extends HomeState {
  const HomeLoadFailure({required this.exception});

  final Object? exception;

  @override
  List<Object?> get props => [exception];
}
