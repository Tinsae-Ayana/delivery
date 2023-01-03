import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sura_online_shopping_admin/feature_product/models/product.dart';
import 'package:sura_online_shopping_admin/repository/services.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc({required this.services})
      : super(const SearchedData(searchedData: <Product>[])) {
    on<SearchedEvent>(_onSearch);
  }
  final Services services;
  _onSearch(event, emit) async {
    final products = await services.search(searchKey: event.searchKey);
    emit(SearchedData(searchedData: products));
  }
}
