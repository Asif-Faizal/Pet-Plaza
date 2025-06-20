import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petplaza/features/dashboard/presentation/accesssories_details.dart';

import '../../../core/injection/dependency_injection.dart';
import '../bloc/pet_items/pet_items_bloc.dart';

class PetItemsScreen extends StatelessWidget {
  const PetItemsScreen({super.key, required this.token});
  final String token;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        automaticallyImplyLeading: false,
        title: Text(
          "Accessories",
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocProvider(
        create: (_) => sl<PetItemBloc>()..add(LoadPetItems()),
        child: BlocBuilder<PetItemBloc, PetItemState>(
          builder: (context, state) {
            if (state is PetItemLoading) {
              return Center(child: CircularProgressIndicator());
            }
            if (state is PetItemLoaded) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                child: RefreshIndicator(
                  onRefresh: () {
                    context.read<PetItemBloc>().add(LoadPetItems());
                    return Future.value();
                  },
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.72,
                    ),
                    itemCount: state.items.length,
                    itemBuilder: (context, index) {
                      final item = state.items[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AccesssoriesDetails(
                                        petItem: item,
                                        token: token,
                                      )));
                        },
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10)),
                                  child: Image.network(
                                    item.imageUrls.first,
                                    fit: BoxFit.cover,
                                    height: 140,
                                    width: double.infinity,
                                    loadingBuilder:
                                        (context, child, loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return Container(
                                        height: 140,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: Colors.grey[300],
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Center(
                                          child: CircularProgressIndicator(
                                            value: loadingProgress
                                                        .expectedTotalBytes !=
                                                    null
                                                ? loadingProgress
                                                        .cumulativeBytesLoaded /
                                                    loadingProgress
                                                        .expectedTotalBytes!
                                                : null,
                                          ),
                                        ),
                                      );
                                    },
                                    errorBuilder: (context, error, stackTrace) {
                                      print(
                                          'Image load error: $error'); // For debugging
                                      return Image.asset(
                                        'lib/core/asset/animation/dog_food.jpg',
                                        fit: BoxFit.cover,
                                        height: 140,
                                        width: double.infinity,
                                      );
                                    },
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(item.name),
                                Text('\$${item.price}'),
                                Text('${item.petType} - ${item.category}'),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            }
            if (state is PetItemError) return Text(state.message);
            return Container();
          },
        ),
      ),
    );
  }
}
