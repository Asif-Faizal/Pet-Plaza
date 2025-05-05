import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:petplaza/features/dashboard/presentation/adoption_request_screen.dart';
import 'package:petplaza/features/dashboard/presentation/selectpettype.dart';
import 'package:petplaza/features/dashboard/presentation/profile.dart';

class Homescreen extends StatelessWidget {
  final String profilePic;
  final String name;
  final String token;
  
  // Accept profilePic as a parameter
   const Homescreen({super.key, required this.profilePic, required this.name, required this.token});
   
  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);

    // Carousel items: List of Widgets with images and text
    List<Widget> carouselItems = [
      _buildCarouselItem(
          'https://cdn.prod.website-files.com/66879649513e18c84fd87096/66879649513e18c84fd873ee_76f5bb_c39a6376a7cd472e91bc2e5d7c0115c9~mv2.webp',
          ''),
      _buildCarouselItem(
          'https://asset-cdn.campaignbrief.com/wp-content/uploads/2024/05/17104035/Adoptable-HERO-VISUAL-16x9.jpg',
          ''),
      _buildCarouselItem(
          'https://roiminds-1e808.kxcdn.com/wp-content/uploads/2024/05/Top-10-Facebook-Pet-Food-Products-Ads-with-Explanation-1024x576.png',
          ''),
    ];

    // Grid items with text and icons
    List<Map<String, dynamic>> gridItems = [
      {"icon": Icons.pets, "text": "Adopt Pets"},
      {"icon": Icons.favorite, "text": "Saved Pets"},
      {"icon": Icons.shopping_cart, "text": "Buy Accessories"},
      {"icon": Icons.sell, "text": "Adoption Requests"},
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(Colors.transparent),
              shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
                side: BorderSide(
                  width: 1,color: Colors.deepPurpleAccent
                )
              ))
            ),
            onPressed: (){},
           icon: Icon(Icons.notifications)),
        ],
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: InkWell(
            onTap: (){
              Navigator.push(context,
               MaterialPageRoute(builder: (context)=>Profile(name: name, profilePic: profilePic)));
            },
            child: CircleAvatar(
              backgroundImage: NetworkImage(profilePic),
              radius: 20,
            ),
          ),
        ),
        centerTitle: false,
        title: Text(name, style: theme.textTheme.bodyMedium),
      ),
      // Wrap the entire body with SingleChildScrollView
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min, // Prevent taking extra space
          children: [
            // Header Text
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: Text(
                "Find an Awesome Pet",
                style: theme.textTheme.labelMedium,
              ),
            ),
            // Carousel Slider
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0,vertical: 10),
              child: CarouselSlider(
                items: carouselItems,
                options: CarouselOptions(
                  height: 160,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  aspectRatio: 16 / 9,
                  autoPlayInterval: const Duration(seconds: 3),
                  viewportFraction: 0.8,
                ),
              ),
            ),
        
            // GridView with Different Icons and Button Functionality
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 15),
              child: GridView.builder(
                physics:
                    const NeverScrollableScrollPhysics(), // Disable Grid Scroll
                shrinkWrap: true, // Wrap content in Grid
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1,
                ),
                itemCount: gridItems.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      // Define actions based on index
                      switch (index) {
                        case 0:
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SelectPetTypePage(token: token)));
                          break;
                        case 1:
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SelectPetTypePage(token: token)));
                          break;
                        case 2:
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SelectPetTypePage(token: token)));
                          break;
                        case 3:
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AdoptionRequestScreen()));
                          break;
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.deepPurpleAccent.withOpacity(0.6),
                            offset: const Offset(2, 3),
                          ),
                        ],
                      ),
                      margin: const EdgeInsets.all(2),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            gridItems[index]["icon"],
                            size: 40,
                            color: Colors.black,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            gridItems[index]["text"],
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // Helper method to create carousel item with image and text
  Widget _buildCarouselItem(String imagePath, String title) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        image: DecorationImage(
          image: NetworkImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(12),
        alignment: Alignment.bottomCenter,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            colors: [
              Colors.black.withOpacity(0.1),
              Colors.black.withOpacity(0.1),
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
      ),
    );
  }
}
