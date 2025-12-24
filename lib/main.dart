import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talker_bloc_logger/talker_bloc_logger.dart';

import 'book_app.dart';
import 'di/di.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setupLocator();

  // Логирование Flutter-ошибок.
  FlutterError.onError = (details) {
    talker.handle(details.exception, details.stack);
  };

  // Логирование событий/состояний BLoC.
  Bloc.observer = TalkerBlocObserver(talker: talker);

  runApp(const BookApp());
}
