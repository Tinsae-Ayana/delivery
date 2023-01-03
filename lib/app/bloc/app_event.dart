part of 'app_bloc.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object> get props => [];
}

class UserChangeEvent implements AppEvent {
  UserChangeEvent({required this.user});
  final User user;
  @override
  List<Object> get props => [user];

  @override
  bool? get stringify => true;
}

class IntConStatusChangeEvent implements AppEvent {
  IntConStatusChangeEvent({required this.isConnectedToInternet});

  final bool isConnectedToInternet;
  @override
  List<Object> get props => [];

  @override
  bool? get stringify => true;
}

class ThemeModeChangeEvent implements AppEvent {
  ThemeModeChangeEvent({required this.themeMode});
  final ThemeMode themeMode;

  @override
  List<Object> get props => [themeMode];

  @override
  bool? get stringify => true;
}

class LogOutEvent extends AppEvent {}
