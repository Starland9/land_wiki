part of 'wiki_bloc.dart';

abstract class WikiEvent extends Equatable {
  const WikiEvent();

  @override
  List<Object> get props => [];
}

class GetWiki extends WikiEvent {
  final String text;

  const GetWiki({required this.text});

  @override
  List<Object> get props => [text];
}
