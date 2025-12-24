import 'package:dio/dio.dart';

import '../endpoints.dart';
import 'content.dart';
import 'content_repository_interface.dart';

class ContentRepository implements ContentRepositoryInterface {
  ContentRepository({required this.dio});

  final Dio dio;

  @override
  Future<List<Content>> getContent() async {
    try {
      // Запрос к Open Library:
      // https://openlibrary.org/search.json?q=harry+potter
      final Response response = await dio.get(
        Endpoints.content,
        queryParameters: {
          'q': 'harry potter', // фиксированный запрос для примера
        },
      );

      // В ответе Open Library книги лежат в поле "docs"
      final List<dynamic> docs = response.data['docs'] as List<dynamic>;

      // Преобразуем каждый doc в удобный JSON под нашу модель Content
      final List<Content> content = docs.map((e) {
        final doc = e as Map<String, dynamic>;

        final String id = (doc['key'] ?? '') as String;
        final String title = (doc['title'] ?? 'No title') as String;

        // author_name — список, берём первого автора
        final List<dynamic>? authors = doc['author_name'] as List<dynamic>?;
        final String author = (authors != null && authors.isNotEmpty)
            ? authors.first.toString()
            : 'Unknown author';

        final int? year = doc['first_publish_year'] as int?;

        // cover_i → картинка
        final int? coverId = doc['cover_i'] as int?;
        final String imageUrl = coverId != null
            ? 'https://covers.openlibrary.org/b/id/$coverId-M.jpg'
            : 'https://via.placeholder.com/100x150?text=No+Cover';

        // собираем мапу под Content.fromJson
        final mapForContent = <String, dynamic>{
          'id': id,
          'title': title,
          'author': author,
          'description':
              'First publish year: ${year ?? 'unknown'}', // просто инфа
          'image': imageUrl,
        };

        return Content.fromJson(mapForContent);
      }).toList();

      return content;
    } on DioException catch (e) {
      throw e.message ?? 'Unknown Dio error';
    } catch (e) {
      throw e.toString();
    }
  }
}
