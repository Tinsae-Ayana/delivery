import 'package:flutter/material.dart';
import 'package:sura_online_shopping_admin/commons/adim_home/bloc/home_bloc.dart';
import 'package:sura_online_shopping_admin/commons/drawer/drawer.dart';
import 'package:sura_online_shopping_admin/feature_order/blocs/order_bloc/order_bloc.dart';
import 'package:sura_online_shopping_admin/feature_order/view/order_view.dart';
import 'package:sura_online_shopping_admin/feature_product/blocs/explore_bloc/explore_bloc.dart';
import 'package:sura_online_shopping_admin/feature_product/view/explore.dart';
import 'package:sura_online_shopping_admin/feature_product/view/post_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sura_online_shopping_admin/repository/services.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final screens = const [ExploreProducts(), OrderView()];

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ExploreBloc>(
            create: (context) =>
                ExploreBloc(services: context.read<Services>())),
        BlocProvider<HomeBloc>(create: (context) => HomeBloc()),
        BlocProvider(
            create: (context) => OrderBloc(services: context.read<Services>())
              ..add(LoadOrders()))
      ],
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return Scaffold(
              backgroundColor: Theme.of(context).colorScheme.background,
              drawer: const DrawerScreen(),
              floatingActionButton: FloatingActionButton(
                backgroundColor: Theme.of(context).colorScheme.secondary,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PostScreen()));
                },
                child: Icon(Icons.post_add,
                    color: Theme.of(context).colorScheme.onSecondary),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              body: IndexedStack(
                index: context.read<HomeBloc>().state.tabIndex,
                children: screens,
              ),
              bottomNavigationBar: BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  return BottomNavigationBar(
                      currentIndex: state.tabIndex,
                      elevation: 8,
                      backgroundColor: Theme.of(context).colorScheme.surface,
                      selectedItemColor: Theme.of(context).colorScheme.primary,
                      unselectedItemColor:
                          Theme.of(context).colorScheme.onSurface,
                      selectedLabelStyle:
                          Theme.of(context).textTheme.titleSmall,
                      unselectedLabelStyle:
                          Theme.of(context).textTheme.titleSmall,
                      onTap: (value) => context
                          .read<HomeBloc>()
                          .add(TabChangeEvent(tabIndex: value)),
                      items: const [
                        BottomNavigationBarItem(
                            icon: Icon(Icons.home), label: 'Explore'),
                        BottomNavigationBarItem(
                            icon: Icon(Icons.list), label: 'Orders')
                      ]);
                },
              ));
        },
      ),
    );
  }
}
