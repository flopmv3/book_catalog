import 'content_details.dart';

/// Интерфейс репозитория для второго экрана (детали книги).
abstract interface class ContentDetailsRepositoryInterface {
  Future<ContentDetails> getContentDetails(String id);
}
