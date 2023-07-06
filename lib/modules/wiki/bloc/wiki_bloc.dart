import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../api/api.dart';
import '../model.dart';

part 'wiki_event.dart';
part 'wiki_state.dart';

class WikiBloc extends Bloc<WikiEvent, WikiState> {
  WikiBloc() : super(WikiInitial()) {
    on<GetWiki>((event, emit) async {
      emit(WikiLoading());
      try {
        final result = await AppApi.getWiki(text: event.text);
        if (result is Wiki) {
          await AppApi.appendWiki(result);
          emit(WikiLoaded(wiki: result));
        } else {
          emit(WikiError(message: result.toString()));
        }
      } catch (e) {
        emit(WikiError(message: e.toString()));
      }
    });
  }
}
