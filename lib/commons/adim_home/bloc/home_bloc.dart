import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState()) {
    on<TabChangeEvent>(_onTabChange);
  }

  _onTabChange(event, emit) {
    emit(HomeState(tab: event.tabIndex));
  }
}
