import 'package:json_annotation/json_annotation.dart';

part 'content.g.dart';

/// Упрощённая модель книги для приложения.
@JsonSerializable()
class Content {
  final String id;            // id (ключ работы Open Library)
  final String title;         // название
  final String author;        // автор
  final String description;   // описание / дополнительная инфа
  final String image;         // URL обложки

  Content({
    required this.id,
    required this.title,
    required this.author,
    required this.description,
    required this.image,
  });

  factory Content.fromJson(Map<String, dynamic> json) =>
      _$ContentFromJson(json);

  Map<String, dynamic> toJson() => _$ContentToJson(this);
}
