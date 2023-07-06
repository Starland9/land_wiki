part of 'history_bloc.dart';

abstract class HistoryState extends Equatable {
  const HistoryState();

  @override
  List<Object> get props => [];
}

class HistoryInitial extends HistoryState {}

class HistoryLoading extends HistoryState {}

class HistoryLoaded extends HistoryState {
  final List<Wiki> wikis;

  const HistoryLoaded({required this.wikis});

  @override
  List<Object> get props => [wikis];
}

class HistoryError extends HistoryState {
  final String message;

  const HistoryError({required this.message});

  @override
  List<Object> get props => [message];
}
