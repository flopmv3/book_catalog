import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../data/content/content.dart';
import '../../../../data/content/content_repository_interface.dart';
import '../../../../di/di.dart';

part 'home_event.dart';
part 'home_state.dart';

// BLoC домашнего экрана: управляет состояниями списка контента.
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ContentRepositoryInterface contentRepository;

  HomeBloc(this.contentRepository) : super(const HomeInitial()) {
    on<HomeLoad>(_homeLoad);
  }

  Future<void> _homeLoad(HomeLoad event, Emitter<HomeState> emit) async {
    try {
      // Если ещё не загружено — показываем индикатор загрузки.
      if (state is! HomeLoadSuccess) {
        emit(const HomeLoadInProgress());
      }

      // Запрос данных у репозитория (HTTP).
      final content = await contentRepository.getContent();

      // Успех: отдаём состояние с полученными данными.
      emit(HomeLoadSuccess(content: content));
    } catch (exception, stackTrace) {
      // Ошибка: состояние ошибки + логирование в talker.
      emit(HomeLoadFailure(exception: exception));
      talker.handle(exception, stackTrace);
    } finally {
      // Если был передан Completer (например, pull-to-refresh) — завершаем.
      event.completer?.complete();
    }
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    talker.handle(error, stackTrace);
  }
}
