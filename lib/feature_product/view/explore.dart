import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sura_online_shopping_admin/app/bloc/app_bloc.dart';
import 'package:sura_online_shopping_admin/commons/drawer/drawer.dart';
import 'package:sura_online_shopping_admin/feature_product/blocs/explore_bloc/explore_bloc.dart';
import 'package:sura_online_shopping_admin/feature_product/components/view_catagory.dart';
import 'package:sura_online_shopping_admin/feature_product/view/search.dart';
import 'package:sura_online_shopping_admin/feature_user/views/profile.dart';

class ExploreProducts extends StatefulWidget {
  const ExploreProducts({Key? key}) : super(key: key);

  @override
  State<ExploreProducts> createState() => _ExploreProductsState();
}

class _ExploreProductsState extends State<ExploreProducts>
    with SingleTickerProviderStateMixin {
  final PageController _controller = PageController();
  late final TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(vsync: this, length: 4);
    _tabController.addListener(() {
      debugPrint('========================================================>');
      debugPrint(_tabController.index.toString());
      BlocProvider.of<ExploreBloc>(context, listen: false)
          .add(CatagoryChangeEvent(catagory: _tabController.index));
    });

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerScreen(),
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        actions: [
          _action(context),
        ],
        leading: _leading(context),
        elevation: 0.0,
        backgroundColor: Theme.of(context).colorScheme.primary,
        centerTitle: true,
        title: _title(context),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          TabBar(
              indicatorColor: Theme.of(context).colorScheme.primary,
              unselectedLabelColor: Colors.grey,
              labelPadding: const EdgeInsets.all(3),
              controller: _tabController,
              tabs: [
                Text(
                  'All',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text('Shoes', style: Theme.of(context).textTheme.titleMedium),
                Text('Cosmotics',
                    style: Theme.of(context).textTheme.titleMedium),
                Text('Others', style: Theme.of(context).textTheme.titleMedium)
              ]),
          const SizedBox(height: 20),
          Expanded(
            child: TabBarView(controller: _tabController, children: const [
              ViewCatagory(),
              ViewCatagory(),
              ViewCatagory(),
              ViewCatagory()
            ]),
          )
        ]),
      ),
    );
  }

  Padding _action(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: (() {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const Profile();
          }));
        }),
        child: BlocBuilder<AppBloc, AppState>(
          builder: (context, state) {
            return context.read<AppBloc>().state.user.photo != null
                ? Center(
                    child: SizedBox(
                      width: 35,
                      height: 35,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: Image.network(
                            fit: BoxFit.cover,
                            context.read<AppBloc>().state.user.photo!),
                      ),
                    ),
                  )
                : const Icon(
                    Icons.account_circle_outlined,
                    color: Colors.black,
                  );
          },
        ),
      ),
    );
  }

  GestureDetector _title(BuildContext context) {
    return GestureDetector(
      onTap: (() {
        Navigator.of(context).push(MaterialPageRoute(builder: ((context) {
          return const Search();
        })));
      }),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Container(
            width: 250,
            height: 40,
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(30)),
            padding: const EdgeInsets.all(5),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Search Product',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.search,
                        color: Theme.of(context).colorScheme.onPrimary,
                        size: 25,
                      ))
                ])),
      ),
    );
  }

  Padding _leading(context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Builder(builder: (context) {
        return IconButton(
          color: Theme.of(context).colorScheme.onPrimary,
          iconSize: 10,
          icon: Image.asset(
            'assets/image/hamburger.png',
            height: 30,
            width: 30,
          ),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        );
      }),
    );
  }
}
