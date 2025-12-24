class Book {
  final String id;
  final String title;
  final String description;
  final String imagePath;

  const Book({
    required this.id,
    required this.title,
    required this.description,
    required this.imagePath,
  });
}

const mockBooks = <Book>[
  Book(
    id: '1',
    title: 'Война и мир',
    description:
        'Роман Льва Толстого о войне 1812 года и судьбах нескольких дворянских семей.',
    imagePath: 'assets/images/test_image.jpg',
  ),
  Book(
    id: '2',
    title: 'Преступление и наказание',
    description:
        'История Родионa Раскольниковa, студента, который совершает убийство и переживает моральный кризис.',
    imagePath: 'assets/images/test_image.jpg',
  ),
  Book(
    id: '3',
    title: 'Мастер и Маргарита',
    description:
        'Роман Михаила Булгакова, сочетающий сатиру, мистику и историю любви.',
    imagePath: 'assets/images/test_image.jpg',
  ),
];
