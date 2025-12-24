import 'package:flutter/material.dart';

import '../home/book_mock.dart';

class ContentScreen extends StatelessWidget {
  final String contentId;

  const ContentScreen({
    super.key,
    required this.contentId,
  });

  @override
  Widget build(BuildContext context) {
    // ищем книгу по id
    final book = mockBooks.firstWhere(
      (b) => b.id == contentId,
      orElse: () => mockBooks.first,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(book.title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          spacing: 16,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  book.imagePath,
                  height: 220,
                  width: 160,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Text(
              book.title,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              'ID книги: ${book.id}',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Colors.grey[700]),
            ),
            const Divider(),
            Text(
              'Описание',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(
              book.description,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 24),
            Text(
              'Дополнительная информация',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(
              'Здесь позже можно будет вывести автора, год издания, жанр и другие данные, полученные из API.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
