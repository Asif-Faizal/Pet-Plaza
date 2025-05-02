import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/bloc/pet_bloc.dart';
import '../domain/pet_entity.dart';
import 'petdetails_screen.dart';

class Adoptpets extends StatefulWidget {
  const Adoptpets({super.key, required this.petType});
  final String petType;

  @override
  State<Adoptpets> createState() => _AdoptpetsState();
}

class _AdoptpetsState extends State<Adoptpets> {
  @override
  void initState() {
    super.initState();
    // Trigger initial load or filtered load based on petType
    if (widget.petType.isEmpty) {
      context.read<PetBloc>().add(LoadInitialPets());
    } else {
      context.read<PetBloc>().add(GetFilteredPets(
            petType: widget.petType,
            status: '',
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.petType.isEmpty ? 'All Pets' : widget.petType,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocBuilder<PetBloc, PetState>(
        builder: (context, state) {
          if (state is PetLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PetError) {
            return Center(child: Text('Error: ${state.message}'));
          } else if (state is PetLoaded) {
            return _buildPetGrid(state.pets);
          }
          return const Center(child: Text('No pets available'));
        },
      ),
    );
  }

  Widget _buildPetGrid(List<Pet> pets) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.8,
        ),
        itemCount: pets.length,
        itemBuilder: (context, index) {
          final pet = pets[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PetDetailsScreen(pet: pet),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.deepPurple, width: 2),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(15)),
                      child: pet.imageUrls.isNotEmpty
                          ? Image.network(
                              pet.imageUrls.first,
                              fit: BoxFit.cover,
                              width: double.infinity,
                            )
                          : Container(
                              color: Colors.grey[300],
                              child: const Icon(Icons.pets,
                                  size: 50, color: Colors.grey),
                            ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.deepPurpleAccent.withOpacity(0.5),
                      borderRadius: const BorderRadius.vertical(
                          bottom: Radius.circular(15)),
                    ),
                    child: Column(
                      children: [
                        Text(
                          pet.name,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        Text(
                          '${pet.breed} - ${pet.age} years',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 12, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}