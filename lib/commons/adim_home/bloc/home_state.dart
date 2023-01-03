part of 'home_bloc.dart';

class HomeState extends Equatable {
  const HomeState({int? tab}) : tabIndex = tab ?? 0;

  final int tabIndex;

  @override
  List<Object> get props => [tabIndex];
}
