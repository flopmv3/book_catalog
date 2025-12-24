/// Модель детальной информации о книге.
class ContentDetails {
  final String id;           // id работы (например, OL82563W)
  final String title;        // название книги
  final String description;  // описание / аннотация
  final String image;        // большая обложка

  ContentDetails({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
  });

  /// Создание объекта из ответа Open Library /works/{id}.json
  factory ContentDetails.fromWorkJson(
    Map<String, dynamic> json, {
    required String id,
  }) {
    final String title = (json['title'] ?? 'No title') as String;

    // description может быть строкой или объектом { "value": "..." }
    String description;
    final dynamic desc = json['description'];
    if (desc is String) {
      description = desc;
    } else if (desc is Map<String, dynamic>) {
      description = (desc['value'] ?? 'No description') as String;
    } else {
      description = 'Описание недоступно';
    }

    // covers: [12345] → обложка
    final List<dynamic>? covers = json['covers'] as List<dynamic>?;
    final int? coverId =
        covers != null && covers.isNotEmpty ? covers.first as int : null;

    final String imageUrl = coverId != null
        ? 'https://covers.openlibrary.org/b/id/$coverId-L.jpg'
        : 'https://via.placeholder.com/200x300?text=No+Cover';

    return ContentDetails(
      id: id,
      title: title,
      description: description,
      image: imageUrl,
    );
  }
}
