part of 'app_bloc.dart';

class AppState extends Equatable {
  const AppState(
      {required this.user,
      required this.intConStatus,
      required this.themeMode});

  final User user;
  final bool intConStatus;
  final ThemeMode themeMode;

  AppState copyWith({User? user, bool? intConStatus, themeMode}) {
   
    return AppState(
        user: user ?? this.user,
        intConStatus: intConStatus ?? this.intConStatus,
        themeMode: themeMode ?? this.themeMode);
  }

  @override
  List<Object> get props => [user, intConStatus, themeMode];
}
