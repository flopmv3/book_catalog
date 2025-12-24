import 'package:dio/dio.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';

import '../../di/di.dart';

void setUpDio() {
  // Базовый URL Open Library
  dio.options.baseUrl = 'https://openlibrary.org';

  // Общие query-параметры нам не нужны
  // dio.options.queryParameters.addAll({});

  // Таймауты (можно увеличить при медленном интернете)
  dio.options.connectTimeout = const Duration(seconds: 15);
  dio.options.receiveTimeout = const Duration(seconds: 15);

  // Логгер запросов
  dio.interceptors.addAll([
    TalkerDioLogger(
      talker: talker,
      settings: const TalkerDioLoggerSettings(
        printRequestData: true,
        printRequestHeaders: true,
      ),
    ),
  ]);
}
