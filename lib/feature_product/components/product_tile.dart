import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sura_online_shopping_admin/app/bloc/app_bloc.dart';
import 'package:sura_online_shopping_admin/commons/models/user.dart';
import 'package:sura_online_shopping_admin/feature_product/blocs/cart_bloc/cart_bloc.dart';
import 'package:sura_online_shopping_admin/feature_product/blocs/explore_bloc/explore_bloc.dart';

class ProductTile extends StatelessWidget {
  const ProductTile({
    required this.state,
    required this.index,
    Key? key,
  }) : super(key: key);

  final int index;
  final ExploreState state;

  @override
  Widget build(BuildContext context) {
    final userType = context.read<AppBloc>().state.user.type;
    return Card(
      color: Theme.of(context).colorScheme.surface,
      elevation: 2.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 170,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                state.product[index].productImages[0],
                fit: BoxFit.fill,
              ),
            ),
          ),
          Column(
            children: [
              ListTile(
                title: Text(state.product[index].productName),
                subtitle: Text(state.product[index].price.toString()),
                trailing: userType == UserType.admin
                    ? Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Theme.of(context).colorScheme.secondary),
                        child: IconButton(
                            icon: const Icon(Icons.delete, size: 22),
                            onPressed: (() {
                              BlocProvider.of<ExploreBloc>(context,
                                      listen: false)
                                  .services
                                  .deleteProduct(id: state.product[index].id);
                            })),
                      )
                    : Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Theme.of(context).colorScheme.secondary),
                        child: IconButton(
                            onPressed: () {
                              BlocProvider.of<CartBloc>(context).add(
                                  ProductAdded(product: state.product[index]));
                            },
                            icon: const Icon(Icons.add))),
              ),
            ],
          )
        ],
      ),
    );
  }
}
