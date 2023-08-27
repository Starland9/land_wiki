import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_tts/flutter_tts.dart';

part 'tts_event.dart';
part 'tts_state.dart';

class TtsBloc extends Bloc<TtsEvent, TtsState> {
  TtsBloc() : super(TtsInitial()) {
    on<StartTts>(
      (event, emit) async {
        emit(TtsRunning(text: event.text, tts: event.tts));

        event.tts.setLanguage("fr-FR");
        await event.tts.speak(event.text);
      },
    );

    on<StopTts>(
      (event, emit) {
        event.tts.pause();
        emit(TtsInitial());
      },
    );
  }
}
