class Endpoints {
  Endpoints._();

  // список книг (поиск)
  static const String content = '/search.json';

  // детальная информация о книге (work)
  // итоговый URL: https://openlibrary.org/works/{id}.json
  static String workById(String id) => '/works/$id.json';
}
