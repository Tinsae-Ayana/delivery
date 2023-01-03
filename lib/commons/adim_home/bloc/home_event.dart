part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class TabChangeEvent extends HomeEvent {
  const TabChangeEvent({required this.tabIndex});
  final int tabIndex;
  @override
  List<Object> get props => [];
}
