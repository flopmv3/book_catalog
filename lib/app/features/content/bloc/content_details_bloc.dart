import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../data/content/content_details.dart';
import '../../../../data/content/content_details_repository_interface.dart';
import '../../../../di/di.dart';

part 'content_details_event.dart';
part 'content_details_state.dart';

class ContentDetailsBloc
    extends Bloc<ContentDetailsEvent, ContentDetailsState> {
  final ContentDetailsRepositoryInterface repository;

  ContentDetailsBloc(this.repository)
      : super(const ContentDetailsInitial()) {
    on<ContentDetailsLoad>(_onLoad);
  }

  Future<void> _onLoad(
    ContentDetailsLoad event,
    Emitter<ContentDetailsState> emit,
  ) async {
    try {
      emit(const ContentDetailsLoadInProgress());

      final details = await repository.getContentDetails(event.id);

      emit(ContentDetailsLoadSuccess(details: details));
    } catch (e, stackTrace) {
      emit(ContentDetailsLoadFailure(exception: e));
      talker.handle(e, stackTrace);
    } finally {
      event.completer?.complete();
    }
  }
}
