import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../di/di.dart';
import '../../../data/content/content.dart';
import '../../extensions/widget_extensions.dart';
import '../../widgets/content_card.dart';
import 'bloc/home_bloc.dart';


// Домашний экран приложения: список книг из API через BLoC.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Получаем HomeBloc из DI.
  final HomeBloc _homeBloc = getIt<HomeBloc>();

  void _loadHome() => _homeBloc.add(const HomeLoad());

  @override
  void initState() {
    super.initState();
    // При первом открытии экрана загружаем данные.
    _loadHome();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Главная')),

      body: BlocBuilder<HomeBloc, HomeState>(
        bloc: _homeBloc,
        builder: (context, state) {
          if (state is HomeInitial) {
            return const SizedBox.shrink();
          } else if (state is HomeLoadInProgress) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is HomeLoadSuccess) {
            return _buildHomeLoadSuccess(state);
          } else if (state is HomeLoadFailure) {
            return _buildHomeLoadFailure(state);
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }

  // Состояние: данные успешно загружены.
  Widget _buildHomeLoadSuccess(HomeLoadSuccess state) {
    final List<Content> content = state.content;

    return SingleChildScrollView(
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
            itemCount: content.length,
            itemBuilder: (_, index) {
              final item = content[index];
              return ContentCardFromContent(content: item);
            },
            separatorBuilder: (_, __) => 16.ph,
          ),
        ],
      ),
    );
  }

  // Состояние: ошибка загрузки.
  Widget _buildHomeLoadFailure(HomeLoadFailure state) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Ошибка загрузки данных'),
          const SizedBox(height: 8),
          Text(
            state.exception.toString(),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _loadHome,
            child: const Text('Повторить'),
          ),
        ],
      ),
    );
  }
}
