import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/adoption_request/adoption_requests_bloc.dart';
import '../data/adoption_request/adoption_request_model.dart';
import '../domain/pet/pet_entity.dart';

class PetDetailsScreen extends StatelessWidget {
  final Pet pet;
  final String token;

  PetDetailsScreen({super.key, required this.pet, required this.token});
  final TextEditingController noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AdoptionRequestsBloc, AdoptionRequestsState>(
        listener: (context, state) {
          debugPrint(state.toString());
          if (state is AdoptionRequestSuccess) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                backgroundColor: Colors.green,
                behavior: SnackBarBehavior.floating,
                content: Text('Adoption request submitted successfully')),
            );
          }else if (state is AdoptionRequestFailure) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                backgroundColor: Colors.red,
                behavior: SnackBarBehavior.floating,
                content: Text('Adoption request failed')),
            );
          }
        },
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              leading: const SizedBox.shrink(),
              backgroundColor: Colors.transparent,
              expandedHeight: 300.0,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      pet.imageUrls.isNotEmpty ? pet.imageUrls.first : '',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: Colors.grey[300],
                        child: const Icon(Icons.pets,
                            size: 100, color: Colors.grey),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withValues(alpha: 0.7),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            pet.name,
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: _getStatusColor(pet.status),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            pet.status.toUpperCase(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${pet.breed} • ${pet.petType}',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildInfoSection(
                      icon: Icons.pets,
                      title: 'About',
                      content: pet.description,
                    ),
                    const SizedBox(height: 16),
                    _buildInfoSection(
                      icon: Icons.info,
                      title: 'Details',
                      content: '''
      • Gender: ${pet.gender}
      • Age: ${pet.age} years
      • Behavior: ${pet.behavior}
      ''',
                    ),
                    const SizedBox(height: 16),
                    _buildInfoSection(
                      icon: Icons.location_city,
                      title: 'Adoption Center',
                      content: '''
      ${pet.adoptionCentreName}
      ${pet.adoptionCentreLocation}
      ''',
                    ),
                    const SizedBox(height: 16),
                    _buildInfoSection(
                      icon: Icons.contact_phone,
                      title: 'Contact Information',
                      content: '''
      Owner: ${pet.ownerName}
      Phone: ${pet.contactNumber}
      Address: ${pet.contactAddress}
      ''',
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: pet.status == 'adopted' ? const SizedBox.shrink() : BottomAppBar(
        color: Colors.transparent,
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              showModalBottomSheet(
                isScrollControlled: true,
                showDragHandle: true,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                context: context,
                builder: (context) => SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Adoption Form',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          decoration: InputDecoration(
                            hintText: 'Name',
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          maxLines: 3,
                          controller: noteController,
                          decoration: InputDecoration(
                            hintText: 'Note',
                          ),
                        ),
                        const SizedBox(height: 30),
                        SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(onPressed: () {
                              context.read<AdoptionRequestsBloc>().add(
                                  SubmitAdoptionRequest(
                                      request: AdoptionRequestModel(
                                          petId: pet.id,
                                          note: noteController.text),
                                      token: token));
                            }, child: BlocBuilder<AdoptionRequestsBloc,
                                AdoptionRequestsState>(
                              builder: (context, state) {
                                if (state is AdoptionRequestLoading) {
                                  return SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: const CircularProgressIndicator());
                                }
                                return const Text('Submit');
                              },
                            )))
                      ],
                    ),
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              backgroundColor: Colors.deepPurpleAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Adopt Me',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoSection({
    required IconData icon,
    required String title,
    required String content,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.deepPurple),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'available':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'adopted':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
