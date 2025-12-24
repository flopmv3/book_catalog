import 'package:flutter/material.dart';

import '../../extensions/widget_extensions.dart';
import '../../widgets/content_card.dart';
import 'book_mock.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Главная')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          spacing: 20,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Каталог книг',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            ListView.separated(
              primary: false,
              shrinkWrap: true,
              itemCount: mockBooks.length,
              itemBuilder: (_, index) => ContentCard(book: mockBooks[index]),
              separatorBuilder: (_, __) => 16.ph,
            ),
          ],
        ),
      ),
    );
  }
}
