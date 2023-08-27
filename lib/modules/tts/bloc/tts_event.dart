part of 'tts_bloc.dart';

abstract class TtsEvent extends Equatable {
  const TtsEvent();

  @override
  List<Object> get props => [];
}

class StartTts extends TtsEvent {
  final String text;
  final FlutterTts tts;

  const StartTts({required this.text, required this.tts});
}

class StopTts extends TtsEvent {
  final FlutterTts tts;

  const StopTts({required this.tts});
}

class PauseTts extends TtsEvent {
  final FlutterTts tts;

  const PauseTts({required this.tts});
}

class ContinueTts extends TtsEvent {
  final String text;
  final FlutterTts tts;

  const ContinueTts({required this.text, required this.tts});
}
