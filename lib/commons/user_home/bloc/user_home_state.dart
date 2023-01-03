part of 'user_home_bloc.dart';

class UserHomeState extends Equatable {
  const UserHomeState({required this.tab});
  final int tab;

  @override
  List<Object> get props => [tab];
}
