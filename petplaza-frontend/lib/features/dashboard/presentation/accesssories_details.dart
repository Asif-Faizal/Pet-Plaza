import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petplaza/features/dashboard/bloc/add_to_cart/add_to_cart_bloc.dart';

import '../../../core/injection/dependency_injection.dart';
import '../bloc/get_cart_items/get_cart_items_bloc.dart' as GetCartBloc;
import '../domain/pet_items/pet_items_entity.dart';
import 'cart_screen.dart';

class AccesssoriesDetails extends StatefulWidget {
  const AccesssoriesDetails(
      {super.key, required this.petItem, required this.token});
  final PetItem petItem;
  final String token;

  @override
  State<AccesssoriesDetails> createState() => _AccesssoriesDetailsState();
}

class _AccesssoriesDetailsState extends State<AccesssoriesDetails> {
  double currentRating = 0.0;

  @override
  void initState() {
    super.initState();
    // If your PetItem entity has a rating field, initialize it here
    // currentRating = widget.petItem.rating ?? 0.0;
  }

  Widget buildStarRating() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              currentRating = index + 1.0;
            });
          },
          child: Icon(
            index < currentRating ? Icons.star : Icons.star_border,
            color: Colors.amber,
            size: 30,
          ),
        );
      }),
    );
  }

  Widget buildDisplayRating(double rating) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        if (index < rating.floor()) {
          return const Icon(Icons.star, color: Colors.amber, size: 20);
        } else if (index < rating) {
          return const Icon(Icons.star_half, color: Colors.amber, size: 20);
        } else {
          return const Icon(Icons.star_border, color: Colors.amber, size: 20);
        }
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => sl<AddToCartBloc>(),
        ),
        BlocProvider(
          create: (_) => sl<GetCartBloc.GetCartItemsBloc>()..add(GetCartBloc.GetCartItems(widget.token)),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurpleAccent,
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: const Text(
            "Accessories",
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        body: MultiBlocListener(
          listeners: [
            BlocListener<AddToCartBloc, AddToCartState>(
              listener: (context, state) {
                if (state is CartLoaded) {
                                     // Refresh cart items when item is added
                   context.read<GetCartBloc.GetCartItemsBloc>().add(GetCartBloc.GetCartItems(widget.token));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Item added to cart successfully!'),
                      backgroundColor: Colors.green,
                    ),
                  );
                } else if (state is CartError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Error: ${state.message}'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
            ),
          ],
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image with rounded corners
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      widget.petItem.imageUrls.first,
                      fit: BoxFit.cover,
                      height: 250,
                      width: double.infinity,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(
                          height: 250,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          ),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) {
                        print('Image load error: $error');
                        return Container(
                          height: 250,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Image.asset(
                            'lib/core/asset/animation/dog_food.jpg',
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Product name
                  Center(
                    child: Text(
                      widget.petItem.name,
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 15),

                  // Price and Stock
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${widget.petItem.price}',
                        style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.green),
                      ),
                      Container(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: widget.petItem.stock > 10
                              ? Colors.green[100]
                              : Colors.red[100],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '${widget.petItem.stock} in stock',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: widget.petItem.stock > 10
                                  ? Colors.green[700]
                                  : Colors.red[700]),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Current Rating Display (if you have existing ratings)
                  Row(
                    children: [
                      const Text(
                        '',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      buildDisplayRating(
                          4.2), // Replace with actual rating from your entity
                      const SizedBox(width: 8),
                      const Text(
                        '(4.2)',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),

                  // Description
                  const Text(
                    'Description:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.petItem.description,
                    style: const TextStyle(fontSize: 16, height: 1.5),
                  ),
                  const SizedBox(height: 15),

                  // Pet Type
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.blue[200]!),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.pets, color: Colors.blue[700], size: 24),
                        const SizedBox(width: 10),
                        Text(
                          "Suitable for ${widget.petItem.petType}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.blue[700],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 100), // Space for bottom button
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, -3),
              ),
            ],
          ),
          child: SafeArea(
            child: BlocBuilder<GetCartBloc.GetCartItemsBloc, GetCartBloc.GetCartItemsState>(
              builder: (context, cartState) {
                // Check if this specific item is in the cart
                bool isItemInCart = false;
                if (cartState is GetCartBloc.CartLoaded) {
                  isItemInCart = cartState.cart.items.any(
                    (cartItem) => cartItem.product.id == widget.petItem.id,
                  );
                }

                return BlocBuilder<AddToCartBloc, AddToCartState>(
                  builder: (context, addToCartState) {
                    if (addToCartState is CartLoading) {
                      return Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.deepPurpleAccent),
                          ),
                        ),
                      );
                    }

                    if (isItemInCart) {
                      return ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => CartScreen(token: widget.token),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 2,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.check_circle, size: 20),
                            SizedBox(width: 8),
                            Text(
                              'View in Cart',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      );
                    }

                    return ElevatedButton(
                      onPressed: widget.petItem.stock > 0
                          ? () {
                              context
                                  .read<AddToCartBloc>()
                                  .add(AddToCart(widget.petItem.id, 1, widget.token));
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: widget.petItem.stock > 0
                            ? Colors.deepPurpleAccent
                            : Colors.grey,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 2,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            widget.petItem.stock > 0
                                ? Icons.add_shopping_cart
                                : Icons.remove_shopping_cart,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            widget.petItem.stock > 0 ? 'Add to Cart' : 'Out of Stock',
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
