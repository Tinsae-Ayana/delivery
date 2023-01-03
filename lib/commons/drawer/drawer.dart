import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sura_online_shopping_admin/app/bloc/app_bloc.dart';
import 'package:sura_online_shopping_admin/feature_user/views/profile.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({super.key});

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  bool _darkMode(context) {
    if (BlocProvider.of<AppBloc>(context).state.themeMode == ThemeMode.dark) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: ListView(
        children: [
          DrawerHeader(
              decoration:
                  BoxDecoration(color: Theme.of(context).colorScheme.primary),
              child: Center(
                child: GestureDetector(
                    onTap: (() {
                      Navigator.push(context,
                          MaterialPageRoute(builder: ((context) {
                        return const Profile();
                      })));
                    }),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(60),
                            child: context.read<AppBloc>().state.user.photo !=
                                    null
                                ? Image.network(
                                    context.read<AppBloc>().state.user.photo!,
                                    fit: BoxFit.cover,
                                    width: 100,
                                    height: 100,
                                  )
                                : Image.asset(
                                    'assets/image/man.png',
                                    width: 100,
                                    height: 100,
                                  )),
                        const SizedBox(height: 10),
                        Text(
                          context.read<AppBloc>().state.user.name,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary),
                        )
                      ],
                    )),
              )),
          const SizedBox(height: 10),
          ListTile(
              leading: _darkMode(context)
                  ? Icon(
                      Icons.nights_stay,
                      color: Theme.of(context).colorScheme.onBackground,
                    )
                  : Icon(
                      Icons.sunny,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              title: const Text('Dark Mode'),
              trailing: Switch(
                value: _darkMode(context),
                onChanged: ((value) {
                  value
                      ? context
                          .read<AppBloc>()
                          .add(ThemeModeChangeEvent(themeMode: ThemeMode.dark))
                      : context.read<AppBloc>().add(
                          ThemeModeChangeEvent(themeMode: ThemeMode.light));
                }),
              ))
        ],
      ),
    );
  }
}
