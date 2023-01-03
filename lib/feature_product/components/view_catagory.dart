import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sura_online_shopping_admin/feature_product/blocs/explore_bloc/explore_bloc.dart';
import 'package:sura_online_shopping_admin/feature_product/components/product_tile.dart';
import 'package:sura_online_shopping_admin/feature_product/view/product_detail.dart';

class ViewCatagory extends StatelessWidget {
  const ViewCatagory({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExploreBloc, ExploreState>(
      builder: (context, state) {
        if (state.product.isEmpty) {
          return const Center(child: Text('No prooduct available'));
        } else {
          return GridView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: state.product.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 1 / 1.5,
                mainAxisSpacing: 5,
                crossAxisSpacing: 5,
                crossAxisCount: 2),
            itemBuilder: ((context, index) {
              return GestureDetector(
                  onTap: (() {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: ((context) =>
                            ProductDetail(product: state.product[index]))));
                  }),
                  child: ProductTile(state: state, index: index));
            }),
          );
        }
      },
    );
  }
}
