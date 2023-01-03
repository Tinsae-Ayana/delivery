import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sura_online_shopping_admin/app/bloc/app_bloc.dart';
import 'package:sura_online_shopping_admin/feature_product/blocs/search_bloc/search_bloc.dart';
import 'package:sura_online_shopping_admin/feature_product/models/product.dart';
import 'package:sura_online_shopping_admin/feature_product/view/product_detail.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<SearchBloc>(
      lazy: false,
      create: (lovecontext) =>
          SearchBloc(services: context.read<AppBloc>().services),
      child: Scaffold(
          appBar: AppBar(
              elevation: 0.0,
              backgroundColor: Colors.white,
              leading: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: (() {
                    Navigator.pop(context);
                  })),
              title: BlocBuilder<SearchBloc, SearchState>(
                  builder: (context, state) {
                return TextField(
                  autofocus: true,
                  onChanged: ((value) {
                    context
                        .read<SearchBloc>()
                        .add(SearchedEvent(searchKey: value));
                  }),
                  decoration: const InputDecoration(
                      labelText: 'search',
                      labelStyle: TextStyle(color: Colors.black)),
                );
              })),
          body: Builder(builder: ((context) {
            return context.read<SearchBloc>().state.searchedData == <Product>[]
                ? const Center(child: Text('No Data'))
                : BlocBuilder<SearchBloc, SearchState>(
                    builder: (context, state) {
                    return ListView.builder(
                        itemCount: state.searchedData.length,
                        itemBuilder: ((context, index) {
                          return InkWell(
                            onTap: () => {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => ProductDetail(
                                          product: state.searchedData[index])))
                            },
                            child: ListTile(
                              leading: Image.network(
                                  state.searchedData[index].productImages[0]),
                              title:
                                  Text(state.searchedData[index].productName),
                              subtitle: Text(
                                  state.searchedData[index].price.toString()),
                            ),
                          );
                        }));
                  });
          }))),
    );
  }
}
