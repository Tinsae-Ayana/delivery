part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState(this.searchedData);
  final List<Product> searchedData;

  @override
  List<Object> get props => [searchedData];
}

class SearchedData extends SearchState {
  const SearchedData({required searchedData}) : super(searchedData);
}
