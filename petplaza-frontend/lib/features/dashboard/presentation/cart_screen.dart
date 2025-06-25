import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/injection/dependency_injection.dart';
import '../bloc/get_cart_items/get_cart_items_bloc.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key, required this.token});
  final String token;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<GetCartItemsBloc>()..add(GetCartItems(token)),
      child: const CartView(),
    );
  }
}

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        automaticallyImplyLeading: false,
        title: const Text("Your Cart",style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)),
      body: BlocBuilder<GetCartItemsBloc, GetCartItemsState>(
        builder: (context, state) {
          if (state is CartLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CartLoaded) {
            return ListView.builder(
              itemCount: state.cart.items.length,
              itemBuilder: (context, index) {
                final item = state.cart.items[index];
                return ListTile(
                  leading: Image.network(
                    'https://yourapi.com${item.product.images.first}',
                    width: 60,
                    errorBuilder: (_, __, ___) => const Icon(Icons.error),
                  ),
                  title: Text(item.product.name),
                  subtitle: Text(
                      '${item.quantity} x \$${item.price.toStringAsFixed(2)}'),
                  trailing: Text(
                    '\$${(item.price * item.quantity).toStringAsFixed(2)}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                );
              },
            );
          } else if (state is CartError) {
            return Center(child: Text(state.message));
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}

