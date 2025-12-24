import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

import '../data/dio/set_up.dart';
import '../data/content/content_repository.dart';
import '../data/content/content_repository_interface.dart';
import '../data/content/content_details_repository.dart';
import '../data/content/content_details_repository_interface.dart';
import '../app/features/home/bloc/home_bloc.dart';
import '../app/features/content/bloc/content_details_bloc.dart';

final getIt = GetIt.instance;

// Логгер
final talker = TalkerFlutter.init();

// HTTP-клиент
final Dio dio = Dio();

Future<void> setupLocator() async {
  setUpDio();

  // Логгер
  getIt.registerSingleton<Talker>(talker);

  // Репозиторий списка
  getIt.registerSingleton<ContentRepositoryInterface>(
    ContentRepository(dio: dio),
  );

  // BLoC списка
  getIt.registerSingleton<HomeBloc>(
    HomeBloc(getIt.get<ContentRepositoryInterface>()),
  );

  // Репозиторий деталей
  getIt.registerSingleton<ContentDetailsRepositoryInterface>(
    ContentDetailsRepository(dio: dio),
  );

  // BLoC деталей
  getIt.registerSingleton<ContentDetailsBloc>(
    ContentDetailsBloc(
      getIt.get<ContentDetailsRepositoryInterface>(),
    ),
  );
}
