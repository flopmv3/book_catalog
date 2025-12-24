import 'content.dart';

// Интерфейс репозитория: определяет, что он умеет.
abstract interface class ContentRepositoryInterface {
  // Получить список контента (книг) с сервера.
  Future<List<Content>> getContent();
}
