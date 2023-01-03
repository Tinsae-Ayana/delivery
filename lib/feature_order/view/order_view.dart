import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sura_online_shopping_admin/feature_order/models/order.dart';
import '../blocs/order_bloc/order_bloc.dart';

class OrderView extends StatelessWidget {
  const OrderView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Orders'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: BlocBuilder<OrderBloc, OrderState>(
        builder: (context, state) {
          return state.orders.isEmpty ? const EmptyOrder() : OrderBody(state);
        },
      ),
    );
  }
}

class EmptyOrder extends StatelessWidget {
  const EmptyOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('No Orders Yet'));
  }
}

class OrderBody extends StatelessWidget {
  const OrderBody(
    this.state, {
    Key? key,
  }) : super(key: key);
  final OrderState state;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return SizedBox(
      width: width,
      height: height,
      child: ListView.builder(
          physics: const ClampingScrollPhysics(),
          shrinkWrap: true,
          itemCount: state.orders.length,
          itemBuilder: ((context, index) => OrderTile(state.orders[index]))),
    );
  }
}

class OrderTile extends StatelessWidget {
  const OrderTile(this.order, {super.key});
  final Order order;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Dismissible(
      key: ValueKey(order),
      onDismissed: ((direction) {
        context.read<OrderBloc>().add(OrderDeletedEvent(order: order));
      }),
      child: SizedBox(
          height: height * 0.2,
          width: width,
          child: Card(
            elevation: 8,
            margin:
                const EdgeInsets.only(left: 5, right: 5, top: 10, bottom: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ListTile(
                  leading: const Icon(Icons.supervised_user_circle_rounded),
                  title: Text(
                    order.user.name,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  subtitle: Text(order.user.phoneNumber.value,
                      style: Theme.of(context).textTheme.titleMedium),
                  trailing: Text('200',
                      style: Theme.of(context).textTheme.titleLarge),
                ),
                Expanded(
                  child: Center(
                      child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary),
                    child: Text(
                      'Products',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (context) => ProductSheet(order: order));
                    },
                  )),
                )
              ],
            ),
          )),
    );
  }
}

class ProductSheet extends StatelessWidget {
  const ProductSheet({
    Key? key,
    required this.order,
  }) : super(key: key);

  final Order order;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: order.products.length,
        itemBuilder: ((context, index) {
          return Card(
            elevation: 4,
            child: ListTile(
              leading: SizedBox(
                  height: 40,
                  width: 40,
                  child: Image.network(
                    order.products[index].productImages[0],
                    fit: BoxFit.cover,
                  )),
              title: Text(order.products[index].productName,
                  style: Theme.of(context).textTheme.titleLarge),
              trailing: Text(
                order.products[index].price.toString(),
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          );
        }));
  }
}
