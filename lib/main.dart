import 'package:flutter/material.dart';

import 'book_app.dart';
import 'di/di.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setupLocator();

  FlutterError.onError = (details) {
    talker.handle(details.exception, details.stack);
  };

  runApp(const BookApp());
}
