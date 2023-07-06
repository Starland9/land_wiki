part of 'tts_bloc.dart';

abstract class TtsState extends Equatable {
  const TtsState();

  @override
  List<Object> get props => [];
}

class TtsInitial extends TtsState {}

class TtsRunning extends TtsState {
  final String text;
  final FlutterTts tts;

  const TtsRunning({
    required this.text,
    required this.tts,
  });
  @override
  List<Object> get props => [text, tts];
}

class TtsFinished extends TtsState {}

class TtsError extends TtsState {
  final String message;

  const TtsError({required this.message});
  @override
  List<Object> get props => [message];
}

