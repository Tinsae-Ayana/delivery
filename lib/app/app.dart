import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:sura_online_shopping_admin/feature_authentication/blocs/login_bloc/login_bloc.dart';
import 'package:sura_online_shopping_admin/feature_user/blocs/bloc/profile_bloc.dart';
import 'package:sura_online_shopping_admin/utils/my_theme.dart';
import 'package:sura_online_shopping_admin/repository/services.dart';
import 'package:sura_online_shopping_admin/commons/splash/splash.dart';
import 'bloc/app_bloc.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final services = Services();
    return RepositoryProvider.value(
      value: services,
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AppBloc>(
              create: (context) => AppBloc(services: services)),
          BlocProvider<ProfileBloc>(
              create: (context) => ProfileBloc(services: services)),
          BlocProvider<LoginBloc>(
              create: (context) =>
                  LoginBloc(services: context.read<Services>())),
        ],
        child: const OverlaySupport.global(
          child: RootWidget(),
        ),
      ),
    );
  }
}

class RootWidget extends StatelessWidget {
  const RootWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          darkTheme: MyTheme.dark,
          theme: MyTheme.light,
          themeMode: state.themeMode,
          home: const Splash(),
        );
      },
    );
  }
}
