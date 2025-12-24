part of 'content_details_bloc.dart';

sealed class ContentDetailsState extends Equatable {
  const ContentDetailsState();

  @override
  List<Object?> get props => [];
}

class ContentDetailsInitial extends ContentDetailsState {
  const ContentDetailsInitial();
}

class ContentDetailsLoadInProgress extends ContentDetailsState {
  const ContentDetailsLoadInProgress();
}

class ContentDetailsLoadSuccess extends ContentDetailsState {
  const ContentDetailsLoadSuccess({required this.details});

  final ContentDetails details;

  @override
  List<Object?> get props => [details];
}

class ContentDetailsLoadFailure extends ContentDetailsState {
  const ContentDetailsLoadFailure({required this.exception});

  final Object? exception;

  @override
  List<Object?> get props => [exception];
}
