import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petplaza/features/dashboard/presentation/adoptpets.dart';
import '../bloc/bloc/pet_bloc.dart';

class SelectPetTypePage extends StatefulWidget {
  const SelectPetTypePage({super.key});

  @override
  State<SelectPetTypePage> createState() => _SelectPetTypePageState();
}

class _SelectPetTypePageState extends State<SelectPetTypePage> {
  final List<Map<String, String>> pets = [
    {
      "name": "Dog",
      "image":
          "https://media.graphassets.com/resize=height:360,width:938/output=format:webp/euPC3XglRIy8o5OmqUCg?width=938"
    },
    {
      "name": "Cat",
      "image":
          "https://cdn.britannica.com/39/226539-050-D21D7721/Portrait-of-a-cat-with-whiskers-visible.jpg"
    },
    {
      "name": "Bird",
      "image":
          "https://cdn.britannica.com/10/250610-050-BC5CCDAF/Zebra-finch-Taeniopygia-guttata-bird.jpg"
    },
    {
      "name": "Fish",
      "image":
          "https://cdn.britannica.com/34/240534-050-B8C4B11E/Porcupine-fish-Diodon-hystox.jpg"
    },
    {
      "name": "Rabbit",
      "image":
          "https://ptes.org/wp-content/uploads/2014/06/rabbit-e1403800396624.jpg"
    },
  ];

