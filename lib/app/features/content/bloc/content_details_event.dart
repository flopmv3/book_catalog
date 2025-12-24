part of 'content_details_bloc.dart';

sealed class ContentDetailsEvent extends Equatable {
  const ContentDetailsEvent();

  @override
  List<Object?> get props => [];
}

class ContentDetailsLoad extends ContentDetailsEvent {
  const ContentDetailsLoad({
    required this.id,
    this.completer,
  });

  final String id;
  final Completer<void>? completer;

  @override
  List<Object?> get props => [id, completer];
}
