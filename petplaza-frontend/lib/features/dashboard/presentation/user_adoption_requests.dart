import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petplaza/core/injection/dependency_injection.dart';

import '../bloc/user_adoption_requests/user_adoption_requests_bloc.dart';
import '../domain/user_adoption_requests/user_adoption_request_entity.dart';
import '../domain/user_adoption_requests/user_adoption_request_repo.dart';

class UserAdoptionRequestsScreen extends StatelessWidget {
  const UserAdoptionRequestsScreen({super.key, required this.token});
  final String token;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserAdoptionRequestsBloc(
        userAdoptionRequestRepository: sl<UserAdoptionRequestRepository>(),
      )..add(GetUserAdoptionRequests(token: token)),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurpleAccent,
          automaticallyImplyLeading: false,
          title: const Text('My Adoption Requests'),
        ),
        body: BlocBuilder<UserAdoptionRequestsBloc, UserAdoptionRequestsState>(
          builder: (context, state) {
            if (state is UserAdoptionRequestsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is UserAdoptionRequestsError) {
              return Center(child: Text('Error: ${state.message}'));
            } else if (state is UserAdoptionRequestsLoaded) {
              return _buildRequestsList(state.requests);
            }
            return const Center(child: Text('No adoption requests found'));
          },
        ),
      ),
    );
  }

  Widget _buildRequestsList(List<UserAdoptionRequestEntity> requests) {
    if (requests.isEmpty) {
      return const Center(child: Text('No adoption requests found'));
    }

    return ListView.builder(
      itemCount: requests.length,
      itemBuilder: (context, index) {
        final request = requests[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    if (request.pet.images.isNotEmpty)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          'http://localhost:5000${request.pet.images.first}',
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            request.pet.name,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text('${request.pet.petType} - ${request.pet.breed}'),
                          const SizedBox(height: 4),
                          Text(
                            'Status: ${request.status}',
                            style: TextStyle(
                              color: request.status == 'pending' ? Colors.orange : request.status == 'accepted' ? Colors.green : Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                if (request.note.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  const Text(
                    'Note:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(request.note),
                ],
                if (request.adoptionCentre != null) ...[
                  const SizedBox(height: 8),
                  const Text(
                    'Adoption Centre:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(request.adoptionCentre!.name),
                  Text(request.adoptionCentre!.location),
                  if (request.adoptionCentre!.contactNumber != null)
                    Text(request.adoptionCentre!.contactNumber!),
                  if (request.adoptionCentre!.email != null)
                    Text(request.adoptionCentre!.email!),
                  if (request.adoptionCentre!.contactAddress != null)
                    Text(request.adoptionCentre!.contactAddress!),
                ],
                const SizedBox(height: 8),
                Text(
                  'Requested on: ${request.createdAt.toString().split(' ')[0]}',
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}