import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

import '../data/dio/set_up.dart';
import '../data/content/content_repository.dart';
import '../data/content/content_repository_interface.dart';
import '../app/features/home/bloc/home_bloc.dart';

final getIt = GetIt.instance;

// Логгер
final talker = TalkerFlutter.init();

// HTTP-клиент Dio (один на всё приложение)
final Dio dio = Dio();

Future<void> setupLocator() async {
  // Настраиваем Dio (baseUrl, логгер и т.п.)
  setUpDio();

  // Регистрируем логгер
  getIt.registerSingleton<Talker>(talker);

  // Регистрируем репозиторий контента (книг)
  getIt.registerSingleton<ContentRepositoryInterface>(
    ContentRepository(dio: dio),
  );

  // Регистрируем BLoC для домашнего экрана
  getIt.registerSingleton<HomeBloc>(
    HomeBloc(getIt.get<ContentRepositoryInterface>()),
  );
}
