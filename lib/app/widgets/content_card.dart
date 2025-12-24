import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../data/content/content.dart';

/// Карточка книги, полученной из API (Content).
class ContentCardFromContent extends StatelessWidget {
  final Content content;

  const ContentCardFromContent({
    super.key,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    const imageSize = 100.0;

    return InkWell(
      // При нажатии переходим на экран деталей, передаём id
      onTap: () => context.push('/content/${content.id}'),
      borderRadius: BorderRadius.circular(16),
      child: SizedBox(
        height: imageSize,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Обложка
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                content.image,
                height: imageSize,
                width: imageSize,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) {
                  return Container(
                    height: imageSize,
                    width: imageSize,
                    color: Colors.grey[300],
                    child: const Icon(Icons.book),
                  );
                },
              ),
            ),
            const SizedBox(width: 16),
            // Текстовая часть
            Expanded(
              child: Column(
                spacing: 4,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    content.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text(
                    content.author,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 4),
                  Expanded(
                    child: Text(
                      content.description,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
