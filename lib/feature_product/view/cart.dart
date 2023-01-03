import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sura_online_shopping_admin/app/bloc/app_bloc.dart';
import 'package:sura_online_shopping_admin/feature_product/blocs/cart_bloc/cart_bloc.dart';
import 'package:sura_online_shopping_admin/feature_product/models/product.dart';
import 'package:sura_online_shopping_admin/feature_product/view/product_detail.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: const Text('My Cart'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: BlocBuilder<CartBloc, CartState>(builder: ((context, state) {
        return state.orderedProduct.isEmpty
            ? const EmptyCart()
            : const CartPageBody();
      })),
    );
  }
}

class CartProductTile extends StatelessWidget {
  const CartProductTile(this.product, this.width, this.height, {super.key});
  final Product product;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ProductDetail(product: product);
        }));
      }),
      child: Container(
        width: width,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
        child: Card(
          elevation: 2,
          child: ListTile(
            leading: SizedBox(
              width: height * 0.15,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    product.productImages[0],
                    fit: BoxFit.cover,
                  )),
            ),
            title: Text(product.productName),
            subtitle: Text(product.price.toString()),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: (() {
                context.read<CartBloc>().add(ProductDeleted(product: product));
              }),
            ),
          ),
        ),
      ),
    );
  }
}

class CartPageBody extends StatelessWidget {
  const CartPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Stack(
      alignment: Alignment.center,
      fit: StackFit.expand,
      children: [
        BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            return ListView.builder(
                itemCount: state.orderedProduct.length,
                shrinkWrap: true,
                itemBuilder: ((context, index) {
                  return CartProductTile(
                      state.orderedProduct[index], width, height);
                }));
          },
        ),
        const Positioned(
          bottom: 10,
          child: OrderButton(),
        )
      ],
    );
  }
}

class EmptyCart extends StatelessWidget {
  const EmptyCart({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Your Cart Is Empty'));
  }
}

class OrderButton extends StatelessWidget {
  const OrderButton({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: (() {
        context
            .read<CartBloc>()
            .add(OrderEvent(userId: context.read<AppBloc>().state.user));
        showDialog(
            context: context, builder: ((context) => const OrderDialog()));
      }),
      child: Container(
        width: width * 0.9,
        height: height * 0.1,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Theme.of(context).colorScheme.primary,
        ),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            'Order Now',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const VerticalDivider(),
          BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              return Text(
                '${state.totalPrice} Birr',
                style: Theme.of(context).textTheme.titleMedium,
              );
            },
          )
        ]),
      ),
    );
  }
}

class OrderDialog extends StatelessWidget {
  const OrderDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: const Text('You have just ordered !'),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Ok'))
      ],
    );
  }
}
