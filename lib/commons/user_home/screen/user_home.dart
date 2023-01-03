import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sura_online_shopping_admin/commons/drawer/drawer.dart';
import 'package:sura_online_shopping_admin/commons/user_home/bloc/user_home_bloc.dart';
import 'package:sura_online_shopping_admin/feature_product/blocs/cart_bloc/cart_bloc.dart';
import 'package:sura_online_shopping_admin/feature_product/blocs/explore_bloc/explore_bloc.dart';
import 'package:sura_online_shopping_admin/feature_product/view/cart.dart';
import 'package:sura_online_shopping_admin/feature_product/view/explore.dart';
import 'package:sura_online_shopping_admin/repository/services.dart';

class UserHome extends StatefulWidget {
  const UserHome({super.key});

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  final screens = const <Widget>[ExploreProducts(), CartScreen()];
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ExploreBloc>(
            create: (context) =>
                ExploreBloc(services: context.read<Services>())),
        BlocProvider<UserHomeBloc>(create: (context) => UserHomeBloc()),
        BlocProvider(
            create: (context) => CartBloc(services: context.read<Services>()))
      ],
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        drawer: const DrawerScreen(),
        body: BlocBuilder<UserHomeBloc, UserHomeState>(
          builder: (context, state) {
            return IndexedStack(index: state.tab, children: screens);
          },
        ),
        bottomNavigationBar: BlocBuilder<UserHomeBloc, UserHomeState>(
          builder: (context, state) {
            return BottomNavigationBar(
              currentIndex: state.tab,
              backgroundColor: Theme.of(context).colorScheme.surface,
              selectedItemColor: Theme.of(context).colorScheme.primary,
              unselectedItemColor: Theme.of(context).colorScheme.onSurface,
              selectedLabelStyle: Theme.of(context).textTheme.titleSmall,
              unselectedLabelStyle: Theme.of(context).textTheme.titleSmall,
              onTap: ((value) {
                context.read<UserHomeBloc>().add(TabChangeUser(tab: value));
              }),
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home), label: 'Explore'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.shopping_cart), label: 'Cart'),
              ],
            );
          },
        ),
      ),
    );
  }
}
