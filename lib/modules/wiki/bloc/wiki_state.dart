part of 'wiki_bloc.dart';

abstract class WikiState extends Equatable {
  const WikiState();

  @override
  List<Object> get props => [];
}

class WikiInitial extends WikiState {}

class WikiLoading extends WikiState {}

class WikiLoaded extends WikiState {
  final Wiki wiki;

  const WikiLoaded({
    required this.wiki,
  });

  @override
  List<Object> get props => [wiki];
}

class WikiError extends WikiState {
  final String message;

  const WikiError({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}
