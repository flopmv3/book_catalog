class Endpoints {
  Endpoints._();

  // поиск книг
  // итоговый URL: https://openlibrary.org/search.json?q=harry+potter
  static const String content = '/search.json';

  // на будущее: детальная книга по ключу (например, "/works/OL82563W")
  static String workByKey(String key) => '$key.json';
}
