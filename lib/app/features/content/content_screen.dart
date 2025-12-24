import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../di/di.dart';
import '../../../data/content/content_details.dart';
import '../../extensions/widget_extensions.dart';
import 'bloc/content_details_bloc.dart';

class ContentScreen extends StatefulWidget {
  const ContentScreen({
    super.key,
    required this.contentId,
  });

  final String contentId;

  @override
  State<ContentScreen> createState() => _ContentScreenState();
}

class _ContentScreenState extends State<ContentScreen> {
  late final ContentDetailsBloc _bloc;

  void _load() {
    _bloc.add(ContentDetailsLoad(id: widget.contentId));
  }

  @override
  void initState() {
    super.initState();
    _bloc = getIt<ContentDetailsBloc>();
    _load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Детали книги'),
      ),
      body: BlocBuilder<ContentDetailsBloc, ContentDetailsState>(
        bloc: _bloc,
        builder: (context, state) {
          if (state is ContentDetailsInitial) {
            return const SizedBox.shrink();
          } else if (state is ContentDetailsLoadInProgress) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ContentDetailsLoadSuccess) {
            return _buildSuccess(state.details);
          } else if (state is ContentDetailsLoadFailure) {
            return _buildFailure(state);
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }

  Widget _buildSuccess(ContentDetails details) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        spacing: 16,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                details.image,
                height: 220,
                width: 160,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) {
                  return Container(
                    height: 220,
                    width: 160,
                    color: Colors.grey[300],
                    child: const Icon(Icons.book, size: 40),
                  );
                },
              ),
            ),
          ),
          Text(
            details.title,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          Text(
            'ID: ${details.id}',
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
            details.description,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }

  Widget _buildFailure(ContentDetailsLoadFailure state) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Ошибка загрузки деталей'),
          const SizedBox(height: 8),
          Text(
            state.exception.toString(),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _load,
            child: const Text('Повторить'),
          ),
        ],
      ),
    );
  }
}
