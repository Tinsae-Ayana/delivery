part of 'user_home_bloc.dart';

abstract class UserHomeEvent extends Equatable {
  const UserHomeEvent();

  @override
  List<Object> get props => [];
}

class TabChangeUser extends UserHomeEvent {
  const TabChangeUser({required this.tab});
  final int tab;
  @override
  List<Object> get props => [tab];
}
