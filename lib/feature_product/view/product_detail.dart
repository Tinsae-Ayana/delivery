import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:sura_online_shopping_admin/app/bloc/app_bloc.dart';
import 'package:sura_online_shopping_admin/commons/models/user.dart';
import 'package:sura_online_shopping_admin/feature_product/blocs/cart_bloc/cart_bloc.dart';
import 'package:sura_online_shopping_admin/feature_product/models/product.dart';

class ProductDetail extends StatelessWidget {
  ProductDetail({required this.product, super.key});
  final PageController _controller = PageController();
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text('Product Detail', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 10),
            Expanded(
              child: PageView.builder(
                controller: _controller,
                scrollDirection: Axis.horizontal,
                itemCount: product.productImages.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(left: 5, right: 5),
                    height: MediaQuery.of(context).size.height * 0.4,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(product.productImages[index],
                          fit: BoxFit.cover),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: SmoothPageIndicator(
                controller: _controller,
                count: product.productImages.length,
                effect: WormEffect(
                    activeDotColor: Theme.of(context).colorScheme.primary,
                    dotWidth: 10,
                    dotHeight: 10,
                    dotColor: Colors.blue),
              ),
            ),
            ListView(shrinkWrap: true, children: [
              Divider(
                thickness: 5,
                color: Theme.of(context).colorScheme.primary,
              ),
              ListTile(
                title: Text(product.productName,
                    style: Theme.of(context).textTheme.titleLarge),
                trailing: Text("${product.price.toString()}  Birrs",
                    style: Theme.of(context).textTheme.titleLarge),
              ),
              product.color != null
                  ? ListTile(
                      title: Text('Avaliable Color',
                          style: Theme.of(context).textTheme.titleLarge),
                      trailing: Text(product.color!,
                          style: Theme.of(context).textTheme.titleLarge),
                    )
                  : const SizedBox(),
              if (product.catagory == Catagory.shoes)
                ListTile(
                  title: Text(
                    'Size',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  trailing: Text(
                    product.size.toString(),
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                )
              else
                const SizedBox(),
              context.read<AppBloc>().state.user.type == UserType.admin
                  ? DeleteButton(product)
                  : AddToCart(product)
            ])
          ],
        ),
      ),
    );
  }
}

class AddToCart extends StatelessWidget {
  const AddToCart(this.product, {super.key});
  final Product product;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: (() {
        context.read<CartBloc>().add(ProductAdded(product: product));
      }),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        width: width * 0.9,
        height: height * 0.1,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Theme.of(context).colorScheme.primary,
        ),
        child: Center(
          child: Text(
            'Add To Cart',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
      ),
    );
  }
}

class DeleteButton extends StatelessWidget {
  const DeleteButton(this.product, {super.key});
  final Product product;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: (() {
        BlocProvider.of<AppBloc>(context)
            .services
            .deleteProduct(id: product.id);
        Navigator.pop(context);
      }),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        width: width * 0.9,
        height: height * 0.1,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Theme.of(context).colorScheme.primary,
        ),
        child: Center(
          child: Text(
            'Delete Product',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
      ),
    );
  }
}
