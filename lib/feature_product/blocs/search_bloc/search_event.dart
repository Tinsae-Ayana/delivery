part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class SearchedEvent extends SearchEvent {
  const SearchedEvent({required this.searchKey});
  final String searchKey;
  @override
  List<Object> get props => [searchKey];
}