  void _onPetTap(String name) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => BlocProvider.value(
          value: context.read<PetBloc>(),
          child: Adoptpets(petType: name),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox.shrink(),
        backgroundColor: Colors.deepPurpleAccent,
        title: const Text(
          "Adopt Pets",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                itemCount: pets.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 0.8,
                ),
                itemBuilder: (context, index) {
                  final pet = pets[index];
                  return GestureDetector(
                    onTap: () => _onPetTap(pet['name']!),
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
                              child: Image.network(
                                pet['image']!,
                                fit: BoxFit.cover,
                                width: double.infinity,
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
                            child: Text(
                              pet['name']!,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => BlocProvider.value(
                        value: context.read<PetBloc>(),
                        child: const Adoptpets(petType: ''),
                      ),
                    ),
                  );
                },
                child: const Text("View All Pets"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



// import 'package:flutter/material.dart';

// class SelectPetTypePage extends StatefulWidget {
//   const SelectPetTypePage({super.key});

//   @override
//   State<SelectPetTypePage> createState() => _SelectPetTypePageState();
// }

// class _SelectPetTypePageState extends State<SelectPetTypePage> {
//   // List of different category names
//   final List<String> categoryNames = [
//     "Dogs",
//     "Cats",
//     "Birds",
//     "Rabbits",
//     "Fish"
//   ];

//   // Default selected category
//   String selectedCategory = "Dogs";

//   // Map of category items with corresponding images and names
//   final Map<String, List<Map<String, String>>> categoryItems = {
    
//     "Dogs": [
//       {
//         "image":
//             "https://media.graphassets.com/resize=height:360,width:938/output=format:webp/euPC3XglRIy8o5OmqUCg?width=938",
//         "name": "Max"
//       },
//     ],
//     "Cats": [
//       {
//         "image":
//             "https://cdn.britannica.com/39/226539-050-D21D7721/Portrait-of-a-cat-with-whiskers-visible.jpg",
//         "name": "Tommy"
//       },
//     ],
//     "Birds": [
//       {
//         "image":
//             "https://cdn.britannica.com/10/250610-050-BC5CCDAF/Zebra-finch-Taeniopygia-guttata-bird.jpg",
//         "name": "Polly"
//       },
//     ],
//     "Rabbits": [
//       {
//         "image":
//             "https://ptes.org/wp-content/uploads/2014/06/rabbit-e1403800396624.jpg",
//         "name": "Bunny"
//       },
//     ],
//     "Fish": [
//       {
//         "image":
//             "https://cdn.britannica.com/34/240534-050-B8C4B11E/Porcupine-fish-Diodon-hystox.jpg",
//         "name": "Nemo"
//       },
//     ],
//   };

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           "SelectPetTypePage",
//           style: TextStyle(
//               color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
//         ),
//         backgroundColor: Colors.deepPurpleAccent.withOpacity(0.2),
//         automaticallyImplyLeading: false,
//         centerTitle: true,
//       ),
//       body: Column(
//         children: [
//           const SizedBox(height: 10),
//           // Horizontal Scrollable Row with small gap
//           SingleChildScrollView(
//             scrollDirection: Axis.horizontal,
//             child: Row(
//               children: List.generate(categoryNames.length, (index) {
//                 return Row(
//                   children: [
//                     GestureDetector(
//                       onTap: () {
//                         // Update selected category when tapped
//                         setState(() {
//                           selectedCategory = categoryNames[index];
//                         });
//                       },
//                       child: _buildContainer(
//                           categoryNames[index],
//                           selectedCategory == categoryNames[index]),
//                     ),
//                     const SizedBox(width: 8), // Small gap
//                   ],
//                 );
//               }),
//             ),
//           ),
//           const SizedBox(height: 10),
//           // Expanded GridView
//           Expanded(
//             child: GridView.builder(
//               padding: const EdgeInsets.all(12.0),
//               itemCount: categoryItems[selectedCategory]!.length,
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2, // 2 items per row
//                 crossAxisSpacing: 12,
//                 mainAxisSpacing: 12,
//                 childAspectRatio: 0.9, // Image + Text height
//               ),
//               itemBuilder: (context, index) {
//                 final pet = categoryItems[selectedCategory]![index];
//                 return GestureDetector(
//                   onTap: () {
//                     // Navigate to detail page when tapped
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => PetDetailsPage(
//                           name: pet['name']!,
//                           imageUrl: pet['image']!,
//                         ),
//                       ),
//                     );
//                   },
//                   child: _buildGridItem(pet['image']!, pet['name']!),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//       // Floating Action Button to add new pet
//       floatingActionButton: FloatingActionButton(
//         onPressed: () async {
//           final newPet = await Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => AddPetPage(category: selectedCategory),
//             ),
//           );
//           if (newPet != null) {
//             setState(() {
//               categoryItems[selectedCategory]!.add(newPet);
//             });
//           }
//         },
//         backgroundColor: Colors.deepPurple,
//         child: const Icon(Icons.add),
//       ),
//     );
//   }

//   // Build Category Container with name and selected state
//   Widget _buildContainer(String name, bool isSelected) {
//     return Container(
//       height: 50,
//       width: 120,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(100),
//         color: isSelected
//             ? Colors.deepPurple // Highlight if selected
//             : Colors.deepPurpleAccent.withOpacity(0.5),
//         border: Border.all(
//           color: Colors.deepPurple, // Border color
//           width: 2.0, // Border width
//         ),
//       ),
//       child: Center(
//         child: Text(
//           name,
//           style: const TextStyle(
//               color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
//         ),
//       ),
//     );
//   }

//   // Build Grid Item with image and text
//   Widget _buildGridItem(String imageUrl, String name) {
//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(15),
//         border: Border.all(color: Colors.deepPurple, width: 2),
//       ),
//       child: Column(
//         children: [
//           Expanded(
//             child: ClipRRect(
//               borderRadius:
//                   const BorderRadius.vertical(top: Radius.circular(15)),
//               child: Image.network(
//                 imageUrl,
//                 width: double.infinity,
//                 height: double.infinity,
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//           Container(
//             padding: const EdgeInsets.all(8),
//             width: double.infinity,
//             decoration: BoxDecoration(
//               color: Colors.deepPurpleAccent.withOpacity(0.5),
//               borderRadius:
//                   const BorderRadius.vertical(bottom: Radius.circular(15)),
//             ),
//             child: Text(
//               name,
//               textAlign: TextAlign.center,
//               style: const TextStyle(
//                   fontWeight: FontWeight.bold, color: Colors.white),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // Pet Details Page
// class PetDetailsPage extends StatelessWidget {
//   final String name;
//   final String imageUrl;

//   const PetDetailsPage({super.key, required this.name, required this.imageUrl});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text(name)),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Image.network(imageUrl, width: 300, height: 300),
//             const SizedBox(height: 20),
//             Text(
//               "Meet $name! Ready for adoption.",
//               style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // Add New Pet Form Page
// class AddPetPage extends StatefulWidget {
//   final String category;

//   const AddPetPage({super.key, required this.category});

//   @override
//   State<AddPetPage> createState() => _AddPetPageState();
// }

// class _AddPetPageState extends State<AddPetPage> {
//   final _formKey = GlobalKey<FormState>();
//   String petName = "";
//   String imageUrl = "";

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Add New Pet")),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               TextFormField(
//                 decoration:
//                     const InputDecoration(labelText: "Pet Name", hintText: "Enter pet name"),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return "Please enter the pet name.";
//                   }
//                   return null;
//                 },
//                 onSaved: (value) {
//                   petName = value!;
//                 },
//               ),
//               const SizedBox(height: 12),
//               TextFormField(
//                 decoration:
//                     const InputDecoration(labelText: "Image URL", hintText: "Enter image URL"),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return "Please enter an image URL.";
//                   }
//                   return null;
//                 },
//                 onSaved: (value) {
//                   imageUrl = value!;
//                 },
//               ),
//               const SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () {
//                   if (_formKey.currentState!.validate()) {
//                     _formKey.currentState!.save();
//                     Navigator.pop(
//                       context,
//                       {
//                         "name": petName,
//                         "image": imageUrl,
//                       },
//                     );
//                   }
//                 },
//                 child: const Text("Add Pet"),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
