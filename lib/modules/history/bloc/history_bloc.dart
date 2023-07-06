import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../api/api.dart';
import '../../wiki/model.dart';

part 'history_event.dart';
part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  HistoryBloc() : super(HistoryInitial()) {
    on<GetHistory>((event, emit) async {
      emit(HistoryLoading());
      try {
        final result = await AppApi.getWikiList();
        emit(HistoryLoaded(wikis: result));
      } catch (e) {
        emit(HistoryError(message: e.toString()));
      }
    });

    
  }
}
